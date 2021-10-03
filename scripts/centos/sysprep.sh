#!/bin/sh

clear_file() {
    if [ -f "$1" ]; then
        echo -n > "$1"
    fi
}

set -ex

# Stop logging services
service rsyslog stop
service auditd stop

# Remove old kernels
dnf remove -y --oldinstallonly --setopt installonly_limit=1 kernel || true

# Clear package cache
yum clean all
rm -rf /var/cache/yum/*

# Force the logs to rotate & remove old logs we don’t need
logrotate -f /etc/logrotate.conf || true
find /var/log -type f -name '*-????????' -delete
find /var/log -type f -name '*.gz' -delete
rm -f /var/log/dmesg.old
rm -rf /var/log/anaconda/
rm -rf /var/log/journal/
mkdir /var/log/journal

# Truncate the audit logs
clear_file /var/log/audit/audit.log
clear_file /var/log/wtmp
clear_file /var/log/lastlog
clear_file /var/log/grubby

# Remove the udev persistent device rules
rm -f /etc/udev/rules.d/70-persistent-net.rules

# Remove the traces of the template MAC address and UUIDs
sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-*

# Clean out tmp directories
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/cache/*

# Remove the SSH host keys
rm -f /etc/ssh/*key*

# Clean out root's home and history
rm -f ~root/.bash_history
rm -f ~root/anaconda-ks.cfg
rm -rf ~root/.ssh/
rm -rf ~root/.gnupg/
unset HISTFILE

# Reset the machine-id
echo -n > /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id
