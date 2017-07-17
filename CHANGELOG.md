# Changelog

## v0.14.0

  * nerves_system_br v0.13.2
    * OTP 20
    * erlinit 1.1.3
    * fwup 0.15.3

## v0.13.0

  * nerves_system_br v0.12.1
    * erlinit 1.1.1
    * fwup 0.15.0

  * New features
    * The application data partition is now `ext4`. This greatly improves its
      robustness to corruption. Nerves.Runtime contains code to initialize it on
      first boot.
    * Firmware images now contain metadata that can be queried at runtime (see
      Nerves.Runtime.KV
    * Increased GPU memory to support Pi Camera V2

## v0.12.0

  * nerves_system_br v0.10.0
    * Buildroot 2017.02
    * Erlang/OTP 19.3

  * New features
    * Upgraded the Linux kernel from 4.4.43 -> 4.4.50. Due to the coupling
      between the Linux kernel and rpi-firmware and possibly rpi-userland, if
      you have a custom system based off this, you should update your Linux
      kernel as well. (see `nerves_defconfig`)

## v0.11.0

  * New features
    * Enabled USB_SERIAL and FTDI_SIO support. Needed for connecting with Arduino to the USB ports
    * Support for Nerves 0.5.0

## v0.10.0

  * New features
    * Upgraded the Linux kernel to 4.4.43. This also removes the
      call to mkknlimg which is no longer needed.
    * Bump toolchain to use gcc 5.3 (previously using gcc 4.9.3)
  * Bug Fixes
    * brcmfmac is being compiled as a module. This means that in order to use wifi you will need to `modprobe brcmfmac`. This addresses an issue where the module would not initialize properly on some boards.

## v0.9.1

* Bug Fixes
  * Fixed issues with wifi not starting on some devices

## v0.9.0

This version switches to using the `nerves_package` compiler. This will
consolidate overall deps and compilers.

  * Nerves.System.BR v0.8.1
    * Support for distillery
    * Support for nerves_package compiler

## v0.7.0

When upgrading to this version, be sure to review the updates to
nerves_defconfig if you have customized this system.

  * nerves_system_br v0.6.2
    * Package updates
      * Buildroot 2016.08
      * Linux 4.4

## v0.6.1

  * Package versions
    * Nerves.System.BR v0.6.1

  * New features
    * All Raspberry Pi 3-specific configuration is now in this repository

## v0.6.0
  * Nerves.System.BR v0.6.0
    * Package updates
      * Erlang OTP 19
      * Elixir 1.3.1
      * fwup 0.8.0
      * erlinit 0.7.3
      * bborg-overlays (pull in I2C typo fix from upstream)
    * Bug fixes
      * Synchronize file system kernel configs across all platforms

## v0.5.2
  * Enhancements
    * Enabled USB Printer kernel mod. Needs to be loaded with `modprobe` to use
  * Bug Fixes(raspberry pi)
    * Enabled multicast in linux config

## v0.5.1
  * Nerves.System.BR v0.5.1
    * Bug Fixes(nerves-env)
      * Added include paths to CFLAGS and CXXFLAGS
      * Pass sysroot to LDFLAGS

## v0.5.0
  * Nerves.System.BR v0.5.0
    * New features
      * WiFi drivers enabled by default on RPi2 and RPi3
      * Include wireless regulatory database in Linux kernel by default
        on WiFi-enabled platforms. Since kernel/rootfs are read-only and
        coupled together for firmware updates, the normal CRDA/udev approach
        isn't necessary.
      * Upgraded the default BeagleBone Black kernel from 3.8 to 4.4.9. The
        standard BBB device tree overlays are included by default even though the
        upstream kernel patches no longer include them.
      * Change all fwup configurations from two step upgrades to one step
        upgrades. If you used the base fwup.conf files to upgrade, you no
        longer need to finalize the upgrade. If not, there's no change.

## v0.4.1

  * Nerves.System.BR v0.4.1
    * Bug fixes
      * syslinux fails to boot when compiled on some gcc 5 systems
      * Fixed regression when booting off eMMC on the BBB

    * Package updates
      * Erlang 18.3
      * Elixir 1.2.5
