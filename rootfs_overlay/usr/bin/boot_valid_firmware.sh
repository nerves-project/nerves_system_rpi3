#! /bin/sh

nerves_fw_validated="$(fw_printenv -n nerves_fw_validated)"
nerves_fw_booted="$(fw_printenv -n nerves_fw_booted)"

if [ "$nerves_fw_booted" = "1" ]; then
    if [ "$nerves_fw_validated" = "0" ]; then
        fwup "/usr/share/fwup/revert.fw" -t revert -d /dev/rootdisk0
        reboot
    fi
else
    fw_setenv "nerves_fw_booted" "1"
fi
