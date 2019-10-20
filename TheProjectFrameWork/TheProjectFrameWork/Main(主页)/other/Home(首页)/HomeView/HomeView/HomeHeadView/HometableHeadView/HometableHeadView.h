//
//  HometableHeadView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

@class SDCycleScrollView;
#import "BaseView.h"

@protocol HometableHeadViewDelegate <NSObject>

@optional
/**
 *  <#Description#>
 *
 *  @param view  <#view description#>
 *  @param index 点击具体某个
 */
-(void)HometableHeadView:(SDCycleScrollView*)view didSelectItemAtIndex:(NSInteger)index;
/**
 *  <#Description#>
 *
 *  @param index 点击某个原点
 */
- (void)HometableHeadViewindexOnPageControl:(NSInteger)index;
/**
 *  <#Description#>
 *
 *  @param index 下面内容点击
 */
-(void)HometableHeadViewCollectionViewdidSelected:(NSInteger)index;

@end

@interface HometableHeadView : BaseView
/** 轮播图 */
@property (weak, nonatomic) IBOutlet UIView *imagePlayerScrollerView;
/** 顶部内容 */
@property (weak, nonatomic) IBOutlet UICollectionView *headCollectionView;
/** 轮播图数组 */
@property(strong,nonatomic) NSArray * imageDataArray;
/** collectionView */
@property(strong,nonatomic) NSMutableArray * datacollectionArray;
/** 轮播视图 */
@property(strong,nonatomic) SDCycleScrollView * ScrollerView;

/** 代理 */
@property(weak,nonatomic) id <HometableHeadViewDelegate> delegate;
/**
 *  试图创建
 *
 *  @param frame frame
 *
 *  @return <#return value description#>
 */
+(HometableHeadView*)headViewLoadViewWithframe:(CGRect)frame;
/**
 *  视图重新加载
 */
-(void)loadView;
@end
