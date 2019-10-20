//
//  ShopHeadCollectionReusableView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
@class ShopHeadCollectionReusableView;
@protocol ShopHeadCollectionReusableViewDelegate <NSObject>

- (void)shopHeadCollectionReusableView:(ShopHeadCollectionReusableView *)head indexparRow:(NSInteger)row;

@end
#import <UIKit/UIKit.h>
@class SDCycleScrollView;
@interface ShopHeadCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
/** 关注按钮 */
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
/** 关注数量 */
@property (weak, nonatomic) IBOutlet UILabel *attentNumberLabel;
/** 店铺名称 */
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *shopHeadView;

@property (weak, nonatomic) IBOutlet UIView *shopScrollerView;

@property(strong,nonatomic) SDCycleScrollView * ScrollerView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;

@property (nonatomic, weak) id<ShopHeadCollectionReusableViewDelegate> delegate;
-(void)loadViewWith:(NSArray *)array vipPrice:(NSArray *)viparray;
@end
