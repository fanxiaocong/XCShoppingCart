//
//  XCViewController.m
//  XCShoppingCart
//
//  Created by fanxiaocong on 05/18/2018.
//  Copyright (c) 2018 fanxiaocong. All rights reserved.
//

#import "XCViewController.h"
#import <XCShoppingCart/XCShoppingCartBar.h>
#import <XCShoppingCart/XCShoppingCartAnimation.h>


@interface XCViewController ()

@property (weak, nonatomic) XCShoppingCartBar *cartBar;

@end


@implementation XCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XCShoppingCartBar *cartBar = [[XCShoppingCartBar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 50, CGRectGetWidth(self.view.bounds), 50)];
    // 点击购物车按钮的回调
    [cartBar.cartButton addTarget:self action:@selector(didClickCartButtonAction) forControlEvents:UIControlEventTouchUpInside];
    // 点击确认按钮的回调
    [cartBar.enterButton addTarget:self action:@selector(didClickEnterButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.cartBar = cartBar;
    [self.view addSubview:cartBar];
    
    // 配置cell
    self.cartBar.listView.cellForRowAtIndex = ^UITableViewCell *(XCShoppingCartListView *listView, UITableView *tableView, NSInteger index) {
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = listView.dataSource[index];
        return cell;
    };
}

#pragma mark - 🎬 👀 Action Method 👀

/**
 *  占击减号按钮的回调
 */
- (IBAction)didClickMinusButtonAction:(id)sender
{
    self.cartBar.badgeNumber --;
    [self.cartBar.listView.dataSource removeLastObject];
    [self.cartBar refreshUI];
}

/**
 *  点击添加按钮的回调
 */
- (IBAction)didClickAddButtonAction:(UIButton *)sender
{
    CGPoint fromCenter = [sender.superview convertPoint:sender.center toView:[UIApplication sharedApplication].keyWindow];
    CGPoint toCenter = [self.cartBar.cartButton.superview convertPoint:self.cartBar.cartButton.center toView:[UIApplication sharedApplication].keyWindow];
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 30, 30);
    layer.position = fromCenter;
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:layer];
    
    CAAnimation *animation = [XCShoppingCartAnimation throwAnimationFromPoint:fromCenter toPoint:CGPointMake(toCenter.x, toCenter.y)];
    [layer addAnimation:animation forKey:nil];
    
    /// 动画结束后移除对应的图层
    [layer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:.8f];
    
    self.cartBar.badgeNumber ++;
    [self.cartBar.listView.dataSource addObject:@(self.cartBar.badgeNumber).description];
    self.cartBar.priceLabel.text = @"总价：¥100";
    /// 当数据源改变之后需要刷新UI
    [self.cartBar refreshUI];
}


/**
 *  点击购物车按钮的回调
 */
- (void)didClickCartButtonAction
{
    NSLog(@"点击了购物车按钮");
    self.cartBar.open = YES;
}

/**
 *  点击确认按钮的回调
 */
- (void)didClickEnterButtonAction
{
    NSLog(@"点击了确认按钮");
    self.cartBar.open = NO;
}


@end
