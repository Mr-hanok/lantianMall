//
//  PopShopView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
@class GoodsDetialModel;

@protocol PopShopViewDelegate <NSObject>

-(void)selected:(id)content with:(id)model;

@end

@interface PopShopView : BaseView

@property (weak, nonatomic) IBOutlet UITableView *goodsDetialtableView;

@property(assign,nonatomic) BOOL isShow;

@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsDescriptionLabel;
@property(strong,nonatomic) GoodsDetialModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property(strong,nonatomic) NSMutableArray * dataArray;

@property(strong,nonatomic) NSMutableDictionary * resultDic;
/** 确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property(weak,nonatomic) id <PopShopViewDelegate> delegate;



/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;
/**
 *  显示视图
 */
-(void)showView;
/** 展示数组 */
-(void)loadViewWith:(NSArray*)array shopModel:(GoodsDetialModel*)model;

@end
