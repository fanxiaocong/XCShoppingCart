//
//  XCShoppingCartBar.h
//  XCShoppingCartAnimcation
//
//  Created by 樊小聪 on 2018/5/15.
//  Copyright © 2018年 樊小聪. All rights reserved.
//


/*
 *  备注：购物车工具条（包括：购物车Button、价格LB、确认Button） 🐾
 */

#import <UIKit/UIKit.h>
#import "XCShoppingCartListView.h"


@interface XCShoppingCartBar : UIView

/// 购物车按钮
@property (weak, nonatomic, readonly) UIButton *cartButton;
/// 确认按钮
@property (weak, nonatomic, readonly) UIButton *enterButton;
/// 价格LB
@property (weak, nonatomic, readonly) UILabel *priceLabel;
/// 列表视图
@property (weak, nonatomic, readonly) XCShoppingCartListView *listView;


/// 最大显示的行数，如果实际的行数超过这个值，则会滚动显示，默认 5 
@property (assign, nonatomic) NSInteger maxRows;
/// 角标数量
@property (assign, nonatomic) NSInteger badgeNumber;
/// 偏移量：默认 (-10, 10)
@property (assign, nonatomic) CGPoint badgeOffset;
/// 内边距：文字与边框的距离，默认 3
@property (assign, nonatomic) CGFloat badgeInnerMargin;
/// 角标文字颜色：默认 whiteColor
@property (strong, nonatomic) UIColor *badgeColor;
/// 角标背景颜色：默认 redColor
@property (strong, nonatomic) UIColor *badgeBackgroundColor;

/// 打开购物车
@property (assign, nonatomic, getter=isOpen) BOOL open;

/**
 *  更新UI：会更据购物车中商品的数量更新UI页面，此方法内部会调用 listView 的 reloadData 方法，然后根据 dataSource 的数量自动更新 listView 的高度；
 *  当 dataSource 的数据发生改变的时候需要调用此方法
 */
- (void)refreshUI;

@end
