---
title: "KMS激活服务器一键脚本 for Debian/Ubuntu"
date: 2019-09-02T00:00:00+08:00
draft: false
categories:
  - 随笔
tags: []
---

KMS功能是在Windows Vista之后的产品中的一种新型产品激活机制，目的是为了Microsoft更好的遏制非法软件授权行为(盗版),主要用于企业版系统局域网内批量激活系统。而我们搭建KMS服务器即可免费激活我们的系统，从而无风险的用上正版系统

脚本说明

    wget https://raw.githubusercontent.com/chiakge/mysh/master/kms_install.sh && bash kms_install.sh

注意
本脚本仅适用于Debian/Ubuntu，安装完成后KMS服务即加入自动启动





使用KMS服务器激活系统 (Windows端)
回到Windows端，开启一个cmd(命令提示符)窗口（如果有UAC的话，请注意使用管理员身份提权），

然后输入命令，设置KMS服务器为你的服务器：

slmgr /skms [你的KMS服务器IP地址]
等待弹出提示：

密钥管理服务计算机名称成功地设置为 x.x.x.x。

之后输入命令，开始激活：
slmgr /ato
即可完成KMS激活工作。

友情提示：KMS每次激活只有180天的有效期，但如果执行重新激活，有效期将会重新回到180天。

激活范围
kms激活的前提是你的系统是批量授权版本，即VL版，一般企业版都是VL版，专业版有零售和VL版，家庭版旗舰版OEM版等等那就肯定不能默认直接用kms激活。一般建议从msdn下载系统，VL版本的镜像一般内置GVLK key，用于kms激活。如果你手动输过其他key，那么这个内置的key就会被替换掉，这个时候如果你想用kms，那么就需要把GVLK key输回去。

KEY

Windows Server 2016 Datacenter   CB7KF-BWN84-R7R2Y-793K2-8XDDG
Windows Server 2016 Standard     WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY
Windows Server 2016 Essentials   JCKRF-N37P4-C2D82-9YXRT-4M63B

Windows 10 Professional	W269N-WFGWX-YVC9B-4J6C9-T83GX
Windows 10 Professional N  （N代表欧洲市场定制版）	MH37W-N47XK-V7XM9-C7227-GCQG9
Windows 10 Enterprise	NPPR9-FWDCX-D2C8J-H872K-2YT43
Windows 10 Enterprise N	DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
Windows 10 Education	NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
Windows 10 Education N	2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
Windows 10 Enterprise 2015 LTSB （长期服务分支）	WNMTR-4C88C-JK8YV-HQ7T2-76DF9
Windows 10 Enterprise 2015 LTSB N	2F77B-TNFGY-69QQF-B8YKP-D69TJ
Windows 10 Enterprise 2015 LTSB
Windows 10 Enterprise 2016 LTSB         DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ
Windows 10 Enterprise 2016 LTSB N       QFFDN-GRT3P-VKWWX-X7T3R-8B639

Windows Server 2012 R2 and Windows 8.1
Windows 8.1 Professional	GCRJD-8NW9H-F2CDX-CCM8D-9D6T9
Windows 8.1 Professional N	HMCNV-VVBFX-7HMBH-CTY9B-B4FXY
Windows 8.1 Enterprise	MHF9N-XY6XB-WVXMC-BTDCT-MKKG7
Windows 8.1 Enterprise N	TT4HM-HN7YT-62K67-RGRQJ-JFFXW
Windows Server 2012 R2 Server Standard	D2N9P-3P6X9-2R39C-7RTCD-MDVJX
Windows Server 2012 R2 Datacenter	W3GGN-FT8W3-Y4M27-J84CP-Q3VJ9
Windows Server 2012 R2 Essentials	KNC87-3J2TX-XB4WP-VCPJV-M4FWM

