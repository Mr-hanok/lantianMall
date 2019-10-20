//
//  GoodsDetialNavigationTitleView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@protocol GoodsDetialNavigationTitleViewDelegate <NSObject>

-(void)GoodsDetialNavigationTitleViewButtionClicked:(UIButton*)button;

@end

@interface GoodsDetialNavigationTitleView : BaseView

@property (weak, nonatomic) IBOutlet UIButton *goodsButton;

@property (weak, nonatomic) IBOutlet UIButton *goodsdetialButton;

@property (weak, nonatomic) IBOutlet UIButton *goodsEvaluation;

@property (weak, nonatomic) IBOutlet UIView *scrollerView;

@property(weak,nonatomic) id <GoodsDetialNavigationTitleViewDelegate> delegate;

-(void)setScrollerWith:(NSInteger)Index;

@end
