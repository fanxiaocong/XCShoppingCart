//
//  XCShoppingCarUnit.h
//  XCShoppingCartAnimcation
//
//  Created by 樊小聪 on 2018/5/17.
//  Copyright © 2018年 樊小聪. All rights reserved.
//

#import <UIKit/UIKit.h>


#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]


@interface XCShoppingCarUnit : NSObject

+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 *  根据图片名称加载图片
 *
 *  @param imageName 图片名称
 */
+ (UIImage *)imageNamed:(NSString *)imageName;

@end
