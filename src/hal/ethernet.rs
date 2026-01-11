//! Ethernet driver for RustOS
//!
//! Provides Ethernet MAC interface

/// Ethernet peripheral base address
const ETHERNET_BASE: usize = 0x6005_0000;

/// Ethernet registers
#[repr(C)]
struct EthernetRegisters {
    control: u32,       // Control register
    status: u32,        // Status register
    mac_addr_low: u32,  // MAC address (lower 4 bytes)
    mac_addr_high: u32, // MAC address (upper 2 bytes)
    tx_buffer: u32,     // TX buffer address
    rx_buffer: u32,     // RX buffer address
    tx_length: u32,     // TX packet length
    rx_length: u32,     // RX packet length
    interrupt: u32,     // Interrupt control
}

/// MAC address
#[derive(Debug, Clone, Copy)]
pub struct MacAddress([u8; 6]);

impl MacAddress {
    /// Create a new MAC address
    pub const fn new(bytes: [u8; 6]) -> Self {
        Self(bytes)
    }

    /// Get MAC address bytes
    pub fn as_bytes(&self) -> &[u8; 6] {
        &self.0
    }
}

/// Ethernet device
pub struct Ethernet {
    registers: *mut EthernetRegisters,
    tx_buffer: [u8; 1536],
    rx_buffer: [u8; 1536],
}

impl Ethernet {
    /// Create a new Ethernet instance
    ///
    /// # Safety
    /// This function is unsafe because it creates a raw pointer to hardware registers
    pub const unsafe fn new(base_addr: usize) -> Self {
        Self {
            registers: base_addr as *mut EthernetRegisters,
            tx_buffer: [0; 1536],
            rx_buffer: [0; 1536],
        }
    }

    /// Initialize Ethernet
    pub fn init(&mut self, mac: MacAddress) {
        unsafe {
            // Set MAC address
            let mac_bytes = mac.as_bytes();
            let mac_low = u32::from_le_bytes([mac_bytes[0], mac_bytes[1], mac_bytes[2], mac_bytes[3]]);
            let mac_high = u32::from_le_bytes([mac_bytes[4], mac_bytes[5], 0, 0]);

            (*self.registers).mac_addr_low = mac_low;
            (*self.registers).mac_addr_high = mac_high;

            // Set buffer addresses
            (*self.registers).tx_buffer = self.tx_buffer.as_ptr() as u32;
            (*self.registers).rx_buffer = self.rx_buffer.as_mut_ptr() as u32;

            // Enable Ethernet
            (*self.registers).control = 0x01;
        }
    }

    /// Send an Ethernet frame
    pub fn send(&mut self, data: &[u8]) -> Result<(), ()> {
        if data.len() > 1536 {
            return Err(());
        }

        unsafe {
            // Wait for previous transmission to complete
            while ((*self.registers).status & 0x01) != 0 {
                core::hint::spin_loop();
            }

            // Copy data to TX buffer
            self.tx_buffer[..data.len()].copy_from_slice(data);

            // Set length and trigger transmission
            (*self.registers).tx_length = data.len() as u32;
            (*self.registers).control |= 0x02;
        }

        Ok(())
    }

    /// Receive an Ethernet frame
    pub fn receive(&mut self, buffer: &mut [u8]) -> Result<usize, ()> {
        unsafe {
            // Check if frame available
            if ((*self.registers).status & 0x02) == 0 {
                return Err(());
            }

            // Get frame length
            let length = (*self.registers).rx_length as usize;
            if length > buffer.len() || length > 1536 {
                return Err(());
            }

            // Copy data from RX buffer
            buffer[..length].copy_from_slice(&self.rx_buffer[..length]);

            // Clear receive flag
            (*self.registers).status = 0x02;

            Ok(length)
        }
    }

    /// Enable Ethernet interrupts
    pub fn enable_interrupts(&mut self) {
        unsafe {
            (*self.registers).interrupt = 0x03; // TX and RX interrupts
        }
    }

    /// Disable Ethernet interrupts
    pub fn disable_interrupts(&mut self) {
        unsafe {
            (*self.registers).interrupt = 0x00;
        }
    }

    /// Check link status
    pub fn is_link_up(&self) -> bool {
        unsafe { ((*self.registers).status & 0x04) != 0 }
    }
}

unsafe impl Send for Ethernet {}

/// Global Ethernet instance
pub static mut ETHERNET: Ethernet = unsafe { Ethernet::new(ETHERNET_BASE) };

/// Initialize Ethernet with default MAC
pub fn init_ethernet() {
    unsafe {
        let mac = MacAddress::new([0x00, 0x0A, 0x35, 0x00, 0x01, 0x02]);
        ETHERNET.init(mac);
    }
}
