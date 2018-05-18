//
//  XCShoppingCarUnit.m
//  XCShoppingCartAnimcation
//
//  Created by 樊小聪 on 2018/5/17.
//  Copyright © 2018年 樊小聪. All rights reserved.
//

#import "XCShoppingCarUnit.h"

@implementation XCShoppingCarUnit

+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    // 开启一个 位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取当前的位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    // 开始填充
    CGContextFillRect(context, rect);
    
    // 获得 当前上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束 位图上下文
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageNamed:(NSString *)imageName
{    
    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    NSString *bundleName = [currentBundle.infoDictionary[@"CFBundleName"] stringByAppendingString:@".bundle"];
    NSString *imagePath  = [currentBundle pathForResource:imageName ofType:@"png" inDirectory:bundleName];
    
    return [UIImage imageWithContentsOfFile:imagePath];
}

@end
