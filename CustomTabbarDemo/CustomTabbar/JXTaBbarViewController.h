//
//  JXTaBbarViewController.h
//  CustomTabbarDemo
//
//  Created by 吉祥 on 16/9/12.
//  Copyright © 2016年 jixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXTaBbarViewController : UITabBarController
//点击某个tabbaritem
- (void)selectTabbarItem:(NSInteger)index;

/** 给某个tabbarItem加标识 */
- (void)addMarkWithSite:(NSInteger)index;

@end
