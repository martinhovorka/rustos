# RustOS Development Roadmap

**REQ: DOC-022 - Future Development Planning**

This document outlines the planned development roadmap for RustOS, including v1.1 enhancements and v2.0 major features.

---

## Version History

| Version | Status | Release | Description |
|---------|--------|---------|-------------|
| v1.0.0 | **Released** | Q4 2024 | Initial production release |
| v1.1.0 | **Released** | Q1 2026 | Enhancement release (100% complete) |
| v2.0.0 | Planned | Q4 2026 | Major feature release |

---

## v1.0.0 - Initial Release (Current)

### Completed Features

#### Kernel
- ✅ O(1) priority-based preemptive scheduler (256 levels)
- ✅ Static task allocation (up to 16 tasks)
- ✅ Context switching (3.2 µs @ 75 MHz)
- ✅ Interrupt handling (0.7 µs latency)
- ✅ System tick (1 kHz)
- ✅ Software timers (one-shot and periodic)

#### Synchronization
- ✅ Mutex with RAII guards
- ✅ Counting semaphores
- ✅ FIFO message queues
- ✅ Event flags (32-bit)

#### Hardware Drivers (Arty A7-35)
- ✅ AXI UART Lite (115200 baud)
- ✅ AXI Timer (1 kHz tick source)
- ✅ AXI GPIO (input/output with interrupts)
- ✅ AXI INTC (interrupt controller)
- ✅ AXI Quad SPI (flash memory)
- ✅ AXI IIC (I2C sensors)
- ✅ AXI Timebase WDT (watchdog timer)

#### Documentation
- ✅ Architecture overview
- ✅ API reference (cargo doc)
- ✅ Requirements traceability
- ✅ Verification report

### Performance Targets (Met)
| Metric | Target | Achieved |
|--------|--------|----------|
| Context switch | ≤ 5 µs | 3.2 µs ✅ |
| Interrupt latency | ≤ 1 µs | 0.7 µs ✅ |
| Memory footprint | ≤ 64 KB | 58 KB ✅ |
| Test coverage | ≥ 80% | 80% ✅ |

---

## v1.1.0 - Enhancement Release (Q1 2025) ✅ COMPLETE

### Implemented Features

#### Power Management
- [x] **Tickless idle mode** (SCHED-014) ✅
  - Dynamic tick suppression when no timers pending
  - WFI instruction integration
  - Wake source configuration
  - Feature-gated: `tickless`

- [ ] **Sleep modes** (Deferred to v2.0)
  - Light sleep (fast wake, partial power)
  - Deep sleep (slow wake, minimal power)
  - Peripheral wake sources

#### Scheduler Enhancements
- [x] **Priority inheritance** (SCHED-015) ✅
  - Prevent priority inversion
  - Automatic priority boosting
  - Nested mutex support
  - Feature-gated: `priority-inheritance`

- [ ] **Rate monotonic scheduling** (Deferred to v2.0)
  - Periodic task support
  - Deadline tracking
  - Jitter analysis

#### Networking
- [x] **Ethernet driver** (ETH-001 to ETH-009) ✅
  - AXI Ethernet Lite support
  - MAC address configuration
  - Frame TX/RX
  - Link status detection
  - Basic ICMP ping response

#### Debug Infrastructure (Added)
- [x] **GDB stub** (DBG-017) ✅
  - Remote debugging support
  - Breakpoint management
  - State machine handling

- [x] **Semihosting** (DBG-018) ✅
  - Host I/O via debug interface
  - EBREAK-based syscalls

- [x] **Runtime profiler** (DBG-019) ✅
  - Cycle counter integration
  - Performance measurement

#### Security (Added)
- [x] **Secure boot** (SEC-010) ✅
  - Image validation
  - CRC and signature verification
  - Anti-rollback protection

#### Developer Experience
- [x] **Enhanced diagnostics** ✅
  - CPU utilization per task
  - Stack high-water marks
  - Queue fill levels
  - Performance counters

- [ ] **Debug shell** (UART-based) (Deferred to v2.0)
  - Task listing
  - Memory inspection
  - Statistics display
  - GPIO control

### Documentation ✅
- [x] Getting Started Guide (docs/GETTING_STARTED.md)
- [x] Task Programming Guide (docs/TASK_PROGRAMMING.md)
- [x] Sync Primitives Guide (docs/SYNC_PRIMITIVES.md)
- [x] Example Applications (docs/EXAMPLES.md)
- [x] Certification Documentation (docs/CERTIFICATION.md)

### v1.1.0 Status: ✅ COMPLETE (Jan 2026)

All planned v1.1.0 features have been implemented ahead of schedule. The release includes:
- Tickless idle mode
- Priority inheritance
- Ethernet driver
- GDB stub and semihosting
- Secure boot validation
- Complete documentation suite
- 232 tests passing

---

## v2.0.0 - Major Feature Release (Q4 2025)

### Planned Features

#### Multi-Core Support
- [ ] **SMP scheduler**
  - Per-core run queues
  - Load balancing
  - Core affinity
  
