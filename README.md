# RMShareDemo

sdk下载，当前项目用的是简洁分享视图


分享中遇到的一些问题
1. 简洁分享UI不显示图标
解决方法：
包含头文件#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
设置Style：[SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];

2. 分享UI弹窗显示为英文
解决方法：添加简体中文的Localization


3. 删除微信收藏，只显示微信好友和微信朋友圈
解决方法：使用WeChat的儿子去注册，显示
重点参见：http://wiki.mob.com/简洁版更新说明-2
的第四条隐藏微信收藏平台


4.  QQ分享时报失败，但是URL Schemes 已设置仍然失败

解决方法：按照 QQ+appid的16进制（8位数，不足前面补0）

但是依旧报错
最后发现16进制中的字母必须为大写

5. 设置白名单时多看一看文档：http://wiki.mob.com/ios9-对sharesdk的影响（适配ios-9必读）/

6. 新浪微博分享时会先跳到编辑页，再跳到新浪微博的编辑页
解决方法：[sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];//（加了这个方法之后可以不跳分享编辑界面，直接点击分享菜单里的选项，直接分享）

