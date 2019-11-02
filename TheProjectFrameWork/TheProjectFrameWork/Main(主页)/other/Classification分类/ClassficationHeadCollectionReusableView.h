//
//  ClassficationHeadCollectionReusableView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassficationHeadCollectionReusableViewDelegate <NSObject>

-(void)ClassficationHeadCollectionReusableViewDeatialistClickWithseciton:(NSInteger)section;

@end

@interface ClassficationHeadCollectionReusableView : UICollectionReusableView
/** 背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
/** 区头详情 */
@property (weak, nonatomic) IBOutlet UILabel *detailContentlabel;
/** 排行榜 */
@property (weak, nonatomic) IBOutlet UIButton *detailListButton;
/** 具体区头数 */
@property(assign,nonatomic) NSInteger section;
/** 区头排行榜点击代理 */
@property(weak,nonatomic) id<ClassficationHeadCollectionReusableViewDelegate> delegate;
/**
 *  加载区头视图
 *
 *  @param section <#section description#>
 */
-(void)loadClassficationHeadViewWithSection:(NSInteger)section;
@end
