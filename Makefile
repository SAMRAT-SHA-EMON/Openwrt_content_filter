include $(TOPDIR)/rules.mk

PKG_NAME:=custom-filter
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=SAMRAT-SHA-EMON <your@email.com>
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/custom-filter
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Custom Content Filter
  DEPENDS:=+dnsmasq +php7 +php7-cgi +uhttpd +g++ +libstdcpp
endef

define Package/custom-filter/description
  A DNS-based content filter with web interface for OpenWrt.
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
    # No configuration needed
endef

define Build/Compile
    $(TARGET_CXX) $(TARGET_CPPFLAGS) $(TARGET_CXXFLAGS) \
        -o $(PKG_BUILD_DIR)/custom_filter $(FILE_DIR)/files/etc/custom_filter/custom_filter.cpp
endef

define Package/custom-filter/install
    # Install binaries
    $(INSTALL_DIR) $(1)/usr/bin
    $(INSTALL_BIN) $(PKG_BUILD_DIR)/custom_filter $(1)/usr/bin/custom_filter
    
    # Install web interface
    $(INSTALL_DIR) $(1)/www/custom_filter
    $(INSTALL_DATA) $(FILE_DIR)/files/www/custom_filter/* $(1)/www/custom_filter/
    
    # Install blocklist
    $(INSTALL_DIR) $(1)/etc/custom_filter
    $(INSTALL_DATA) $(FILE_DIR)/files/etc/custom_filter/blocklist.txt $(1)/etc/custom_filter/
    
    # Install init script
    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_BIN) $(FILE_DIR)/files/init.d/custom-filter $(1)/etc/init.d/
endef

$(eval $(call BuildPackage,custom-filter))