//
//  HomeTableViewHeadView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "HomeTableViewHeadSectionViewDelegate.h"
@class SDCycleScrollView;

@interface HomeTableViewHeadView : UITableViewHeaderFooterView
/** 内容详情 */
@property (weak, nonatomic) IBOutlet UILabel *contentDetialLabel;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 金木水火土 背景图 */
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
/** 更多图片 */
@property (weak, nonatomic) IBOutlet UIImageView *moreIamgeView;
/** 更多按钮 */
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
/** 滑动视图 */
@property (weak, nonatomic) IBOutlet UIView *scrollerView;
/** 轮播视图 */
@property(strong,nonatomic) SDCycleScrollView * ScrollView;
/** 轮播图数组 */
@property(strong,nonatomic) NSArray * imageDataArray;

/** 数据源 */
@property(strong,nonatomic) NSMutableArray * dataArray;

@property(assign,nonatomic)id <HomeTableViewHeadSectionViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@property(assign,nonatomic) NSInteger section;


-(void)loadViewWith:(NSArray*)array WithSection:(NSInteger)section ;

@end
