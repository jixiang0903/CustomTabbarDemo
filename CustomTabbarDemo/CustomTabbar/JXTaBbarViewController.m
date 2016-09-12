//
//  JXTaBbarViewController.m
//  CustomTabbarDemo
//
//  Created by 吉祥 on 16/9/12.
//  Copyright © 2016年 jixiang. All rights reserved.
//

#import "JXTaBbarViewController.h"
#import "JXTabbar.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
@interface JXTaBbarViewController ()

{
    UITabBarController *_tabBarController;
}
/**
 *  自定义的tabbar
 */
@property (nonatomic, strong) JXTabbar *TabBarController;

@end

@implementation JXTaBbarViewController

- (void)viewDidLoad {
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //初始化tabbar
    [self createTabbar];
    // 初始化所有的子控制器
    [self createAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

//初始化tabbar
-(void)createTabbar{
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"MyTabbar" ofType:@"plist"];
    NSDictionary *info=[[NSDictionary alloc]initWithContentsOfFile:path];
    
    _TabBarController=[[JXTabbar alloc]initWithFrame:self.tabBar.bounds];
    //隐藏黑线
    [self.tabBar setClipsToBounds:YES];
    [_TabBarController createMyTabbarWithTabbarInfo:info];
    [self.tabBar addSubview:_TabBarController];
    __weak typeof(self)mySelf = self;
    //点击回调
    _TabBarController.clickBlock = ^(int index) {
        if (index == 2) {
            [_TabBarController setMarkWithSite:3];

        }
//        //点击个人 判断是否登录
//        if (index==2) {
//            if (![DZUserInfo sharedInstance].loginSuccess) {//没有登录
//                //[[DZUserInfo sharedInstance] quitLongVC];
//                DZLoginPageViewController *login=[[DZLoginPageViewController alloc]init];
//                [mySelf presentViewController:login animated:YES completion:^{
//                    s
//                }];
//                return ;
//            }
//        }
        mySelf.selectedIndex = index;
    };
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// 初始化所有的子控制器
-(void)createAllChildViewControllers{
    //首页
    FirstViewController *first=[[FirstViewController alloc]init];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:first];
    //
    SecondViewController *second=[[SecondViewController alloc]init];
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:second];
    //发现
    ThirdViewController *third=[[ThirdViewController alloc]init];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:third];
    //我的
    FourthViewController *fourth=[[FourthViewController alloc]init];
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:fourth];
    
    self.viewControllers=@[nav1,nav2,nav3,nav4];
    
}
#pragma mark public method
/** 点击某个tabbarItem */
- (void)selectTabbarItem:(NSInteger)index {
    [_TabBarController selectTabbarItem:index];
}

/** 给某个tabbarItem加标识 */
- (void)addMarkWithSite:(NSInteger)index {
    [_TabBarController setMarkWithSite:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
