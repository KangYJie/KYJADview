//
//  KYJADViewController.m
//  广告页
//
//  Created by djzx on 2017/3/10.
//  Copyright © 2017年 djzx. All rights reserved.
//

#import "KYJADViewController.h"

@interface KYJADViewController ()

@end

@implementation KYJADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"广告页面";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor whiteColor];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

-(void)PersonBackBtnClick:(UIButton *)send{
    [self.navigationController popViewControllerAnimated:YES];
}
// Do any additional setup after loading the view.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
