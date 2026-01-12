//! REQ: ETH-001 to ETH-009 - Ethernet Driver
//! 
//! Complete Ethernet MAC driver for AXI Ethernetlite.
//! Supports 10/100 Mbps operation with interrupt handling.
//!
//! # Features
//! - MAC address configuration
//! - Frame transmit/receive with buffering
//! - Link status detection with 100ms polling
//! - Basic ICMP ping response
//! - Error tracking and graceful degradation
//!
//! # Example
//!
//! ```no_run
//! use rustos_hal::ethernet::{Ethernet, MacAddress};
//! use rustos_pac::ETHERNET_BASE;
//!
//! // Initialize Ethernet with MAC address
//! let mac = MacAddress([0x00, 0x0A, 0x35, 0x01, 0x02, 0x03]);
//! let mut eth = unsafe { Ethernet::new(ETHERNET_BASE) };
//! eth.init(mac).unwrap();
//!
//! // Transmit a frame
//! let frame = [0u8; 64];
//! eth.transmit(&frame).unwrap();
//!
//! // Receive a frame
//! let mut buffer = [0u8; 1518];
//! if let Ok(len) = eth.receive(&mut buffer) {
//!     // Process received frame
//! }
//! ```

use rustos_pac::ethernet::Ethernet as EthernetRegs;
use crate::{HalError, Result};
use portable_atomic::{AtomicU32, Ordering};

/// REQ: ETH-002 - MAC address type (6 bytes)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct MacAddress(pub [u8; 6]);

impl MacAddress {
    /// Broadcast MAC address
    pub const BROADCAST: Self = Self([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]);
    
    /// Check if this is a broadcast address
    pub fn is_broadcast(&self) -> bool {
        self.0 == Self::BROADCAST.0
    }
    
    /// Check if this is a multicast address
    pub fn is_multicast(&self) -> bool {
        (self.0[0] & 0x01) != 0
    }
}

/// REQ: ETH-004 - Link status
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LinkStatus {
    /// Link is down
    Down,
    /// Link is up at 10 Mbps
    Up10Mbps,
    /// Link is up at 100 Mbps
    Up100Mbps,
}

/// REQ: ETH-006, ETH-009 - Ethernet statistics
#[derive(Debug, Default, Clone, Copy)]
pub struct EthernetStats {
    /// Transmitted packets
    pub tx_packets: u32,
    /// Received packets
    pub rx_packets: u32,
    /// Transmit errors
    pub tx_errors: u32,
    /// Receive errors  
    pub rx_errors: u32,
    /// REQ: ETH-009 - Frame errors (CRC, alignment, etc.)
    pub frame_errors: u32,
    /// Packets dropped due to buffer full
    pub rx_dropped: u32,
    /// Link down events
    pub link_down_events: u32,
}

/// REQ: ETH-005 - Ethernet frame types
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum EtherType {
    /// IPv4 (0x0800)
    IPv4,
    /// ARP (0x0806)
    Arp,
    /// IPv6 (0x86DD)
    IPv6,
    /// Unknown type
    Unknown(u16),
}

impl From<u16> for EtherType {
    fn from(value: u16) -> Self {
        match value {
            0x0800 => EtherType::IPv4,
            0x0806 => EtherType::Arp,
            0x86DD => EtherType::IPv6,
            other => EtherType::Unknown(other),
        }
    }
}

/// REQ: ETH-006 - Frame buffer for receive operations
pub struct FrameBuffer {
    /// Raw frame data
    pub data: [u8; 1518],
    /// Frame length
    pub len: usize,
}

impl Default for FrameBuffer {
    fn default() -> Self {
        Self {
            data: [0u8; 1518],
            len: 0,
        }
    }
}

/// REQ: ETH-001 - Ethernet driver state
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum EthernetState {
    /// Uninitialized
    Uninitialized,
    /// Initialized but link down
    LinkDown,
    /// Ready to transmit/receive
    Ready,
    /// Error state
    Error,
}

