# Raspberry Pi 3 Model B / B+

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
| Linux kernel         | 4.9 w/ Raspberry Pi patches     |
| IEx terminal         | HDMI and USB keyboard (can be changed to UART) |
| GPIO, I2C, SPI       | Yes - Elixir ALE                |
| ADC                  | No                              |
| PWM                  | Yes, but no Elixir support      |
| UART                 | 1 available - ttyAMA0           |
| Camera               | Yes - via rpi-userland          |
| Ethernet             | Yes                             |
| WiFi                 | Yes - Nerves.Network            |
| Bluetooth            | Not supported yet               |

## Supported WiFi devices

The base image includes drivers for the onboard Raspberry Pi 3 wifi module
(`brcmfmac` driver).

## Linux kernel and RPi firmware/userland

There's a subtle coupling between the `nerves_system_br` version and the Linux
kernel version used here. `nerves_system_br` provides the versions of
`rpi-userland` and `rpi-firmware` that get installed. I prefer to match them to
the Linux kernel to avoid any issues. Unfortunately, none of these are tagged by
the Raspberry Pi Foundation so I either attempt to match what's in Raspbian or
take versions of the repositories that have similar commit times.

## Linux kernel configuration

The Linux kernel compiled for Nerves is a stripped down version of the default
Raspberry Pi Linux kernel. This is done to remove unnecessary features, select
some Nerves-specific features, and to save space. To reproduce the kernel
configuration found here, do the following (this is somewhat tedious):

1. Start with `arch/arm/configs/bcmrpi_defconfig`. This is the kernel
   configuration used in the official Raspberry Pi images.
1. Turn off all filesystems except for `ext4`, `squashfs`, `tmpfs`, `proc`,
   `sysfs`, and `vfat`. Squashfs only needs ZLIB support. Also enable
   `CONFIG_SQUASHFS_FILE_DIRECT`.
1. `vfat` needs to default to `utf8`. Enable native language support for
   `ascii`, `utf-8`, `ISO 8859-1`, codepage 437, and codepage 850.
1. Disable all network drivers and wireless LAN drivers except for Broadcom
   FullMAC WLAN.
1. Disable PPP and SLIP
1. Disable the WiFi drivers in the Staging drivers menus
1. Disable TV, AM/FM, Media USB adapters, DVB Frontends and Remote controller
   support in the Multimedia support menus.
1. Go to `Device Drivers->Sound card support`. Disable `USB sound devices` in
   ALSA. Disable `Open Sound System`.
1. Go to `Device Drivers->Graphics support`. Disable `DisplayLink`
1. In `Kernel Features`, select `Preemptible Kernel (Low-Latency Desktop)`,
   disable the memory allocator for compressed pages.
1. In `Userspace binary formats`, disable support for MISC binaries.
1. In `Networking support`, disable Amateur Radio support, CAN bus subsystem,
   IrDA subsystem, Bluetooth, WiMAX, Plan 9, and NFC. (TBD - this may be too
   harsh, please open issues if you're using any of these and it's the only
   reason for you to create a custom system.)
1. In `Networking options`, disable IPsec, SCTP, Asynchronous Transfer Mode,
   802.1d Ethernet Bridging, L2TP, VLAN, Appletalk, 6LoWPAN, 802.15.4, DNS
   Resolver, B.A.T.M.A.N, Open vSwitch, MPLS, and the Packet Generator in Network
   testing.
1. In `Networking support->Wireless`, enable "use statically compiled regulatory
   rules database". Build in `cfg80211` and `mac80211`. Turn off `mac80211` mesh
   networking and LED triggers. Turn off `cfg80211` wireless extensions
   compatibility.
1. In `Kernel hacking`, disable KGDB, and Magic SysRq key.
1. In Device Drivers, disable MTD support. In Block devices, disable everything
   but Loopback and RAM block device. Disable RAID and LVM.
1. In `Enable the block layer`, deselect everything but the PC BIOS partition
   type (i.e., no Mac partition support, etc.).
1. In `Enable loadable module support`, select "Trim unused exported kernel
   symbols". NOTE: If you're having trouble with an out-of-tree kernel module
   build, try deslecting this!!
1. In `General Setup`, turn off `initramfs/initfd` support, Kernel .config
   support, OProfile.
1. In `Device Drivers -> I2C -> Hardware Bus Support` compile the module into
   the kernel and disable everything but `BCM2708 BSC` support.
1. In `Device Drivers -> SPI` compile in the BCM2835 SPI controller and User
   mode SPI device driver support.
1. In `Device Drivers -> Staging` disable `Support for small TFT LCD modules`
1. In `Device Drivers -> Dallas's 1-wire support`, disable everything but the
   GPIO 1-Wire master and the thermometer slave. (NOTE: Why is the thermometer
   compiled in? This seems historical.)
1. Disable `Hardware Monitoring support`, `Sonics Silicon Backplane support`
1. In `Device Drivers -> Character devices -> Serial drivers`, disable 8250 and
   SC16IS7xx support. Disable the RAW driver.
1. In `Networking support->Network options`, disable `IP: kernel level
   autoconfiguration`
1. In `Networking support->Network options->TCP: advanced congestion control`
   disable everything except for `CUBIC TCP`.
1. Disable `Real Time Clock`.
1. Disable everything in `Cryptographic API` and `Library routines` that can be
   disabled. Sometimes you need to make multiple passes.
1. Disable EEPROM 93CX6 support, PPS support, all GPIO expanders, Speakup core,
   Media staging drivers, STMicroelectronics STMPE, anything "Wolfson".
1. Disable most ALSA for SoC audio support and codecs. NOTE: We probably should
   support a few, but I have no clue which ones are most relevant and there are
   tons of device drivers in the list.
1. Disable IIO and UIO.
1. Disable NXP PCA9685 PWM driver
1. Disable CONFIG_NETFILTER and CONFIG_NET_SCHED (may need to be revisited)
1. Disable CONFIG_MSDOS_FS
1. Disable CONFIG_FB_UDL
1. Remove IPv6 advanced routing and tunnelling options.
1. Disable CONFIG_FSCACHE. This is for local caching of network filesystems like
   NFS and SMB; not a generic filesystem cache.

[Image credit](#fritzing): This image is from the [Fritzing](http://fritzing.org/home/) parts library.
