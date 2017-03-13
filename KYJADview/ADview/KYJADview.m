//
//  KYJADview.m
//  Example
//
//  Created by djzx on 2017/3/9.
//  Copyright © 2017年 djzx. All rights reserved.
//

#import "KYJADview.h"
#define KYJscreenHight    [[UIScreen mainScreen] bounds].size.height
#define KYJscreenWight    [[UIScreen mainScreen] bounds].size.width
static NSString * const KYJAppVersion = @"Version";

@interface KYJADview() <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, strong) NSArray *imageNames;

@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, assign) int count;

@end

// 广告显示的时间
static int const showtime = 10;
@implementation KYJADview

- (instancetype)initWithImageNames:(NSArray<NSString*> *)imageNames
{
    if (self == [super initWithFrame:CGRectZero]) {
        self.imageNames = imageNames;
        [self build];
    }
    return self;
}





//销毁观察者kvo
- (void)dealloc {
    [self unregisterFromKVO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, KYJscreenHight - 155, KYJscreenWight, 105);
}

#pragma mark - Private Method

- (void)build
{
    self.pageControlSelectedColor = [UIColor grayColor];
    self.pageControlNomalColor = [UIColor whiteColor];
    [self registerForKVO];
    //如果不是第一次的话移除广告页
    if (![self isFirstLauch]) {
        UIView *view = [[UIApplication sharedApplication].delegate window].rootViewController.view;
        self.frame = view.bounds;
        [view addSubview:self];
        
        // scrollView
        self.frame = self.bounds;
        self.scrollView.contentSize = CGSizeMake(KYJscreenWight*self.imageNames.count, KYJscreenHight);
        [self addSubview:self.scrollView];
        for (int i=0; i<self.imageNames.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*KYJscreenWight, 0, KYJscreenWight, KYJscreenHight)];
            imageView.image = [UIImage imageNamed:self.imageNames[i]];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i + 100000;
            [imageView addGestureRecognizer:tap];
            [self.scrollView addSubview:imageView];
            if (i == self.imageNames.count - 1) {
                if (!self.enterADdetiallviewHidden) {
                    UIButton *enterButton = [[UIButton alloc] initWithFrame:CGRectMake((KYJscreenWight-84), 30, 60, 30)];
                    enterButton.titleLabel.font = [UIFont systemFontOfSize:15];
                    [enterButton setTitle:[NSString stringWithFormat:@"跳过%d", 10] forState:UIControlStateNormal];
                    [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    enterButton.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
                    enterButton.layer.cornerRadius = 4;

                    [enterButton addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
                    self.enterButton = enterButton;
                    [imageView addSubview:enterButton];
                    imageView.userInteractionEnabled = YES;
                    
                    [self show];

                }
            }
        }
        
        // pageControl
        self.pageControl.numberOfPages = self.imageNames.count;
        self.pageControl.pageIndicatorTintColor = self.pageControlNomalColor;
        self.pageControl.currentPageIndicatorTintColor = self.pageControlSelectedColor;
        [self addSubview:self.pageControl];
        
    } else {
        [self removeFromSuperview];
    }
}

//
//是否更新版本
-(BOOL)isFirstLauch
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:KYJAppVersion];
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:KYJAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    } else {
        return NO;
    }
}

- (void)pushToAd{
    
    NSLog(@"点击图片");
    
    __weak typeof(self) WeakSelf = self;
    
    if (WeakSelf.pushToAdBlock) {
        
        WeakSelf.pushToAdBlock();
    }
    
    [self hideGuidView];
    
}
-(void) TouchPushToAdBlock:(PushToAdBlock)pushToAdBlock{
    
    self.pushToAdBlock = pushToAdBlock;
    
}

- (void)show
{
    
    // 倒计时方法：定时器
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
// 定时器倒计时
- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}
- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}
- (void)countDown
{
    _count --;
    [_enterButton setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self.countTimer invalidate];
        self.countTimer = nil;
        [self hideGuidView];
    }
}
//移除广告页
-(void)hideGuidView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//判断
-(BOOL)isScrolltoLeft:(UIScrollView *)scrollView
{
    return [scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0;
}

#pragma mark - Class Method
//类方法初始化
+ (instancetype)showADviewWithimages:(NSArray<NSString *> *)imageNames
{
    KYJADview *ADview = [[KYJADview alloc] initWithImageNames:imageNames];
    return ADview;
}

#pragma mark - Response Event
//点击进入
- (void)enterAction
{
    [self hideGuidView];
}

#pragma mark - UIScrollViewDelegate
//scrollview开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    int cuttentIndex = (int)(scrollView.contentOffset.x + KYJscreenWight/2)/KYJscreenWight;
    NSLog(@"当前页：%d",cuttentIndex);

    
    if (cuttentIndex == self.imageNames.count - 1) {
        if ([self isScrolltoLeft:scrollView]) {
            //如果隐藏点击进入的话
            if (!self.enterADdetiallviewHidden) {
                return ;
            }
            [self hideGuidView];
        }
    }
}
//scrollview 结束滑动改变page的位置
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int cuttentIndex = (int)(scrollView.contentOffset.x + KYJscreenWight/2)/KYJscreenWight;
    self.pageControl.currentPage = cuttentIndex;
}

#pragma mark - KVO

//注册观察者观察这几项是否发生变化
- (void)registerForKVO
{
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}
//移除观察者
- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}
//观察者所要观察的类型
- (NSArray *)observableKeypaths
{
    return @[@"pageControlSelectedColor",
             @"pageControlNomalColor",
             @"pageControlHidden",
             @"enterADdetiallviewHidden"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:keyPath];
    }
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"pageControlSelectedColor"]) {
        self.pageControl.currentPageIndicatorTintColor = self.pageControlSelectedColor;
    } else if ([keyPath isEqualToString:@"pageControlNomalColor"]) {
        self.pageControl.pageIndicatorTintColor = self.pageControlNomalColor;
    } else if ([keyPath isEqualToString:@"pageControlHidden"]) {
        self.pageControl.hidden = self.pageControlHidden;
    } else if ([keyPath isEqualToString:@"enterADdetiallviewHidden"]) {
        self.enterButton.hidden = self.enterADdetiallviewHidden;
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

#pragma mark - Getter
//懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPage = 0;
        _pageControl.defersCurrentPageDisplay = YES;
    }
    return _pageControl;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
