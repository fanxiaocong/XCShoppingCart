//
//  XCTTTCell.m
//  XCShoppingCart_Example
//
//  Created by 樊小聪 on 2020/1/15.
//  Copyright © 2020 fanxiaocong. All rights reserved.
//

#import "XCTTTCell.h"

@implementation XCTTTCell

#pragma mark - 🎬 👀 Action Method 👀

/**
 *  点击 删除按钮 的回调
 */
- (IBAction)didClickDeleteButtonAction:(id)sender
{
    if (self.clickDeleteCallBack) {
        self.clickDeleteCallBack();
    }
}

@end
