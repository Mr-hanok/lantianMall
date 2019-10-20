//
//  StarView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StarViewSetValueBlock)(float values);

@interface StarView : UIView

/** 是否显示默认label */
@property (nonatomic,assign) BOOL isShow;
/** 高度 */
@property(assign,nonatomic) CGFloat height;

/** 宽度 */
@property(assign,nonatomic) CGFloat width;

/** 间距宽度 */
@property(assign,nonatomic) CGFloat minwidth;

/** 显示多少分*/
@property (nonatomic,assign) float show_star;

/** 填充图片 */
@property(strong,nonatomic) UIImage * fullImage;

/** 背景图片 */

@property(strong,nonatomic) UIImage * backImage;


/** 设置是否可以点击选中   yes可以点击，拖动 No 用来简单显示*/

@property (nonatomic,assign) BOOL canSelected;

/** 点赞 */
@property(copy,nonatomic) StarViewSetValueBlock block;

-(void)GetValues:(StarViewSetValueBlock)block;

/**
 *  设置默认属性
 *
 *  @param width    宽
 *  @param minWidth 间距
 *  @param showStar 个数
 */
-(void)Setwidtt:(CGFloat)width minWidth:(CGFloat)minWidth showStar:(float)showStar;

-(void)Setwidtt:(CGFloat)width minWidth:(CGFloat)minWidth with:(NSString*)creditView;

@end
