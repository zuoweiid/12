#!/bin/bash
lede_path=$(pwd)                            ##目录变量=Lede源码目录；
# lede_path="$(cd `dirname $0`; pwd)"       ##目录变量=Lede源码目录；
cd $lede_path


sed -i '$a src-git luciapp https://github.com/zuoweiid/luci-app' feeds.conf.default            # 自己整理的源       $a= 插入最后一行， $i= 插入倒数第二行

#---------------------------------------------------------------------------------------------------------------------------------------
./scripts/feeds clean                               ## 清除编译临时文件
./scripts/feeds update -a                           ## 更新_插件源包（更新后目录：lede源码/feeds/***）
#---------------------------------------------------------------------------------------------------------------------------------------

cd $lede_path/feeds/luci/applications           # 进入 LEDE源码内applications目录内；
mkdir -p app && mv -f ./* app                   # 临时创建app文件夹，移动当前全部文件到app目录内，后续会删除；
	
	# 移动保留的插件； mv -f app/插件名称 ./
mv -f app/luci-app-samba4 ./                    # 网络共享（必备插件）
mv -f app/luci-app-firewall ./                  # 防火墙（必备插件）
	
	# mv -f app/luci-app-accesscontrol ./    		# 上网时间控制
	# mv -f app/luci-app-acme ./             		# 自动申请证书
	# mv -f app/luci-app-adblock ./					# ADB广告过滤
	# mv -f app/luci-app-adbyby-plus ./            	# 广告屏蔽大师Plus +
	# mv -f app/luci-app-advanced-reboot ./         # Linksys高级重启
	# mv -f app/luci-app-airplay2 ./           		# 苹果 AirPlay2 无损音频接收服务器
	# mv -f app/luci-app-aliyundrive-webdav ./		# 阿里云盘挂载-webdav
	# mv -f app/luci-app-aria2 ./                   # Aria2下载工具
	# mv -f app/luci-app-arpbind ./					# IP/MAC绑定
	# mv -f app/luci-app-attendedsysupgrade ./		# 固件更新升级相关
#	mv -f app/luci-app-autoreboot ./				# 计划定时重启（autopoweroff二选一）（常用）
	# mv -f app/luci-app-baidupcs-web ./			# 百度网盘管理
	# mv -f app/luci-app-cifs-mount ./				# CIFS/SMB（挂载远程SMB目录）
	# mv -f app/luci-app-cpufreq ./					# CPU 性能优化调节设置 这个不显示！！！！（常用）
#	mv -f app/luci-app-ddns ./						# 动态DNS（集成阿里DDNS客户端）（常用）
	# mv -f app/luci-app-docker ./					# Docker容器 （与源码docker二选一）
	# mv -f app/luci-app-dockerman ./				# 
	# mv -f app/luci-app-eqos ./						# 设备网速限制
mv -f app/luci-app-filetransfer ./				# 安装ipk软件包（文件传输）（常用）
#	mv -f app/luci-app-frpc ./					    # 内网穿透Frp客户端
#	mv -f app/luci-app-frps ./					    # 内网穿透Frp服务端
	# mv -f app/luci-app-guest-wifi ./				# WiFi访客网络
	# mv -f app/luci-app-ipsec-server ./			# IPSec VPN 服务器（ipsec-vpnd二选一）
	# mv -f app/luci-app-ipsec-vpnd ./				# IPSec VPN 服务器（ipsec-server二选一）
#	mv -f app/luci-app-netdata ./					# Netdata实时监控（CPU详情图表）
#	mv -f app/luci-app-nlbwmon ./					# 带宽监控（显示、配置、备份）（常用）
	# mv -f app/luci-app-nps ./						# 内网穿透nps
	# mv -f app/luci-app-ntpc ./					# NTP时间同步服务器
	# mv -f app/luci-app-pptp-server ./				# PPTP VPN 服务器
	# mv -f app/luci-app-pushbot ./					# 全能推送（serverchan钉钉推送的更名）
	# mv -f app/luci-app-qbittorrent ./				# BT下载工具（qBittorrent）
	# mv -f app/luci-app-ramfree ./					# 释放内存
	# mv -f app/luci-app-samba ./					# 网络共享（Samba与Samba4二选一）
	# mv -f app/luci-app-serverchan ./				# 微信推送（：微信、微信测试号版、TG电报）
	# mv -f app/luci-app-syncdial ./				# 多拨虚拟网卡（原macvlan）
mv -f app/luci-app-ttyd ./						# 网页终端命令行（常用）
mv -f app/luci-app-turboacc ./   				# TurboACC网络加速
	# mv -f app/luci-app-unblockmusic ./			# 网易云解锁插件
	# mv -f app/luci-app-upnp ./					# 通用即插即用UPnP（端口自动转发）
mv -f app/luci-app-vlmcsd ./					# KMS服务器设置（常用）
	# mv -f app/luci-app-vsftpd ./					# FTP服务器
mv -f app/luci-app-webadmin ./					# Web管理页面设置；修改80默认端口（常用）
	# mv -f app/luci-app-wifischedule ./			# WiFi 计划
mv -f app/luci-app-wol ./						# WOL网络唤醒
	# mv -f app/luci-app-wrtbwmon ./				# 实时流量监测（wrtbwmon-zhcn 二选一）
mv -f app/luci-app-zerotier ./					# ZeroTier内网穿透（常用）
rm -rf app                                      # 删除临时创建的app目录；
#---------------------------------------------------------------------------------------------------------------------------------------


cd $lede_path/feeds/luci/themes      # 进入themes主题目录
	
rm -rf luci-theme-argon              # 删除Argon主题（旧版必删）
rm -rf luci-theme-argon-mod          # 删除Argon主题
	# rm -rf luci-theme-bootstrap
rm -rf luci-theme-design
rm -rf luci-theme-material
rm -rf luci-theme-netgear
	
#---------------------------------------------------------------------------------------------------------------------------------------
cd $lede_path
./scripts/feeds install -a                             ##安装_插件源包（安装后目录：lede源码/package/feeds/***）
#---------------------------------------------------------------------------------------------------------------------------------------
	

# 最新版插件和主题
rm -rf feeds/packages/lang/golang && git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang  ## 升级 Go版本

git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git package/otherapp/luci-app-argon-config                 ##Argon主题设置
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/otherapp/luci-theme-argon                          ##Argon主题；匹配Lede源码

git clone https://github.com/openwrt-dev/po2lmo.git po2lmo       ## 下载po2lmo依赖
pushd po2lmo
make && sudo make install
popd
cd $lede_path
rm -rf po2lmo                                                    ## 安装后，删除目录


