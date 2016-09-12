//
//  JXTabbar.m
//  Wenfang
//
//  Created by jixiang on 15/10/15.
//  Copyright © 2015年 duzhe. All rights reserved.
//

#import "JXTabbar.h"
#import "JXTabBarViewController.h"
//颜色
#define JXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation JXTabbar
//对类外接口
-(void)createMyTabbarWithTabbarInfo:(NSDictionary *)plistDist{
    //1、解析背景图的名字和创建背景的ImageView
    NSString *imageName=[plistDist objectForKey:@"bgimage"];
    [self createBgImageViewWithImageName:imageName];
    //创建items
    NSArray *items=[plistDist objectForKey:@"items"];
    for (int i=0; i<items.count; i++) {
        [self createItemWithItemDict:[items objectAtIndex:i] andIndex:i andCount:(int)items.count];
    }
}
//默认选中item的位置
- (void)autoSelectTabbarItem:(NSInteger)index {
    for (UIView *subView in self.subviews) {
        for (UIButton *subBtn in subView.subviews) {
            if ([subBtn isKindOfClass:[UIButton class]]) {
                if (subBtn.tag == index) {
                    subBtn.selected = YES;
                }else{
                    subBtn.selected = NO;
                }
            }
        }
    }
}
//创建一个类导航条 相当于一个容器
-(void)createBgImageViewWithImageName:(NSString *)imageName{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame=self.bounds;
    [self addSubview:imageView];
}
//创建每一个按钮
-(void)createItemWithItemDict:(NSDictionary *)itemDict andIndex:(int)index andCount:(int)count{
    //实例化容器view
    UIView *baseView=[[UIView alloc]init];
    baseView.frame=CGRectMake(self.frame.size.width/count*index, 0, self.frame.size.width/count, self.frame.size.height);
    baseView.tag=index;
    [self addSubview:baseView];
    //
    UILabel *lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
    lineLabel.backgroundColor=JXColor(179, 211, 85, 1);
    [baseView addSubview:lineLabel];
    //实例化Button
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(baseView.frame.size.width/2-13, (baseView.frame.size.height-40)/2,30,40);
    UIImage *image=[UIImage imageNamed:[itemDict objectForKey:@"image"]];
    UIImage *image_press=[UIImage imageNamed:[itemDict objectForKey:@"image_press"]];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:image_press forState:UIControlStateSelected];
    //selected 状态下点击问题
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //取消点击变灰
    [btn setImage:image_press forState:UIControlStateSelected|UIControlStateHighlighted];
    [btn setAdjustsImageWhenHighlighted:NO];
    btn.tag=index;
    [baseView addSubview:btn];
    btn.selected=NO;
    if (0==index) {
        btn.selected=YES;
    }
}
- (void)btnClick:(UIButton *)btn {
    for (UIView *subView in self.subviews) {
        for (UIButton *view in subView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                    view.selected = NO;
                }
            }
        }
    btn.selected = YES;
    if (_clickBlock) {
        _clickBlock((int)btn.tag);
    }
    //删除徽标
    [self removeMarkWithSite:btn.tag];
}
#pragma private method
//通过index获取button
- (UIButton *)buttonWithIndex:(NSInteger)index {
    for (UIView *subView in self.subviews) {
        for (UIButton *view in subView.subviews) {
            if ([view isKindOfClass:[UIButton class]] && view.tag == index) {
                return view;
            }
        }
    }
    return nil;
}
#pragma mark public mehtod
/** 手动选中某个item */
- (void)selectTabbarItem:(NSInteger)index {
    UIButton *button = [self buttonWithIndex:index];
    [self btnClick:button];
}
/** 给某个按钮设置徽标  number = 0即为清除徽标 */
- (void)setBadgeWithSite:(NSInteger)index andNumber:(NSInteger)number {
    
    UIButton *button = [self buttonWithIndex:index];
    if (!button) {
        return;
    }
    
    UILabel *badgeLab = (UILabel *)[button viewWithTag:110110];
    
    if (number == 0) {//清除徽标
        [badgeLab removeFromSuperview];
        return;
        
    }else if (!badgeLab) {//不存在，创建
        badgeLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(button.frame)-25, 4, 14, 14)];
        badgeLab.tag = 110110;
        badgeLab.font = [UIFont systemFontOfSize:10];
        badgeLab.backgroundColor = [UIColor redColor];
        badgeLab.textAlignment = NSTextAlignmentCenter;
        badgeLab.textColor = [UIColor whiteColor];
        badgeLab.layer.masksToBounds = YES;
        badgeLab.layer.cornerRadius = 7;
        [button addSubview:badgeLab];
    }
    badgeLab.text = [NSString stringWithFormat:@"%ld",number];
    
}

/** 给某个按钮设置标注  */
- (void)setMarkWithSite:(NSInteger)index {
    UIButton *button = [self buttonWithIndex:index];
    if (!button) {
        return;
    }
    UIView *badgeView = [button viewWithTag:110111];
    if (!badgeView) {//不存在，创建
        badgeView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(button.frame)-5, 2, 8, 8)];
        badgeView.tag = 110111;
        badgeView.backgroundColor = [UIColor redColor];
        badgeView.layer.masksToBounds = YES;
        badgeView.layer.cornerRadius = 4;
        [button addSubview:badgeView];
    }
}
/** 给某个按钮清除标注  */
- (void)removeMarkWithSite:(NSInteger)index {
    UIButton *button = [self buttonWithIndex:index];
    UIView *badgeView = [button viewWithTag:110111];
    if (badgeView) {//存在，清除
        [badgeView removeFromSuperview];
    }
}

@end
