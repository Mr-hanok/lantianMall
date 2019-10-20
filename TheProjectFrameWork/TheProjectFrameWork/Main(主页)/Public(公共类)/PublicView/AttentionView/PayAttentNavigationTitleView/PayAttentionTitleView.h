//
//  PayAttentionTitleView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@protocol PayAttentionTitleViewDelegate <NSObject>

-(void)PayAttentionTitleViewButtonClicked:(UIButton*)button;

@end
@interface PayAttentionTitleView : BaseView
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIButton *goodsButton;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIButton *shopButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopBtnWith;

@property(weak,nonatomic) id<PayAttentionTitleViewDelegate> delegate;

@end
