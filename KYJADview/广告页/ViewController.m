//
//  ViewController.m
//  广告页
//
//  Created by djzx on 2017/3/10.
//  Copyright © 2017年 djzx. All rights reserved.
//

#import "ViewController.h"
#import "KYJADview.h"
#import "KYJADViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
   KYJADview * ADview =   [KYJADview showADviewWithimages:@[@"1351",@"1352",@"1354"]];
    ADview.pageControlSelectedColor = [UIColor redColor];
    ADview.pageControlNomalColor    = [UIColor orangeColor];
    [ADview TouchPushToAdBlock:^{
        KYJADViewController * ADviewDetitl = [[KYJADViewController alloc]init];
        ADviewDetitl.adUrl=  @"https://www.baidu.com";
        
        [self.navigationController pushViewController:ADviewDetitl animated:YES];

    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
