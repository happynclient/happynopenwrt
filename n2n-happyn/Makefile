# SPDX-License-Identifer: GPL-3.0-only
#
# Copyright (C) 2020 - ntop.org and contributors
# Copyright (C) 2021-2022 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=n2n-happyn
PKG_VERSION:=3.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/happynlab/n2n/archive/refs/tags/happyn3.1.1.tar.gz
PKG_HASH:=d57c902c88c3bbf49040f1c004198450f793c95148fce76a27d1fce123de19ec

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=support@happyn.net

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/n2n-happyn/template
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=N2N-HAPPYN Peer-to-peer VPN
  URL:=http://www.happyn.net
  DEPENDS:=+libopenssl +libpthread +libzstd
endef

define Package/n2n-happyn
  $(call Package/n2n-happyn/template)
  DEPENDS+=+libcap +kmod-tun +resolveip
endef

define Package/n2n-happyn/description
  This package contains client node and supernode for the N2N infrastructure.
endef

define Package/n2n-happyn/conffiles
/etc/config/n2n-happyn
endef

define Package/n2n-happyn-utils
  $(call Package/n2n-happyn/template)
  DEPENDS+=+n2n-happyn +libpcap
endef

define Package/n2n-happyn-utils/description
  This package contains extend utilities for the N2N infrastructure.
endef

CMAKE_OPTIONS+= \
	-DCMAKE_BUILD_TYPE=Release \
	-DN2N_OPTION_USE_PTHREAD=ON \
	-DN2N_OPTION_USE_OPENSSL=ON \
	-DN2N_OPTION_USE_PCAPLIB=ON \
	-DN2N_OPTION_USE_ZSTD=OFF

define Package/n2n-happyn/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/edge $(1)/usr/bin/n2n
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/supernode $(1)/usr/bin/n2n-supernode

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/n2n.config $(1)/etc/config/n2n
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/n2n.init $(1)/etc/init.d/n2n
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/n2n-migrate-conf.sh $(1)/etc/uci-defaults/50-n2n-migrate-conf
endef

define Package/n2n-happyn-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/n2n-benchmark $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/n2n-decode $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/n2n-keygen $(1)/usr/bin/
endef

$(eval $(call BuildPackage,n2n-happyn))
$(eval $(call BuildPackage,n2n-happyn-utils))
