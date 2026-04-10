
```bash
rustup self update
rustup update
```

https://rust-lang.github.io/rustup/concepts/components.html#components
```bash
rustup toolchain install stable --component rust-src
```

ESP devices
```bash
cargo install espup --locked
espup install

# Either of
# 1. build with sources
cargo install esp-generate --locked
# 2. get the binaries
cargo-binstall esp-generate --locked

# Either of:
cargo install espflash --locked
cargo binstall espflash

# Optional: esp-config is a tool to edit configuration options via a TUI.
cargo install esp-config --features=tui --locked
```

Find the device's arch here: https://doc.rust-lang.org/nightly/rustc/platform-support.html

```bash
# Microbit v2
rustup target add thumbv7em-none-eabi

# ESP32 RISC-V
# For ESP32-C2 and ESP32-C3
rustup target add riscv32imc-unknown-none-elf
# For ESP32-C6 and ESP32-H2
rustup target add riscv32imac-unknown-none-elf

# Additional tools
rustup component add llvm-tools
cargo install cargo-binutils
# For build and sending to board
cargo install cargo-embed
```

Install probe-rs: https://probe.rs/docs/getting-started/installation/

```bash
cargo new project_name
cd project_name
cargo check
cargo build
```

https://crates.io/search?q=cortex-m-rt
https://crates.io/crates/riscv
https://crates.io/crates/esp-hal

Microbit only:
```bash
# https://docs.rs/cortex-m-rt/latest/cortex_m_rt/#memoryx
touch memory.x
```
```txt
MEMORY
{
  FLASH : ORIGIN = 0x00000000, LENGTH = 512K
  RAM   : ORIGIN = 0x20000000, LENGTH = 128K
}
```

```bash
mkdir .cargo
touch .cargo/config.toml
```

```bash
# Also add `use panic_halt as _;`
cargo add panic_halt
cargo build

# Display size/memory details
cargo size -- -Ax
cargo readobj -- -h
```

```bash
# cargo-embed is now in probe-rs
# https://probe.rs/docs/tools/cargo-embed/
probe-rs chip list
```

```bash
cargo embed --chip nRF52833_xxAA
```

```bash
# https://crates.io/crates/embedded-hal
cargo add embedded_hal

# Check out microbit-v2 & microbit-common
```

```bash
# https://probe.rs/docs/tools/cargo-embed/
touch Embed.toml
```

```bash
cargo add cortex_m --features critical-section-single-core
cargo add rtt-target

cargo build
cargo embed

sudo apt install gdb-multiarch
```