Windows Server 2012 and Windows 8
Windows 8 Professional	NG4HW-VH26C-733KW-K6F98-J8CK4
Windows 8 Professional N	XCVCF-2NXM9-723PB-MHCB7-2RYQQ
Windows 8 Enterprise	32JNW-9KQ84-P47T8-D8GGY-CWCK7
Windows 8 Enterprise N	JMNMF-RHW7P-DMY6X-RF3DR-X2BQT
Windows Server 2012	BN3D2-R7TKB-3YPBD-8DRP2-27GG4
Windows Server 2012 N	8N2M2-HWPGY-7PGT9-HGDD8-GVGGY
Windows Server 2012 Single Language	2WN2H-YGCQR-KFX6K-CD6TF-84YXQ
Windows Server 2012 Country Specific	4K36P-JN4VD-GDC6V-KDT89-DYFKP
Windows Server 2012 Server Standard	XC9B7-NBPP2-83J2H-RHMBY-92BT4
Windows Server 2012 MultiPoint Standard	HM7DN-YVMH3-46JC3-XYTG7-CYQJJ
Windows Server 2012 MultiPoint Premium	XNH6W-2V9GX-RGJ4K-Y8X6F-QGJ2G
Windows Server 2012 Datacenter	48HP8-DN98B-MYWDG-T2DCC-8W83P

Windows 7 and Windows Server 2008 R2
Windows 7 Professional	FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4
Windows 7 Professional N	MRPKT-YTG23-K7D7T-X2JMM-QY7MG
Windows 7 Professional E	W82YF-2Q76Y-63HXB-FGJG9-GF7QX
Windows 7 Enterprise	33PXH-7Y6KF-2VJC9-XBBR8-HVTHH
Windows 7 Enterprise N	YDRBP-3D83W-TY26F-D46B2-XCKRJ
Windows 7 Enterprise E	C29WB-22CC8-VJ326-GHFJW-H9DH4
Windows Server 2008 R2 Web	6TPJF-RBVHG-WBW2R-86QPH-6RTM4
Windows Server 2008 R2 HPC edition	TT8MH-CG224-D3D7Q-498W2-9QCTX
Windows Server 2008 R2 Standard	YC6KT-GKW9T-YTKYR-T4X34-R7VHC
Windows Server 2008 R2 Enterprise	489J6-VHDMP-X63PK-3K798-CPX3Y
Windows Server 2008 R2 Datacenter	74YFP-3QFB3-KQT8W-PMXWJ-7M648
Windows Server 2008 R2 for Itanium-based Systems	GT63C-RJFQ3-4GMB6-BRFB9-CB83V

Windows Vista and Windows Server 2008
Windows Vista Business	YFKBB-PQJJV-G996G-VWGXY-2V3X8
Windows Vista Business N	HMBQG-8H2RH-C77VX-27R82-VMQBT
Windows Vista Enterprise	VKK3X-68KWM-X2YGT-QR4M6-4BWMV
Windows Vista Enterprise N	VTC42-BM838-43QHV-84HX6-XJXKV
Windows Web Server 2008	WYR28-R7TFJ-3X2YQ-YCY4H-M249D
Windows Server 2008 Standard	TM24T-X9RMF-VWXK6-X8JC9-BFGM2
Windows Server 2008 Standard without Hyper-V	W7VD6-7JFBR-RX26B-YKQ3Y-6FFFJ
Windows Server 2008 Enterprise	YQGMW-MPWTJ-34KDK-48M3W-X4Q6V
Windows Server 2008 Enterprise without Hyper-V	39BXF-X8Q23-P2WWT-38T2F-G3FPG
Windows Server 2008 HPC	RCTX3-KWVHP-BR6TB-RB6DM-6X7HP
Windows Server 2008 Datacenter	7M67G-PC374-GR742-YH8V4-TCBY3
Windows Server 2008 Datacenter without Hyper-V	22XQ2-VRXRG-P8D42-K34TD-G3QQC
Windows Server 2008 for Itanium-Based Systems	4DWFP-JF3DJ-B7DTH-78FJB-PDRHK
激活Office VOL 2010、Office VOL 2013，Office VOL2016如果不是VOL需要安装KMS密钥。

1、打开命令提示符
2、在命令提示符下 进入Office 文件 ospp.vbs 所在的目录，Office 2013 默认文件位置C:\Program Files\Microsoft Office\Office15 (cd "C:\Program Files\Microsoft Office\Office15")
3、在命令提示符下输入 cscript ospp.vbs /sethst:192.168.1.1
4、在命令提示符下输入 cscript ospp.vbs /act
