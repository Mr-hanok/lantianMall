//
//  ShoppingCostDetialsView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@interface ShoppingCostDetialsView : BaseView
@property(assign,nonatomic) BOOL isShow;
@property (weak, nonatomic) IBOutlet UIView *costDetialView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *tapView;

-(void)showView;

-(void)viewDissMissFromWindow;
@end