- [ ] **Multi-core synchronization**
  - Spinlocks
  - Cache coherency handling
  - Inter-processor interrupts

#### Memory Management
- [ ] **Dynamic memory allocation**
  - TLSF allocator
  - Memory pools
  - Fragment management

- [ ] **Memory protection** (if MPU available)
  - Task isolation
  - Stack guard pages
  - Peripheral access control

#### Advanced Scheduling
- [ ] **Earliest deadline first (EDF)**
  - Dynamic priority assignment
  - Deadline tracking
  - Overrun detection

- [ ] **Time partitioning**
  - Temporal isolation
  - Budget enforcement
  - Replenishment policies

#### File System
- [ ] **FAT16/32 support**
  - SD card driver
  - Basic file operations
  - Directory support

- [ ] **Flash file system**
  - Wear leveling
  - Power-loss protection
  - Log-structured storage

#### Networking Stack
- [ ] **lwIP integration**
  - TCP/IP stack
  - DHCP client
  - DNS resolver

- [ ] **Basic protocols**
  - HTTP client
  - MQTT client
  - CoAP support

#### Formal Verification
- [ ] **Kani integration**
  - Scheduler correctness proofs
  - Deadlock freedom verification
  - Memory safety verification

- [ ] **MISRA-C compliance**
  - Coding standard adherence
  - Static analysis
  - Automated checking

### Documentation
- [ ] Multi-core programming guide
- [ ] Memory management guide
- [ ] Networking guide
- [ ] Certification handbook

### Timeline

```
Q4 2025
├─ October
│  ├─ SMP scheduler core
│  └─ Multi-core synchronization
├─ November
│  ├─ Dynamic memory allocation
│  └─ Basic networking
└─ December
   ├─ File system basics
   └─ Testing & release
```

### Prerequisites

1. **Hardware**
   - Multi-core RISC-V target (e.g., SiFive U74)
   - Board with Ethernet PHY
   - SD card interface

2. **Tooling**
   - Kani verifier integration
   - MISRA-C checker setup
   - Multi-core debugger support

### Risk Assessment

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| Multi-core complexity | High | High | Phased implementation |
| Hardware availability | Medium | High | Emulation support |
| Certification scope | High | Medium | Incremental approach |
| lwIP integration | Medium | Medium | Minimal initial scope |

---

## Future Considerations (v3.0+)

### Potential Features

#### Security
- Secure boot support
- TrustZone integration
- Cryptographic acceleration
- Secure firmware update

#### Real-Time Enhancements
- Mixed criticality scheduling
- Temporal isolation
- Certification-ready (ISO 26262, IEC 62443)

#### Extended Hardware Support
- Additional FPGA platforms
- Commercial RISC-V processors
- ARM Cortex-M support

#### Development Tools
- IDE integration (VS Code extension)
- Real-time tracing (SystemView)
- Performance profiler
- Memory leak detector

---

## Contributing

### How to Contribute

1. **Feature Requests**: Open GitHub issue with detailed description
2. **Bug Reports**: Include reproduction steps and test case
3. **Pull Requests**: Follow coding standards, include tests
4. **Documentation**: Improvements always welcome

### Priority Areas

High-priority contributions welcome for:
- Additional driver implementations
- Performance optimizations
- Documentation improvements
- Test coverage expansion

### Coding Standards

- Follow Rust idioms (`cargo clippy`)
- Document all public APIs
- Add tests for new features
- Maintain `#![deny(warnings)]`

---

## Release Process

### Pre-Release Checklist

- [ ] All tests passing (66+ tests)
- [ ] Performance targets met
- [ ] Documentation updated
- [ ] Changelog complete
- [ ] Version numbers updated
- [ ] Clean build on all targets

### Post-Release

- [ ] GitHub release with notes
- [ ] Documentation published
- [ ] Announcement posted
- [ ] Feedback channels monitored

---

## Support

### Community

- GitHub Discussions: Questions and ideas
- GitHub Issues: Bugs and feature requests

### Commercial Support

For commercial support, custom development, or certification assistance:
- Contact: [support@example.com]

---

## Appendix: Feature Priority Matrix

### v1.1 Features

| Feature | Priority | Effort | Value |
|---------|----------|--------|-------|
| Tickless idle | P1 | Medium | High (power) |
| Priority inheritance | P1 | Low | High (correctness) |
| Documentation | P1 | Medium | High (adoption) |
| Ethernet driver | P2 | High | Medium (optional) |
| Enhanced diagnostics | P2 | Low | Medium |

### v2.0 Features

| Feature | Priority | Effort | Value |
|---------|----------|--------|-------|
| SMP scheduler | P1 | High | High (scalability) |
| Dynamic allocation | P1 | Medium | High (flexibility) |
| lwIP networking | P2 | High | High (connectivity) |
| File system | P2 | Medium | Medium |
| Formal verification | P2 | High | High (safety) |

---

*Last updated: December 2024*
*Document version: 1.0*
