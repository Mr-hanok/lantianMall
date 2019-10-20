//
//  PoprefundMoneyView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

typedef void (^PopInfoBlock)(BOOL success);

@interface PoprefundMoneyView : BaseView

@property(assign,nonatomic) BOOL isShow;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *RefundtipsButton;
@property (weak, nonatomic) IBOutlet UILabel *RefundDetialButton;
@property (weak, nonatomic) IBOutlet UIButton *calcelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property(copy,nonatomic) PopInfoBlock blcok;


/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;

/**
 *  获取退款
 *
 *  @param block <#block description#>
 */
-(void)GetpopInfo:(PopInfoBlock)block;
/**
 *  显示视图
 */
-(void)showView;
@end
