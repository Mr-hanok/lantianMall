//
//  PopShopGoodsInfoView.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/10.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "GoodsDetialModel.h"

@interface PopShopGoodsInfoView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(assign,nonatomic) BOOL isShow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UIView *tableheadview;
@property (weak, nonatomic) IBOutlet UIView *tablefootview;

/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;
/**
 *  显示视图
 */
-(void)showView;

/** 展示数组 */
-(void)loadViewWithShopModel:(GoodsDetialModel*)model;
@end
