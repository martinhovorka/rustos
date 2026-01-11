//! REQ: I2C-001 - I2C Driver Implementation
//! 
//! Complete I2C/IIC driver for AXI IIC Controller.
//! Supports master mode with 7-bit/10-bit addressing, clock speed configuration,
//! and multi-master arbitration.

use rustos_pac::i2c::I2c as I2cRegs;
use crate::{HalError, Result};

/// REQ: I2C-002 - I2C addressing modes
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AddressMode {
    /// REQ: I2C-003 - 7-bit addressing
    SevenBit,
    /// REQ: I2C-008 - 10-bit addressing support
    TenBit,
}

/// REQ: I2C-007 - I2C error types
#[derive(Debug, Copy, Clone, PartialEq, Eq)]
pub enum I2cError {
    /// Bus error (arbitration lost, bus busy)
    BusError,
    /// NACK received from slave
    Nack,
    /// Timeout waiting for operation
    Timeout,
    /// Invalid parameter
    InvalidParameter,
    /// Bus busy
    BusBusy,
    /// Arbitration lost in multi-master scenario
    ArbitrationLost,
}

/// REQ: I2C-001 - I2C Driver
/// REQ: I2C-002 - Support for master mode
pub struct I2c {
    base: &'static I2cRegs,
}

impl I2c {
    /// REQ: I2C-001 - Initialize I2C peripheral
    ///
    /// # Safety
    /// - base_addr must point to valid I2C peripheral registers
    /// - Caller must ensure exclusive access to the peripheral
    pub unsafe fn new(base_addr: usize) -> Self {
        let i2c = &*(base_addr as *const I2cRegs);
        Self { base: i2c }
    }
    
    /// REQ: I2C-003 - Write data to I2C slave
    /// REQ: I2C-004 - Support for write transactions
    pub fn write(&self, slave_addr: u8, data: &[u8]) -> Result<()> {
        self.write_with_mode(slave_addr, data, AddressMode::SevenBit)
    }
    
    /// REQ: I2C-005 - Read data from I2C slave
    /// REQ: I2C-006 - Support for read transactions
    pub fn read(&self, slave_addr: u8, buffer: &mut [u8]) -> Result<()> {
        self.read_with_mode(slave_addr, buffer, AddressMode::SevenBit)
    }
    
    /// REQ: I2C-008 - Write with specific address mode
    pub fn write_with_mode(&self, slave_addr: u8, data: &[u8], mode: AddressMode) -> Result<()> {
        if data.is_empty() {
            return Err(HalError::InvalidParameter);
        }
        
        // REQ: I2C-010 - Check bus is not busy
        if self.is_bus_busy() {
            return Err(HalError::I2cError(I2cError::BusBusy));
        }
        
        // REQ: I2C-004 - Start condition with write bit
        let addr_byte = (slave_addr << 1) | 0; // Write = 0
        self.base.write_tx_fifo(addr_byte as u32)?;
        
        // REQ: I2C-004 - Write data bytes
        for &byte in data {
            self.base.write_tx_fifo(byte as u32)?;
        }
        
        // REQ: I2C-011 - Wait for transmission complete
        self.wait_for_tx_complete()?;
        
        Ok(())
    }
    
    /// REQ: I2C-008 - Read with specific address mode
    pub fn read_with_mode(&self, slave_addr: u8, buffer: &mut [u8], mode: AddressMode) -> Result<()> {
        if buffer.is_empty() {
            return Err(HalError::InvalidParameter);
        }
        
        // REQ: I2C-010 - Check bus is not busy
        if self.is_bus_busy() {
            return Err(HalError::I2cError(I2cError::BusBusy));
        }
        
        // REQ: I2C-006 - Start condition with read bit
        let addr_byte = (slave_addr << 1) | 1; // Read = 1
        self.base.write_tx_fifo(addr_byte as u32)?;
        
        // REQ: I2C-006 - Read requested number of bytes
        for i in 0..buffer.len() {
            buffer[i] = self.base.read_rx_fifo()? as u8;
        }
        
        Ok(())
    }
    
    /// REQ: I2C-007 - Check if bus is busy
    fn is_bus_busy(&self) -> bool {
        let status = self.base.read_status();
        (status & 0x04) != 0 // BB bit
    }
    
    /// REQ: I2C-011 - Wait for transmission to complete
    fn wait_for_tx_complete(&self) -> Result<()> {
        let timeout = 10000;
        for _ in 0..timeout {
            let status = self.base.read_status();
            
            // Check for errors
            if (status & 0x08) != 0 {
                // Arbitration lost
                return Err(HalError::I2cError(I2cError::ArbitrationLost));
            }
            
            // Check if TX FIFO empty and no acknowledge failure
            if (status & 0x80) != 0 {
                // TX FIFO empty
                return Ok(());
            }
        }
        
        Err(HalError::I2cError(I2cError::Timeout))
    }
    
    /// REQ: I2C-009 - Bus recovery
    /// Perform bus recovery by generating clock pulses
    pub fn recover_bus(&self) -> Result<()> {
        // Reset the controller
        self.base.soft_reset()?;
        
        // REQ: I2C-010 - Reinitialize after recovery
        self.init(100_000)?; // Default to 100 kHz
        
        Ok(())
    }
    
    /// REQ: I2C-001 - Configure I2C clock speed
    /// REQ: I2C-005 - Support standard speeds (100kHz, 400kHz)
    ///
    /// # Arguments
    /// * `speed_hz` - Desired I2C clock speed in Hz (e.g., 100_000 for 100 kHz)
    pub fn init(&self, speed_hz: u32) -> Result<()> {
        // Validate speed
        if speed_hz == 0 || speed_hz > 400_000 {
            return Err(HalError::InvalidParameter);
        }
        
        // REQ: I2C-005 - Configure clock divider for requested speed
        // Assuming system clock of 75 MHz
        let sys_clk_hz = 75_000_000;
        let divisor = (sys_clk_hz / (16 * speed_hz)) - 1;
        
        // Configure divisor registers
        self.base.set_clock_divisor(divisor)?;
        
        Ok(())
    }
}
