//
//  UIButton+MultiClick.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/9/11.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MultiClick)

/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
@end
