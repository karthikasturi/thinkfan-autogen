# thinkfan-autogen

A simple automation tool that generates a valid `/etc/thinkfan.conf` at boot time by dynamically discovering valid thermal sensor paths.

---

## 🧩 Problem Statement

`thinkfan` is a lightweight fan control daemon for Linux that uses temperature sensor inputs to control fan speed. It requires a configuration file (`/etc/thinkfan.conf`) that defines:

- Sensor file paths (typically from `/sys/devices/`)
- Fan zones (temperature-to-fan level mappings)

### ⚠️ The Problem:

On many modern laptops, especially ThinkPads, the paths for thermal sensors (`/sys/devices/.../temp*_input`) **change dynamically after each reboot**. This creates several issues:

- Static configuration becomes invalid after reboot.
- Sensors like `temp8_input` may appear but are **non-functional** and cause runtime errors.
- Manual config regeneration is tedious and error-prone.

---

## ✅ Solution

This tool solves the problem by:

- **Scanning** all thermal sensor files at runtime.
- **Validating** only accessible (`readable`) sensors.
- **Generating** a fresh `/etc/thinkfan.conf` on every boot.
- **Running as a systemd unit** before the `thinkfan` service starts.

---

## 🔧 Features

- Works with any Linux system using `thinkfan`.
- Ignores invalid or unreadable sensor files.
- Automatically adds the correct fan control zones.
- No hardcoded paths — always current and dynamic.

---

## 📋 Pre-requisites

- **Linux with systemd**
- `thinkfan` package installed:

  ```bash
  sudo apt install thinkfan

---

## 📁 Installation

```bash
git clone https://github.com/karthikasturi/thinkfan-autogen.git
cd thinkfan-autogen
chmod +x setup.sh
./setup.sh

