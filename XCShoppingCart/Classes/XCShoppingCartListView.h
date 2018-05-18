//
//  XCShoppingCartListView.h
//  XCShoppingCartAnimcation
//
//  Created by 樊小聪 on 2018/5/15.
//  Copyright © 2018年 樊小聪. All rights reserved.
//

/*
 *  备注：购物车内商品列表视图 🐾
 */

#import <UIKit/UIKit.h>

@interface XCShoppingCartListView : UIView

/// 行高
@property (assign, nonatomic) CGFloat rowHeight;
/// 数据源
@property (strong, nonatomic) NSMutableArray *dataSource;
/// 配置cell
@property (copy, nonatomic) UITableViewCell *(^cellForRowAtIndex)(XCShoppingCartListView *listView, UITableView *tableView, NSInteger index);
/// 选中某一行的回调
@property (copy, nonatomic) void(^didSelectRowAtIndex)(UITableView *tableView, NSInteger index);


/**
 *  刷新数据源
 */
- (void)reloadData;

@end
