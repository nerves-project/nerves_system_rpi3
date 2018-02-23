# Raspberry Pi 3 Model B

[![CircleCI](https://circleci.com/gh/nerves-project/nerves_system_rpi3.svg?style=svg)](https://circleci.com/gh/nerves-project/nerves_system_rpi3)
[![Hex version](https://img.shields.io/hexpm/v/nerves_system_rpi3.svg "Hex version")](https://hex.pm/packages/nerves_system_rpi3)

This is the base Nerves System configuration for the Raspberry Pi 3 Model B.

![Fritzing Raspberry Pi 3 image](assets/images/raspberry-pi-3-model-b.png)
<br><sup>[Image credit](#fritzing)</sup>

| Feature              | Description                     |
| -------------------- | ------------------------------- |
| CPU                  | 1.2 GHz quad-core ARMv8         |
| Memory               | 1 GB DRAM                       |
| Storage              | MicroSD                         |
| Linux kernel         | 4.4.50 w/ Raspberry Pi patches  |
| IEx terminal         | HDMI and USB keyboard (can be changed to UART)   |
| GPIO, I2C, SPI       | Yes - Elixir ALE                |
| ADC                  | No                              |
| PWM                  | Yes, but no Elixir support      |
| UART                 | 1 available - ttyS0             |
| Camera               | Yes - via rpi-userland          |
| Ethernet             | Yes                             |
| WiFi                 | Yes - Nerves.Network            |
| Bluetooth            | Not supported yet               |

## Supported WiFi devices and firmware

WiFi modules almost always require proprietary firmware to be loaded for them to work. The
Linux kernel handles this and firmware blobs are maintained in the
`linux-firmware` project. The firmware for the built-in WiFi module on the RPi3
hasn't made it to the `linux-firmware` project nor Buildroot, so it is included
here in a `rootfs_overlay` overlay directory. The original firmware files came from [github:RPi-Distro/firmware-nonfree](https://github.com/RPi-Distro/firmware-nonfree/blob/master/brcm80211/brcm).

## Linux kernel and RPi firmware/userland

There's a subtle coupling between the `nerves_system_br` version and the Linux
kernel version used here. `nerves_system_br` provides the versions of
`rpi-userland` and `rpi-firmware` that get installed. I prefer to match them to
the Linux kernel to avoid any issues. Unfortunately, none of these are tagged
by the Raspberry Pi Foundation so I either attempt to match what's in Raspbian
or take versions of the repositories that have similar commit times.

[Image credit](#fritzing): This image is from the [Fritzing](http://fritzing.org/home/) parts library.
