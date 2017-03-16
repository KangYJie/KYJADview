# KYJADview
##app广告页

>###简单用法在需要的的地方实现
http://upload-images.jianshu.io/upload_images/4196109-cf9a8816cb3b846b.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/720/q/50

//初始化广告页
KYJADview * ADview =   [KYJADview showADviewWithimages:@[@"1351",@"1352",@"1354"]];

ADview.pageControlSelectedColor = [UIColor redColor];

ADview.pageControlNomalColor    = [UIColor orangeColor];

[ADview TouchPushToAdBlock:^{
KYJADViewController * ADviewDetitl = 	[[KYJADViewController alloc]init];
ADviewDetitl.adUrl=  @"https://www.baidu.com";

[self.navigationController pushViewController:ADviewDetitl animated:YES];

}];
