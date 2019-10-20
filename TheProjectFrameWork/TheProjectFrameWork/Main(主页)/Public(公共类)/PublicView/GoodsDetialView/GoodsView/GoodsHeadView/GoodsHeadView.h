//
//  GoodsHeadView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
#import "SDCycleScrollView.h"

@protocol GoodsHeadViewDelegete <NSObject>

-(void)GoodsHeadViewDidselected;
-(void)ScrolledToNext;

@end

@interface GoodsHeadView : BaseView
/** 轮播视图 */
@property (weak, nonatomic) IBOutlet UIScrollView * headScrollerView;

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@property(strong,nonatomic) SDCycleScrollView * ScrollerView;

/** 代理 */
@property(weak,nonatomic) id <GoodsHeadViewDelegete> delegate;
-(void)loadScrollerViewWithArray:(NSArray*)array;


@end
