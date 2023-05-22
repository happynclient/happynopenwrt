# SPDX-License-Identifer: GPL-3.0-only
#
# Copyright (C) 2020 - ntop.org and contributors
# Copyright (C) 2021-2022 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=n2n-happyn
PKG_VERSION:=3.1.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/happynlab/n2n/releases/download/happyn3.1.1/
PKG_HASH:=475ff94c02ea9a86ff172e84e066bf0bbc67020526099b7b1f2bb94a6d68c285

#PKG_NAME:=n2n
#PKG_VERSION:=3.0
#PKG_RELEASE:=5
#
#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=https://codeload.github.com/ntop/n2n/tar.gz/$(PKG_VERSION)?
#PKG_HASH:=25fcabba7bfcf25f4c9cd7fecc7ce11de48beb0b0f3506053d8485604ea8f50d

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
  DEPENDS:=+libopenssl +libpthread
endef

define Package/n2n-happyn
  $(call Package/n2n-happyn/template)
  DEPENDS+=+libcap +kmod-tun +resolveip
endef

define Package/n2n-happyn/description
  This package contains client node and supernode for the N2N-HAPPYN infrastructure.
endef

define Package/n2n-happyn/conffiles
/etc/config/n2n-happyn
endef

define Package/n2n-happyn-utils
  $(call Package/n2n-happyn/template)
  DEPENDS+=+n2n-happyn +libpcap
endef

define Package/n2n-happyn-utils/description
  This package contains extend utilities for the N2N-Happyn infrastructure.
endef

CMAKE_OPTIONS+= \
	-DCMAKE_BUILD_TYPE=Release \
	-DN2N_OPTION_USE_PTHREAD=ON \
	-DN2N_OPTION_USE_OPENSSL=ON \
	-DN2N_OPTION_USE_PCAPLIB=ON \
	-DN2N_OPTION_USE_ZSTD=OFF

define Package/n2n-happyn/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/edge $(1)/usr/bin/happynet
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/supernode $(1)/usr/bin/happynet-supernode

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/happynet.config $(1)/etc/config/happynet
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/happynet.init $(1)/etc/init.d/happynet
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/n2n-migrate-conf.sh $(1)/etc/uci-defaults/50-n2n-migrate-conf
endef

define Package/n2n-happyn-utils/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/n2n-benchmark $(1)/usr/bin/happynet-benchmark
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/n2n-decode $(1)/usr/bin/happynet-decode
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/n2n-keygen $(1)/usr/bin/happynet-keygen
endef

$(eval $(call BuildPackage,n2n-happyn))
$(eval $(call BuildPackage,n2n-happyn-utils))
