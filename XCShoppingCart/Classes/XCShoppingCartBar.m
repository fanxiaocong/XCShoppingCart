//
//  XCShoppingCartBar.m
//  XCShoppingCartAnimcation
//
//  Created by 樊小聪 on 2018/5/15.
//  Copyright © 2018年 樊小聪. All rights reserved.
//


/*
 *  备注：购物车工具条（包括：购物车Button、价格LB、确认Button） 🐾
 */

#import "XCShoppingCartBar.h"
#import "XCShoppingCarUnit.h"
#import <JSBadgeView/JSBadgeView.h>


@interface XCShopCartButton : UIButton
@end
@implementation XCShopCartButton
- (void)setHighlighted:(BOOL)highlighted {}
@end



@interface XCShoppingCartBar ()

@property (weak, nonatomic) JSBadgeView *badgeView;
/** 👀 蒙板 👀 */
@property (weak, nonatomic) UIButton *mask;
/** 👀 listView 的容器视图 👀 */
@property (strong, nonatomic) UIView *listContainerView;

@end


@implementation XCShoppingCartBar

- (void)dealloc
{
    _listContainerView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        /// 设置UI
        [self setupUI];
    }
    return self;
}

/**
 *  设置 UI
 */
- (void)setupUI
{
    /// --- XCShoppingCartBar 的 subViews
    /// 购物车按钮
    XCShopCartButton *cartButton = [XCShopCartButton buttonWithType:UIButtonTypeCustom];
    _cartButton = cartButton;
    [_cartButton setImage:[XCShoppingCarUnit imageNamed:@"icon_cart_nor"] forState:UIControlStateNormal];
    [_cartButton setImage:[XCShoppingCarUnit imageNamed:@"icon_cart_disable"] forState:UIControlStateDisabled];
    [self addSubview:cartButton];
    
    /// 确认按钮
    XCShopCartButton *enterButton = [XCShopCartButton buttonWithType:UIButtonTypeCustom];
    _enterButton = enterButton;
    [_enterButton setTitle:@"去结算" forState:UIControlStateNormal];
    [_enterButton setTitle:@"请选择商品" forState:UIControlStateDisabled];
    [_enterButton setBackgroundImage:[XCShoppingCarUnit imageFromColor:RGB_COLOR(109, 213, 147)] forState:UIControlStateNormal];
    [_enterButton setBackgroundImage:[XCShoppingCarUnit imageFromColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    [_enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:enterButton];
    
    /// 价格LB
    UILabel *priceLabel = [[UILabel alloc] init];
    _priceLabel = priceLabel;
    [self addSubview:priceLabel];
    
    /// 角标
    JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.cartButton alignment:JSBadgeViewAlignmentTopRight];
    _badgeView = badgeView;
    
    
    /// 设置 subView 的 frame
    [self setupSubViewsFrame];
    
    
    /// ListContainerView
    CGFloat containerViewX = 0;
    CGFloat containerViewY = 0;
    CGFloat containerViewW = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat containerViewH = CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(self.bounds);
    UIView *listContainerView = [[UIView alloc] initWithFrame:CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH)];
    _listContainerView = listContainerView;
    _listContainerView.backgroundColor = [UIColor clearColor];
    _listContainerView.clipsToBounds = YES;
    
    /// maskView
    UIButton *maskView = [[UIButton alloc] initWithFrame:listContainerView.bounds];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.35f];
    [maskView addTarget:self action:@selector(didClickMaskButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _mask = maskView;
    _mask.alpha = 0;
    [_listContainerView addSubview:maskView];
    
    /// 列表listView
    XCShoppingCartListView *listView = [[XCShoppingCartListView alloc] initWithFrame:CGRectZero];
    _listView = listView;
    _listView.backgroundColor = RGB_COLOR(243, 243, 243);
    _listView.rowHeight = 50;
    [_listContainerView addSubview:listView];
    
    
    /// 设置默认数据
    self.backgroundColor = [UIColor whiteColor];
    self.badgeNumber = 0;
    self.badgeInnerMargin = 3;
    self.badgeOffset = CGPointMake(-10, 10);
    self.maxRows = 5;
    [self disabledCartBarUI];
}

/**
 *  设置 subView 的 frame
 */
- (void)setupSubViewsFrame
{
    CGFloat marginX = 10;
    
    /// 购物车按钮的 frame
    CGFloat cartButtonWH = 60;
    CGFloat cartButtonX  = marginX;
    CGFloat cartButtonY  = CGRectGetHeight(self.bounds) - cartButtonWH;
    self.cartButton.frame = CGRectMake(cartButtonX, cartButtonY, cartButtonWH, cartButtonWH);
    
    /// 确认按钮 frame
    CGFloat enterButtonH = CGRectGetHeight(self.bounds);
    CGFloat enterButtonW = 120;
    CGFloat enterButtonX = CGRectGetWidth(self.bounds) - enterButtonW;
    CGFloat enterButtonY = 0;
    self.enterButton.frame = CGRectMake(enterButtonX, enterButtonY, enterButtonW, enterButtonH);
    
    /// 价格LB frame
    CGFloat priceLabelX = CGRectGetMaxX(self.cartButton.frame) + marginX;
    CGFloat priceLabelY = 0;
    CGFloat priceLabelH = CGRectGetHeight(self.bounds);
    CGFloat priceLabelW = CGRectGetWidth(self.bounds) - enterButtonW - priceLabelX - marginX;
    self.priceLabel.frame = CGRectMake(priceLabelX, priceLabelY, priceLabelW, priceLabelH);
}

#pragma mark - 🛠 👀 Setter Method 👀

- (void)setBadgeColor:(UIColor *)badgeColor
{
    _badgeColor = badgeColor;
    self.badgeView.badgeTextColor = badgeColor;
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor
{
    _badgeBackgroundColor = badgeBackgroundColor;
    self.badgeView.badgeBackgroundColor = badgeBackgroundColor;
}

- (void)setBadgeOffset:(CGPoint)badgeOffset
{
    _badgeOffset = badgeOffset;
    self.badgeView.badgePositionAdjustment = badgeOffset;
}

- (void)setBadgeInnerMargin:(CGFloat)badgeInnerMargin
{
    _badgeInnerMargin = badgeInnerMargin;
    self.badgeView.badgeStrokeWidth = badgeInnerMargin;
}

- (void)setBadgeNumber:(NSInteger)badgeNumber
{
    _badgeNumber = badgeNumber;
    
    if (_badgeNumber <= 0) {    /// 购物车没有商品
        _badgeNumber = 0;
        self.badgeView.hidden = YES;
    } else {    /// 购物车有商品
        self.badgeView.hidden = NO;
        self.badgeView.badgeText = @(badgeNumber).description;
    }
}

- (void)setOpen:(BOOL)open
{
    if (open) {    /// 打开购物车
        [self openListView];
    } else {    /// 关闭购物车
        [self closeListView];
    }
    
    _open = open;
}

#pragma mark - 🎬 👀 Action Method 👀

/**
 *  点击蒙板的回调
 */
- (void)didClickMaskButtonAction
{
    // 关闭购物车
    self.open = NO;
}

#pragma mark - 🔒 👀 Privite Method 👀

/**
 *  获取 listView 的高度
 */
- (CGFloat)fetchListViewHeight
{
    /// cell 真实显示的数量
    NSInteger cellRealCount = self.listView.dataSource.count;
    return MIN(cellRealCount, self.maxRows) * self.listView.rowHeight;
}

/**
 *  将 cartButton 转到屏幕上
 */
- (void)bringCartButtonToWindow
{
    CGPoint cartButtonInScreenOrigin = [self convertPoint:self.cartButton.frame.origin toView:[UIApplication sharedApplication].keyWindow];
    self.cartButton.frame = CGRectMake(cartButtonInScreenOrigin.x,
                                       cartButtonInScreenOrigin.y,
                                       self.cartButton.bounds.size.width,
                                       self.cartButton.bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self.cartButton];
}

/**
 *  将 cartButton 转到 cartBar 上面
 */
- (void)bringCarButtonToCartBar
{
    CGPoint cartButtonInScreenOrigin = [[UIApplication sharedApplication].keyWindow convertPoint:self.cartButton.frame.origin toView:self];
    self.cartButton.frame = CGRectMake(cartButtonInScreenOrigin.x,
                                       cartButtonInScreenOrigin.y,
                                       self.cartButton.bounds.size.width,
                                       self.cartButton.bounds.size.height);
    [self addSubview:self.cartButton];
}

/**
 *  显示 listView
 */
- (void)openListView
{
    /// 如果此时已经打开购物车，则直接返回
    if (self.isOpen)    return;
    
    /// 设置 listView 的 frame
    CGFloat listViewW = CGRectGetWidth(self.listContainerView.bounds);
    CGFloat listViewH = [self fetchListViewHeight];
    CGFloat listViewX = 0;
    CGFloat listViewY = CGRectGetHeight(self.listContainerView.bounds);
    self.listView.frame = CGRectMake(listViewX, listViewY, listViewW, listViewH);
    
    /// 添加到 window 上
    [[UIApplication sharedApplication].keyWindow addSubview:self.listContainerView];
    
    /// 将 cartButton 添加到 window 上
    [self bringCartButtonToWindow];

    CGFloat cartButtonOffsetY = listViewH + CGRectGetHeight(self.bounds);
    
    /// 动画
    self.cartButton.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3f animations:^{
        
        self.mask.alpha = 1;
        
        /// listView
        self.listView.transform = CGAffineTransformMakeTranslation(0, - listViewH);
        /// 移动购物车按钮
        self.cartButton.transform = CGAffineTransformMakeTranslation(0, - cartButtonOffsetY);
        /// 底部价格LB
        self.priceLabel.transform = CGAffineTransformMakeTranslation(- CGRectGetWidth(self.cartButton.bounds), 0);
    }];
}

/**
 *  关闭 listView
 */
- (void)closeListView
{
    /// 如果此时没有打开购物车，则直接返回
    if (!self.isOpen)   return;
    
    /// 动画
    [UIView animateWithDuration:.3f animations:^{
        
        self.mask.alpha = 0;
        /// 复位
        self.listView.transform = CGAffineTransformIdentity;
        self.cartButton.transform = CGAffineTransformIdentity;
        self.priceLabel.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        // 移除 containerView
        self.cartButton.userInteractionEnabled = YES;
        [self.listContainerView removeFromSuperview];
        [self bringCarButtonToCartBar];
    }];
}

/**
 *  enable购物车工具条上的UI
 */
- (void)enabledCartBarUI
{
    self.priceLabel.font = [UIFont systemFontOfSize:20];
    self.priceLabel.textColor = [UIColor redColor];
    self.cartButton.enabled = YES;
    self.enterButton.enabled = YES;
}

/**
 *  disable购物车工具条上的UI
 */
- (void)disabledCartBarUI
{
    self.priceLabel.font = [UIFont systemFontOfSize:13];
    self.priceLabel.text = @"购物车空空如也〜";
    self.priceLabel.textColor = [UIColor grayColor];
    self.cartButton.enabled = NO;
    self.enterButton.enabled = NO;
}

#pragma mark - 🔓 👀 Public Method 👀

/**
 *  更新UI
 */
- (void)refreshUI
{
    [self.listView reloadData];
    
    if (0 == self.listView.dataSource.count) { /// 购物车没有商品
        [self disabledCartBarUI];
        // 关闭购物车
        if (self.isOpen) {
            self.open = NO;
        }
    } else {    /// 购物车中存在商品
        [self enabledCartBarUI];
        /// 如果此时购物车是关闭的，则直接返回
        if (!self.isOpen)   return;
        
        /// 按钮需要移动的距离
        CGFloat cartButtonOffsetY = [self fetchListViewHeight] + CGRectGetHeight(self.bounds);
        
        CGRect listViewF = self.listView.frame;
        listViewF.size.height = [self fetchListViewHeight];
        
        /// 更新 listView 的高度
        [UIView animateWithDuration:.5f animations:^{
            /// listView
            self.listView.frame = listViewF;
            /// 移动购物车按钮
            self.cartButton.transform = CGAffineTransformMakeTranslation(0, - cartButtonOffsetY);
        }];
    }
}

@end
