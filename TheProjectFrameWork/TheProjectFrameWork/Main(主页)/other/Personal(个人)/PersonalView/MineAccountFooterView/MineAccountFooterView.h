//
//  MineAccountFooterView.h
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  我的账户 退出登录按钮

#import <UIKit/UIKit.h>

@interface MineAccountFooterView : UIView
- (instancetype)initWithTitle:(NSString *)title
                  actionBlcok:(void (^)(id))block;
@end
