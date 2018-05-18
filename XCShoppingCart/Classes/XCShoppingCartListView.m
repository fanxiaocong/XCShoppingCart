//
//  XCShoppingCartListView.m
//  XCShoppingCartAnimcation
//
//  Created by 樊小聪 on 2018/5/15.
//  Copyright © 2018年 樊小聪. All rights reserved.
//


/*
 *  备注：购物车内商品列表视图 🐾
 */

#import "XCShoppingCartListView.h"

@interface XCShoppingCartListView ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@end


@implementation XCShoppingCartListView

#pragma mark - 🔓 👀 Public Method 👀

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark - 💤 👀 LazyLoad Method 👀

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:tableView];
    }
    
    return _tableView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark - 🛠 👀 Setter Method 👀

- (void)setRowHeight:(CGFloat)rowHeight
{
    _rowHeight = rowHeight;
    
    self.tableView.rowHeight = rowHeight;
}

#pragma mark - 📕 👀 UITableViewDataSource 👀

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellForRowAtIndex) {
        return self.cellForRowAtIndex(self, tableView, indexPath.row);
    }
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#pragma mark - 💉 👀 UITableViewDelegate 👀

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectRowAtIndex) {
        self.didSelectRowAtIndex(tableView, indexPath.row);
    }
}

@end
