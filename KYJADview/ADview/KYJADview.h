//
//  KYJADview.h
//  Example
//
//  Created by djzx on 2017/3/9.
//  Copyright © 2017年 djzx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PushToAdBlock)();

@interface KYJADview : UIView
//page选中时的颜色
@property(nonatomic,strong)UIColor * pageControlSelectedColor;
//page未选中是的颜色
@property(nonatomic,strong)UIColor * pageControlNomalColor;
//page是否隐藏 默默认为NO
@property(nonatomic,assign)BOOL pageControlHidden;

// 进入AD按钮隐藏 默认NO 如果隐藏就在最后一页左滑进入
@property(nonatomic,assign)BOOL enterADdetiallviewHidden;

//ad初始化类方法
+(instancetype)showADviewWithimages:(NSArray<NSString *> * )ImageArray;


@property (nonatomic,copy) PushToAdBlock pushToAdBlock;

-(void) TouchPushToAdBlock:(PushToAdBlock)pushToAdBlock;

@end
