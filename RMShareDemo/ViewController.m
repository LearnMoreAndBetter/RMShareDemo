//
//  ViewController.m
//  RMShareDemo
//
//  Created by 王林 on 2017/5/23.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "ViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 300, 300)];
	btn.backgroundColor = [UIColor redColor];
	[btn  setTitle:@"分享" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.view addSubview:btn];
	[btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)btnAction:(UIButton *)btn{
	[self shareAction];
}

- (void)shareAction{
	//设置显示平台
	NSArray *items = @[
					   @(SSDKPlatformSubTypeWechatSession),
					   @(SSDKPlatformSubTypeWechatTimeline),
					   @(SSDKPlatformTypeSinaWeibo),
					   @(SSDKPlatformSubTypeQQFriend),
					   ];

	
 //1、创建分享参数
	NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
	if (imageArray) {
		NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
		[shareParams SSDKSetupShareParamsByText:@"哈哈😘😘😘😘😘😘😘😘😘"
										 images:imageArray
											url:[NSURL URLWithString:@"http://blog.csdn.net/qq_25303213"]
										  title:@"我的博客"
										   type:SSDKContentTypeAuto];
		//有的平台要客户端分享需要加此方法，例如微博
		[shareParams SSDKEnableUseClientShare];
		//2、分享（可以弹出我们的分享菜单和编辑界面）

		[SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
		
		//调用分享的方法
		SSUIShareActionSheetController *sheet =
			[ShareSDK showShareActionSheet:self.view
									 items:items
							   shareParams:shareParams
					onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end)
				{
					switch (state) {
						case SSDKResponseStateSuccess:
						{
							UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
														delegate:nil
												cancelButtonTitle:@"确定"
												otherButtonTitles:nil];
							[alertView show];
						}
							
							break;
						case SSDKResponseStateFail:
						{
							UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败" message:nil
														delegate:nil
											cancelButtonTitle:@"确定"
											otherButtonTitles:nil];
							[alertView show];
						}
							
							NSLog(@"分享失败%@",error);
							break;
						case SSDKResponseStateCancel:
							NSLog(@"分享已取消");
							break;
						default:
							break;
						}}];
	
	[sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];//（加了这个方法之后可以不跳分享编辑界面，直接点击分享菜单里的选项，直接分享）
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
