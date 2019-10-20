//
//  PopMoreView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

typedef void(^PopMoreViewBlock)(SelectTypes type);

@interface PopMoreView : BaseView
/** 联系卖家 */
@property (weak, nonatomic) IBOutlet UIButton *ContactthesellerButton;
/** 投诉 */
@property (weak, nonatomic) IBOutlet UIButton *complaintsButton;

@property (weak, nonatomic) IBOutlet UIView *tapView;

@property(assign,nonatomic) BOOL isShow;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backToBottom;

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;

@property(copy,nonatomic) PopMoreViewBlock block;

/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;
/**
 *  显示视图
 */

-(void)showViewWithheight:(CGFloat)height withBlcok:(PopMoreViewBlock)block;
@end
