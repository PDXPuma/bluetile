#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs packages from fedora repos
dnf install -y gnome-session-xsession tmux qtile qtile-extras rofi picom alacritty polybar xorg-x11-xinit xorg-x11-xinit-session libX11-devel libX11-xcb libXft-devel libXinerama-devel imlib2-devel arandr emacs-gtk+x10

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf5 -y copr enable pgdev/ghostty
dnf5 -y install ghostty
dnf5 -y copr disable pgdev/ghostty

#### Example for enabling a System Unit File

# SYSEXTS?
# mkdir -p /etc/sysupdate.d/
# tee /usr/lib/tmpfiles.d/puma-sysext.conf <<EOF
# d /var/lib/extensions/ 0755 root root - -
# d /var/lib/extensions.d/ 0755 root root - -
# EOF

# SYSEXTS=(
#     emacs
#     google-chrome
#     keepassxc
#     microsoft-edge
#     vscode
# )

#     for SYSEXT in "${SYSEXTS[@]}"; do
#         tee /etc/sysupdate.d/"$SYSEXT".conf <<EOF
# [Transfer]
# Verify=false

# [Source]
# Type=url-file
# Path=https://github.com/travier/fedora-sysexts/releases/download/fedora-silverblue-41/
# MatchPattern=$SYSEXT-@v-%a.raw

# [Target]
# InstancesMax=2
# Type=regular-file
# Path=/var/lib/extensions.d/
# MatchPattern=$SYSEXT-@v-%a.raw
# CurrentSymlink=/var/lib/extensions/$SYSEXT.raw
# EOF
#     done

# leave this like bluefin-dx currently has it .
# systemctl enable podman.socket