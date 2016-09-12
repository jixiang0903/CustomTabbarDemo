//
//  JXTabbar.h
//  Wenfang
//
//  Created by jixiang on 15/10/15.
//  Copyright © 2015年 duzhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXTabBarViewController.h"
@interface JXTabbar : UIView
//点击事件回调
@property(nonatomic, strong)void (^clickBlock)(int index);
//创建item
//-(void)createMyTabbarWithTabbarInfo:(NSDictionary *)plistDist;
- (void)createMyTabbarWithTabbarInfo:(NSDictionary *)plistDist;
//默认选中item位置
- (void)autoSelectTabbarItem:(NSInteger)index;
//手动选中item位置
- (void)selectTabbarItem:(NSInteger)index;
/** 给某个按钮设置徽标  number = 0即为清除徽标 */
- (void)setBadgeWithSite:(NSInteger)index andNumber:(NSInteger)number;

/** 给某个按钮设置标注  */
- (void)setMarkWithSite:(NSInteger)index;

/** 给某个按钮清除标注  */
- (void)removeMarkWithSite:(NSInteger)index;


@end