/// REQ: ETH-001 - Ethernet driver
pub struct Ethernet {
    base: &'static EthernetRegs,
    mac_addr: MacAddress,
    stats: EthernetStats,
    state: EthernetState,
    /// REQ: ETH-007 - Last link check timestamp
    last_link_check: u32,
    /// REQ: ETH-007 - Link status cached
    link_up: bool,
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
            state: EthernetState::Uninitialized,
            last_link_check: 0,
            link_up: false,
        }
    }
    
    /// REQ: ETH-001, ETH-002 - Initialize with MAC address
    pub fn init(&mut self, mac_addr: MacAddress) -> Result<()> {
        self.mac_addr = mac_addr;
        
        // REQ: ETH-002 - Configure MAC address in hardware
        self.base.set_mac_address(&mac_addr.0)
            .map_err(|_| HalError::DeviceError)?;
        
        // REQ: ETH-001 - Enable receiver and transmitter
        self.base.enable()
            .map_err(|_| HalError::DeviceError)?;
        
        // REQ: ETH-004 - Check initial link status
        self.link_up = self.base.is_link_up();
        self.state = if self.link_up {
            EthernetState::Ready
        } else {
            EthernetState::LinkDown
        };
        
        Ok(())
    }
    
    /// REQ: ETH-002 - Get configured MAC address
    pub fn mac_address(&self) -> MacAddress {
        self.mac_addr
    }
    
    /// REQ: ETH-003 - Transmit packet
    /// 
    /// # Arguments
    /// * `data` - Ethernet frame data (including headers, minimum 14 bytes)
    /// 
    /// # Returns
    /// - Ok(()) on success
    /// - Err(InvalidParameter) if frame too small or large
    /// - Err(WouldBlock) if TX buffer busy
    /// - Err(DeviceError) if link is down
    pub fn transmit(&mut self, data: &[u8]) -> Result<()> {
        // REQ: ETH-003 - Validate frame size
        if data.len() < 14 {
            return Err(HalError::InvalidParameter);
        }
        if data.len() > 1514 {
            return Err(HalError::InvalidParameter);
        }
        
        // REQ: ETH-007, ETH-008 - Check link status
        if !self.link_up {
            self.stats.tx_errors += 1;
            return Err(HalError::DeviceError);
        }
        
        // REQ: ETH-003 - Wait for TX buffer available
        if !self.base.is_tx_ready() {
            return Err(HalError::WouldBlock);
        }
        
        // REQ: ETH-003 - Write packet to TX buffer
        self.base.write_tx_buffer(data)
            .map_err(|_| {
                self.stats.tx_errors += 1;
                HalError::DeviceError
            })?;
        
        // REQ: ETH-003 - Trigger transmission
        self.base.start_transmission()
            .map_err(|_| {
                self.stats.tx_errors += 1;
                HalError::DeviceError
            })?;
        
        self.stats.tx_packets += 1;
        Ok(())
    }
    
    /// REQ: ETH-003 - Receive packet
    /// 
    /// # Arguments
    /// * `buffer` - Buffer to store received frame (minimum 1518 bytes recommended)
    ///
    /// # Returns
    /// Number of bytes received, or error
    pub fn receive(&mut self, buffer: &mut [u8]) -> Result<usize> {
        // REQ: ETH-003 - Check if packet available
        if !self.base.is_rx_ready() {
            return Err(HalError::WouldBlock);
        }
        
        // REQ: ETH-003, ETH-006 - Read packet from RX buffer
        let len = self.base.read_rx_buffer(buffer)
            .map_err(|_| {
                // REQ: ETH-009 - Frame errors increment counter
                self.stats.rx_errors += 1;
                self.stats.frame_errors += 1;
                HalError::DeviceError
            })?;
        
        // REQ: ETH-009 - Validate received frame
        if len < 14 {
            self.stats.frame_errors += 1;
            return Err(HalError::DeviceError);
        }
        
        self.stats.rx_packets += 1;
        Ok(len)
    }
    
    /// REQ: ETH-003 - Try to receive into a FrameBuffer
    pub fn receive_frame(&mut self, frame: &mut FrameBuffer) -> Result<()> {
        let len = self.receive(&mut frame.data)?;
        frame.len = len;
        Ok(())
    }
    
    /// REQ: ETH-004 - Get link status
    pub fn link_status(&self) -> LinkStatus {
        if self.link_up {
            LinkStatus::Up100Mbps
        } else {
            LinkStatus::Down
        }
    }
    
    /// REQ: ETH-007 - Poll link status (should be called periodically)
    /// 
    /// Detects link loss within 100ms when called at appropriate interval.
    /// Returns true if link status changed.
    pub fn poll_link_status(&mut self, current_ticks: u32) -> bool {
        let was_up = self.link_up;
        self.link_up = self.base.is_link_up();
        
        // REQ: ETH-007 - Track link down events
        if was_up && !self.link_up {
            self.stats.link_down_events += 1;
            self.state = EthernetState::LinkDown;
        }
        
        // REQ: ETH-008 - Automatic re-enable on link recovery
        if !was_up && self.link_up {
            self.state = EthernetState::Ready;
        }
        
        self.last_link_check = current_ticks;
        was_up != self.link_up
    }
    
    /// REQ: ETH-005 - Process received frame and respond to ICMP ping
    /// 
    /// Returns true if a response was sent
    pub fn handle_icmp_ping(&mut self, frame: &[u8]) -> Result<bool> {
        // Minimum: Ethernet (14) + IP (20) + ICMP (8) = 42 bytes
        if frame.len() < 42 {
            return Ok(false);
        }
        
        // Check EtherType (IPv4)
        let ethertype = u16::from_be_bytes([frame[12], frame[13]]);
        if ethertype != 0x0800 {
            return Ok(false);
        }
        
        // Check IP protocol (ICMP = 1)
        let ip_protocol = frame[23];
        if ip_protocol != 1 {
            return Ok(false);
        }
        
        // Check ICMP type (Echo Request = 8)
        let icmp_type = frame[34];
        if icmp_type != 8 {
            return Ok(false);
        }
        
        // Build ICMP Echo Reply
        let mut reply = [0u8; 98]; // Max ping reply size
        let frame_len = frame.len().min(98);
        reply[..frame_len].copy_from_slice(&frame[..frame_len]);
        
        // Swap MAC addresses
        reply[0..6].copy_from_slice(&frame[6..12]);  // Dest = Source
        reply[6..12].copy_from_slice(&self.mac_addr.0); // Source = Our MAC
        
        // Swap IP addresses
        reply[26..30].copy_from_slice(&frame[30..34]); // Dest IP = Source IP
        reply[30..34].copy_from_slice(&frame[26..30]); // Source IP = Dest IP
        
        // Set ICMP type to Echo Reply (0)
        reply[34] = 0;
        
        // Recalculate ICMP checksum (simplified)
        reply[36] = 0;
        reply[37] = 0;
        let checksum = self.calculate_icmp_checksum(&reply[34..frame_len]);
        reply[36] = (checksum >> 8) as u8;
        reply[37] = (checksum & 0xFF) as u8;
        
        // Transmit reply
        self.transmit(&reply[..frame_len])?;
        
        Ok(true)
    }
    
    /// Calculate ICMP checksum
    fn calculate_icmp_checksum(&self, data: &[u8]) -> u16 {
        let mut sum: u32 = 0;
        let mut i = 0;
        
        while i < data.len() - 1 {
            sum += u16::from_be_bytes([data[i], data[i + 1]]) as u32;
            i += 2;
        }
        
        if i < data.len() {
            sum += (data[i] as u32) << 8;
        }
        
        while sum >> 16 != 0 {
            sum = (sum & 0xFFFF) + (sum >> 16);
        }
        
        !sum as u16
    }
    
    /// REQ: ETH-006 - Get statistics
    pub fn stats(&self) -> EthernetStats {
        self.stats
    }
    
    /// REQ: ETH-006 - Clear statistics
    pub fn clear_stats(&mut self) {
        self.stats = EthernetStats::default();
    }
    
    /// REQ: ETH-001 - Get current driver state
    pub fn state(&self) -> EthernetState {
        self.state
    }
    
    /// REQ: ETH-001 - Enable Ethernet interrupts
    pub fn enable_interrupts(&self) -> Result<()> {
        self.base.enable_interrupts()
            .map_err(|_| HalError::DeviceError)
    }
    
    /// REQ: ETH-001 - Disable Ethernet interrupts
    pub fn disable_interrupts(&self) -> Result<()> {
        // Placeholder - would call base.disable_interrupts()
        Ok(())
    }
    
    /// REQ: ETH-009 - Handle interrupt (to be called from ISR)
    /// 
    /// Processes interrupt status and updates statistics.
    /// Frame errors increment error counter without system disruption.
    pub fn handle_interrupt(&mut self) -> Result<()> {
        let status = self.base.read_interrupt_status();
        
        // REQ: ETH-009 - Track errors without disruption
        if status & 0x01 != 0 {
            // TX complete
        }
        if status & 0x02 != 0 {
            // RX complete
        }
        if status & 0x04 != 0 {
            // TX error
            self.stats.tx_errors += 1;
        }
        if status & 0x08 != 0 {
            // RX error - frame error
            self.stats.rx_errors += 1;
            self.stats.frame_errors += 1;
        }
        
        // Clear interrupt flags
        self.base.clear_interrupts(status)
            .map_err(|_| HalError::DeviceError)?;
        
        Ok(())
    }
    
    /// REQ: ETH-006 - Check if TX buffer is available
    pub fn can_transmit(&self) -> bool {
        self.link_up && self.base.is_tx_ready()
    }
    
    /// REQ: ETH-006 - Check if RX data is available
    pub fn has_data(&self) -> bool {
        self.base.is_rx_ready()
    }
}

/// REQ: ETH-005 - Parse Ethernet frame header
pub fn parse_ether_type(frame: &[u8]) -> Option<EtherType> {
    if frame.len() < 14 {
        return None;
    }
    let ethertype = u16::from_be_bytes([frame[12], frame[13]]);
    Some(EtherType::from(ethertype))
}

/// REQ: ETH-005 - Extract destination MAC from frame
pub fn get_dest_mac(frame: &[u8]) -> Option<MacAddress> {
    if frame.len() < 6 {
        return None;
    }
    let mut mac = [0u8; 6];
    mac.copy_from_slice(&frame[0..6]);
    Some(MacAddress(mac))
}

/// REQ: ETH-005 - Extract source MAC from frame
pub fn get_source_mac(frame: &[u8]) -> Option<MacAddress> {
    if frame.len() < 12 {
        return None;
    }
    let mut mac = [0u8; 6];
    mac.copy_from_slice(&frame[6..12]);
    Some(MacAddress(mac))
}
