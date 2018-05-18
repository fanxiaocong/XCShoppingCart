//
//  XCShoppingCartAnimation.h
//  XCShoppingCartAnimcation
//
//  Created by 樊小聪 on 2018/5/15.
//  Copyright © 2018年 樊小聪. All rights reserved.
//


/*
 *  备注：购物车相关的动画 🐾
 */

#import <UIKit/UIKit.h>

@interface XCShoppingCartAnimation : NSObject

/**
 *  物品加入购物车时的抛物线动画
 *
 *  @param from 起点坐标
 *  @param to   终点坐标
 */
+ (CAAnimation *)throwAnimationFromPoint:(CGPoint)from
                                 toPoint:(CGPoint)to;

@end
