#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# Set DISTRIB_REVISION
#sed -i "s/OpenWrt/Deng Build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/default-settings/files/zzz-default-settings

# Modify default IP（FROM 192.168.1.1 CHANGE TO 10.10.10.1）
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template


# 拉取软件包

git clone --depth 1 https://github.com/rufengsuixing/luci-app-adguardhome package/deng/luci-app-adguardhome
git clone --depth 1 https://github.com/AdguardTeam/AdGuardHome package/deng/adguardhome
git clone --depth 1 https://github.com/sbwml/openwrt-alist package/deng/alist
svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt ackage/deng/luci-aliyundrive-webdav
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/deng/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon package/deng/luci-theme-argon
svn export https://github.com/Lienol/openwrt-package/branches/other/lean/luci-app-autoreboot ackage/deng/luci-app-autoreboot
svn export https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest/trunk/applications/luci-app-cloudflarespeedtest ackage/deng/luci-app-cloudflarespeedtest
git clone --depth 1 https://github.com/sensec/ddns-scripts_aliyun package/deng/ddns-scripts_aliyun
svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-fileassistant ackage/deng/luci-app-fileassistant
git clone --depth 1 https://github.com/jerrykuku/luci-app-go-aliyundrive-webdav package/deng/luci-app-go-aliyundrive-webdav
git clone --depth 1 https://github.com/jerrykuku/go-aliyundrive-webdav package/deng/go-aliyundrive-webdav
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata package/deng/luci-app-netdata
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-openvpn-server package/deng/luci-app-openvpn-server
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall package/deng/passwall
git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall package/deng/luci-app-passwall
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff package/deng/luci-app-poweroff
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot package/deng/luci-app-pushbot
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-qbittorrent package/deng/luci-app-qbittorrent
svn export https://github.com/coolsnowwolf/packages/trunk/net/qBittorrent-static package/deng/qBittorrent-static
svn export https://github.com/coolsnowwolf/packages/trunk/net/qBittorrent package/deng/qBittorrent
svn export https://github.com/coolsnowwolf/packages/trunk/libs/qtbase package/deng/qtbase
svn export https://github.com/coolsnowwolf/packages/trunk/libs/qttools package/deng/qttools
svn export https://github.com/coolsnowwolf/packages/trunk/libs/rblibtorrent package/deng/rblibtorrent
git clone --depth 1 https://github.com/tty228/luci-app-serverchan package/deng/luci-app-serverchan
git clone --depth 1 https://github.com/ZeaKyX/luci-app-speedtest-web package/deng/luci-app-speedtest-web
git clone --depth 1 https://github.com/ZeaKyX/speedtest-web package/deng/speedtest-web
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-turboacc package/deng/luci-app-turboacc
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-vsftpd package/deng/luci-app-vsftpd
svn export https://github.com/coolsnowwolf/lede/trunk/package/lean/vsftpd-alt package/deng/vsftpd-alt
svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus package/deng/luci-app-wolplus
git clone --depth 1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/deng/luci-app-unblockneteasemusic


# 删除重复包



# 其他调整

sed -i 's#../../#$(TOPDIR)/feeds/luci/#g' package/deng/luci-app-openvpn-server/Makefile
sed -i 's#../../#$(TOPDIR)/feeds/luci/#g' package/deng/luci-app-qbittorrent/Makefile
sed -i 's#../../#$(TOPDIR)/feeds/luci/#g' package/deng/luci-app-vsftpd/Makefile
sed -i 's#../../#$(TOPDIR)/feeds/luci/#g' package/deng/luci-app-turboacc/Makefile

NAME=$"package/deng/luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic" && mkdir -p $NAME/core
curl 'https://api.github.com/repos/UnblockNeteaseMusic/server/commits?sha=enhanced&path=precompiled' -o commits.json
echo "$(grep sha commits.json | sed -n "1,1p" | cut -c 13-52)">"$NAME/core_local_ver"
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/app.js -o $NAME/core/app.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/bridge.js -o $NAME/core/bridge.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/ca.crt -o $NAME/core/ca.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.crt -o $NAME/core/server.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.key -o $NAME/core/server.key