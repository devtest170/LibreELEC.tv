# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="seatd"
PKG_VERSION="0.8.0"
PKG_SHA256="a562a44ee33ccb20954a1c1ec9a90ecb2db7a07ad6b18d0ac904328efbcf65a0"
PKG_LICENSE="MIT"
PKG_SITE="https://git.sr.ht/~kennylevinsen/seatd"
PKG_URL="https://git.sr.ht/~kennylevinsen/seatd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="A minimal seat management daemon, and a universal seat management library."

PKG_MESON_OPTS_TARGET="-Dlibseat-logind=systemd \
                       -Dlibseat-seatd=enabled \
                       -Dlibseat-builtin=disabled \
                       -Dserver=enabled \
                       -Dexamples=disabled \
                       -Dman-pages=disabled"

pre_configure_target() {
  # seatd does not build without -Wno flags as all warnings being treated as errors
  export TARGET_CFLAGS=$(echo "${TARGET_CFLAGS} -Wno-unused-parameter")
}

post_install() {
  enable_service seatd.service
}
