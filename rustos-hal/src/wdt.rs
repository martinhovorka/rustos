//! REQ: WDT-001 - Watchdog Timer Driver
//! 
//! Complete watchdog timer driver for AXI Timebase WDT.
//! Supports window mode, early warning interrupts, and configurable timeouts.

use rustos_pac::wdt::Wdt as WdtRegs;
use crate::{HalError, Result};

/// REQ: WDT-002 - Watchdog timer modes
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum WdtMode {
    /// Standard watchdog mode
    Standard,
    /// REQ: WDT-006 - Window watchdog mode
    Window { window_start: u32 },
}

/// REQ: WDT-001 - Watchdog Timer
pub struct Watchdog {
    base: &'static WdtRegs,
    mode: WdtMode,
}

impl Watchdog {
    /// REQ: WDT-003 - Initialize watchdog timer
    ///
    /// # Safety
    /// - base_addr must point to valid WDT peripheral registers
    /// - Caller must ensure exclusive access to the peripheral
    pub unsafe fn new(base_addr: usize) -> Self {
        let wdt = &*(base_addr as *const WdtRegs);
        Self {
            base: wdt,
            mode: WdtMode::Standard,
        }
    }
    
    /// REQ: WDT-003 - Start watchdog timer with timeout
    /// 
    /// # Arguments
    /// * `timeout_ms` - Timeout in milliseconds
    pub fn start(&self, timeout_ms: u32) -> Result<()> {
        if timeout_ms == 0 {
            return Err(HalError::InvalidParameter);
        }
        
        // REQ: WDT-004 - Configure timeout
        self.base.set_timeout(timeout_ms)?;
        
        // REQ: WDT-003 - Enable watchdog
        self.base.enable()?;
        
        Ok(())
    }
    
    /// REQ: WDT-005 - Reset (kick) the watchdog timer
    pub fn reset(&self) -> Result<()> {
        self.base.write_wdtrst()?;
        Ok(())
    }
    
    /// REQ: WDT-008 - Enable early warning interrupt
    /// 
    /// # Arguments
    /// * `threshold_ms` - Milliseconds before timeout to trigger interrupt
    pub fn enable_early_warning(&self, threshold_ms: u32) -> Result<()> {
        if threshold_ms == 0 {
            return Err(HalError::InvalidParameter);
        }
        
        // REQ: WDT-008 - Configure warning threshold
        self.base.set_warning_threshold(threshold_ms)?;
        
        // REQ: WDT-009 - Enable warning interrupt
        self.base.enable_warning_interrupt()?;
        
        Ok(())
    }
    
    /// REQ: WDT-010 - Disable early warning interrupt
    pub fn disable_early_warning(&self) -> Result<()> {
        self.base.disable_warning_interrupt()?;
        Ok(())
    }
    
    /// REQ: WDT-006 - Configure window mode
    pub fn set_window_mode(&mut self, window_start: u32) -> Result<()> {
        if window_start == 0 {
            return Err(HalError::InvalidParameter);
        }
        
        self.mode = WdtMode::Window { window_start };
        self.base.set_window_start(window_start)?;
        
        Ok(())
    }
    
    /// REQ: WDT-007 - Read current watchdog counter value
    pub fn read_counter(&self) -> u32 {
        self.base.read_counter()
    }
    
    /// REQ: WDT-011 - Check if watchdog has expired
    pub fn is_expired(&self) -> bool {
        self.base.is_expired()
    }
    
    /// REQ: WDT-012 - Disable watchdog (if supported by hardware)
    pub fn disable(&self) -> Result<()> {
        // Note: Some WDT implementations don't allow disabling once started
        self.base.disable()?;
        Ok(())
    }
}
