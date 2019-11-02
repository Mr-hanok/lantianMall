//
//  IntegralMallHeadView.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
@class IntegralMallHeadView;
@protocol IntegralMallHeadViewDelegate <NSObject>

- (void)integralMallHeadView:(IntegralMallHeadView *)headView indexNum:(NSInteger )indexNum;

@end
#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
/**积分商城头视图  轮播图view*/
@interface IntegralMallHeadView : UICollectionReusableView<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bannerView;
/** 轮播视图 */
@property(strong,nonatomic) SDCycleScrollView * ScrollerView;

@property (nonatomic, weak)id<IntegralMallHeadViewDelegate>delegate ;

-(void)loadViewWith:(NSArray*)array WithSection:(NSInteger)section;
@end
