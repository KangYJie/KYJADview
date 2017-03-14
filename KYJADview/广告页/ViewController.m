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
    self.navigationItem.title = @"看佛山无影脚";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.21 green:0.75 blue:0.49 alpha:1.00]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize: 20],
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.78 green:0.24 blue:0.27 alpha:1.00]}];

    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1409"]];
    
    imageview.frame = self.view.frame;
    [self.view addSubview:imageview];
    
    
//   KYJADview * ADview =   [KYJADview showADviewWithimages:@[@"1384"]];
    KYJADview * ADview =   [KYJADview showADviewWithimages:@[@"1384",@"1384",@"1384"]];

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
