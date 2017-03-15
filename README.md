# KYJADview
##app广告页

>###简单用法在需要的的地方实现
/Users/djzx/Desktop/Simulator Screen Shot 2017年3月14日 下午6.28.57.png

//初始化广告页
KYJADview * ADview =   [KYJADview showADviewWithimages:@[@"1351",@"1352",@"1354"]];

ADview.pageControlSelectedColor = [UIColor redColor];

ADview.pageControlNomalColor    = [UIColor orangeColor];

[ADview TouchPushToAdBlock:^{
KYJADViewController * ADviewDetitl = 	[[KYJADViewController alloc]init];
ADviewDetitl.adUrl=  @"https://www.baidu.com";

[self.navigationController pushViewController:ADviewDetitl animated:YES];

}];
