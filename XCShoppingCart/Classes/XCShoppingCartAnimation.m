//
//  XCShoppingCartAnimation.m
//  XCShoppingCartAnimcation
//
//  Created by 樊小聪 on 2018/5/15.
//  Copyright © 2018年 樊小聪. All rights reserved.
//


/*
 *  备注：购物车相关的动画 🐾
 */

#import "XCShoppingCartAnimation.h"

@implementation XCShoppingCartAnimation

/**
 *  物品加入购物车时的抛物线动画
 *
 *  @param from 起点坐标
 *  @param to   终点坐标
 */
+ (CAAnimation *)throwAnimationFromPoint:(CGPoint)from
                                 toPoint:(CGPoint)to
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(from.x, from.y)];
    /// 三点曲线
    [path addCurveToPoint:CGPointMake(to.x, to.y)
            controlPoint1:CGPointMake(from.x, from.y)
            controlPoint2:CGPointMake(from.x - 180, from.y - 200)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation, alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    
    return groups;
}

@end
