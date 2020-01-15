//
//  XCTTTCell.h
//  XCShoppingCart_Example
//
//  Created by 樊小聪 on 2020/1/15.
//  Copyright © 2020 fanxiaocong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCTTTCell : UITableViewCell

@property (copy, nonatomic) void(^clickDeleteCallBack)(void);

@end

NS_ASSUME_NONNULL_END
