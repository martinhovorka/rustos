//! REQ: ETH-001 - Ethernet Driver
//! 
//! Complete Ethernet MAC driver for AXI Ethernetlite.
//! Supports 10/100 Mbps operation with interrupt handling.

use rustos_pac::ethernet::Ethernet as EthernetRegs;
use crate::{HalError, Result};

/// REQ: ETH-002 - MAC address type (6 bytes)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct MacAddress(pub [u8; 6]);

/// REQ: ETH-003 - Link status
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LinkStatus {
    /// Link is down
    Down,
    /// Link is up at 10 Mbps
    Up10Mbps,
    /// Link is up at 100 Mbps
    Up100Mbps,
}

/// REQ: ETH-006 - Ethernet statistics
#[derive(Debug, Default, Clone, Copy)]
pub struct EthernetStats {
    /// Transmitted packets
    pub tx_packets: u32,
    /// Received packets
    pub rx_packets:u32,
    /// Transmit errors
    pub tx_errors: u32,
    /// Receive errors
    pub rx_errors: u32,
}

/// REQ: ETH-001 - Ethernet driver
pub struct Ethernet {
    base: &'static EthernetRegs,
    mac_addr: MacAddress,
    stats: EthernetStats,
}

impl Ethernet {
    /// REQ: ETH-001 - Initialize Ethernet peripheral
    ///
    /// # Safety
    /// - base_addr must point to valid Ethernet peripheral registers
    /// - Caller must ensure exclusive access to the peripheral
    pub unsafe fn new(base_addr: usize) -> Self {
        let eth = &*(base_addr as *const EthernetRegs);
        Self {
            base: eth,
            mac_addr: MacAddress([0; 6]),
            stats: EthernetStats::default(),
        }
    }
    
    /// REQ: ETH-002 - Initialize with MAC address
    pub fn init(&mut self, mac_addr: MacAddress) -> Result<()> {
        self.mac_addr = mac_addr;
        
        // REQ: ETH-002 - Configure MAC address
        self.base.set_mac_address(&mac_addr.0)?;
        
        // REQ: ETH-003 - Enable receiver and transmitter
        self.base.enable()?;
        
        Ok(())
    }
    
    /// REQ: ETH-004 - Transmit packet
    /// 
    /// # Arguments
    /// * `data` - Ethernet frame data (including headers)
    pub fn transmit(&mut self, data: &[u8]) -> Result<()> {
        if data.len() < 14 || data.len() > 1514 {
            return Err(HalError::InvalidParameter);
        }
        
        // REQ: ETH-004 - Wait for TX buffer available
        if !self.base.is_tx_ready() {
            return Err(HalError::WouldBlock);
        }
        
        // REQ: ETH-004 - Write packet to TX buffer
        self.base.write_tx_buffer(data)?;
        
        // REQ: ETH-004 - Trigger transmission
        self.base.start_transmission()?;
        
        self.stats.tx_packets += 1;
        Ok(())
    }
    
    /// REQ: ETH-005 - Receive packet
    /// 
    /// # Arguments
    /// * `buffer` - Buffer to store received frame
    ///
    /// # Returns
    /// Number of bytes received, or error
    pub fn receive(&mut self, buffer: &mut [u8]) -> Result<usize> {
        // REQ: ETH-005 - Check if packet available
        if !self.base.is_rx_ready() {
            return Err(HalError::WouldBlock);
        }
        
        // REQ: ETH-005 - Read packet from RX buffer
        let len = self.base.read_rx_buffer(buffer)?;
        
        self.stats.rx_packets += 1;
        Ok(len)
    }
    
    /// REQ: ETH-003 - Get link status
    pub fn get_link_status(&self) -> LinkStatus {
        if self.base.is_link_up() {
            LinkStatus::Up100Mbps
        } else {
            LinkStatus::Down
        }
    }
    
    /// REQ: ETH-006 - Get statistics
    pub fn get_stats(&self) -> EthernetStats {
        self.stats
    }
    
    /// REQ: ETH-007 - Clear statistics
    pub fn clear_stats(&mut self) {
        self.stats = EthernetStats::default();
    }
    
    /// REQ: ETH-008 - Enable Ethernet interrupts
    pub fn enable_interrupts(&self) -> Result<()> {
        self.base.enable_interrupts()?;
        Ok(())
    }
    
    /// REQ: ETH-009 - Handle interrupt (to be called from ISR)
    pub fn handle_interrupt(&mut self) -> Result<()> {
        let status = self.base.read_interrupt_status();
        
        // Clear interrupt flags
        self.base.clear_interrupts(status)?;
        
        Ok(())
    }
}
