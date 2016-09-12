//
//  FirstViewController.m
//  CustomTabbarDemo
//
//  Created by 吉祥 on 16/9/12.
//  Copyright © 2016年 jixiang. All rights reserved.
//

#import "FirstViewController.h"
#define JXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    //隐藏黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.title=@"首页";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:JXColor(87, 173, 104, 1),NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                                      }];

}

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
