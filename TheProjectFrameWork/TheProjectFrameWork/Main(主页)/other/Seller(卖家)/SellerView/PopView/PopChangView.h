//
//  PopChangView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
typedef void(^PopChangViewBlock)(BOOL  select);

@interface PopChangView : BaseView
@property (weak, nonatomic) IBOutlet UIView *tapView;

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIButton *changelogisticsButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightToTop;

@property(copy,nonatomic) PopChangViewBlock block;

@property(assign,nonatomic) BOOL isShow;

+(id)loadViewWith:(NSString*)name;
/**
 
 *  移除视图
 
 */
-(void)viewDissMissFromWindow;
/**
 
 *  显示视图
 
 */
-(void)showViewWithheight:(CGFloat)height withBlcok:(PopChangViewBlock)block;


@end
