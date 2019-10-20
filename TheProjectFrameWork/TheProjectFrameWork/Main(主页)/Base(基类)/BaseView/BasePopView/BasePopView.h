//
//  BasePopView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  弹出视图base
 */
@interface BasePopView : UIView

@property (nonatomic , weak) UIView * contentView; ///< 主要显示内容

/**
 *  显示在window上
 */
- (void)displayFromWindow;
/**
 *  从window上移除
 */
- (void)removeFromWindow;
@end
