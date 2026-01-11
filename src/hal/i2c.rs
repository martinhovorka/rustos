//! I2C driver for RustOS
//!
//! Provides I2C (Inter-Integrated Circuit) communication

/// I2C peripheral base address
const I2C_BASE: usize = 0x6004_0000;

/// I2C registers
#[repr(C)]
struct I2cRegisters {
    control: u32,       // Control register
    status: u32,        // Status register
    data: u32,          // Data register
    address: u32,       // Address register
    clock: u32,         // Clock control
}

/// I2C speed
#[derive(Debug, Clone, Copy)]
pub enum I2cSpeed {
    Standard,   // 100 kHz
    Fast,       // 400 kHz
    FastPlus,   // 1 MHz
}

/// I2C device
pub struct I2c {
    registers: *mut I2cRegisters,
}

impl I2c {
    /// Create a new I2C instance
    ///
    /// # Safety
    /// This function is unsafe because it creates a raw pointer to hardware registers
    pub const unsafe fn new(base_addr: usize) -> Self {
        Self {
            registers: base_addr as *mut I2cRegisters,
        }
    }

    /// Initialize I2C
    pub fn init(&mut self, speed: I2cSpeed) {
        unsafe {
            // Set clock frequency (assuming 100MHz system clock)
            let clock_div = match speed {
                I2cSpeed::Standard => 100_000_000 / 100_000,
                I2cSpeed::Fast => 100_000_000 / 400_000,
                I2cSpeed::FastPlus => 100_000_000 / 1_000_000,
            };
            (*self.registers).clock = clock_div;

            // Enable I2C
            (*self.registers).control = 0x80;
        }
    }

    /// Write data to I2C device
    pub fn write(&mut self, address: u8, data: &[u8]) -> Result<(), ()> {
        unsafe {
            // Send start condition
            (*self.registers).control |= 0x01;

            // Send address with write bit
            (*self.registers).address = (address << 1) as u32;
            self.wait_ready()?;

            // Check ACK
            if ((*self.registers).status & 0x02) != 0 {
                return Err(());
            }

            // Write data
            for &byte in data {
                (*self.registers).data = byte as u32;
                self.wait_ready()?;

                // Check ACK
                if ((*self.registers).status & 0x02) != 0 {
                    return Err(());
                }
            }

            // Send stop condition
            (*self.registers).control |= 0x02;
        }

        Ok(())
    }

    /// Read data from I2C device
    pub fn read(&mut self, address: u8, buffer: &mut [u8]) -> Result<(), ()> {
        unsafe {
            // Send start condition
            (*self.registers).control |= 0x01;

            // Send address with read bit
            (*self.registers).address = ((address << 1) | 0x01) as u32;
            self.wait_ready()?;

            // Check ACK
            if ((*self.registers).status & 0x02) != 0 {
                return Err(());
            }

            // Read data
            let len = buffer.len();
            for (i, byte) in buffer.iter_mut().enumerate() {
                self.wait_ready()?;
                *byte = ((*self.registers).data & 0xFF) as u8;

                // Send ACK for all but last byte
                if i < len - 1 {
                    (*self.registers).control |= 0x04;
                }
            }

            // Send stop condition
            (*self.registers).control |= 0x02;
        }

        Ok(())
    }

    /// Write then read from I2C device
    pub fn write_read(&mut self, address: u8, write_data: &[u8], read_buffer: &mut [u8]) -> Result<(), ()> {
        self.write(address, write_data)?;
        self.read(address, read_buffer)
    }

    /// Wait for I2C ready
    fn wait_ready(&self) -> Result<(), ()> {
        let mut timeout = 10000;
        unsafe {
            while ((*self.registers).status & 0x01) != 0 {
                timeout -= 1;
                if timeout == 0 {
                    return Err(());
                }
                core::hint::spin_loop();
            }
        }
        Ok(())
    }
}

unsafe impl Send for I2c {}

/// Global I2C instance
pub static mut I2C: I2c = unsafe { I2c::new(I2C_BASE) };

/// Initialize I2C with default speed
pub fn init_i2c() {
    unsafe {
        I2C.init(I2cSpeed::Fast);
    }
}
