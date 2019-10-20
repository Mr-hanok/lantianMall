//
//  HomeClassView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@protocol HomeClassViewDelegate <NSObject>

-(void)HomeClassDidSelectedwithIndex:(NSIndexPath*)indexPath;

@end

@interface HomeClassView : BaseView
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIView *ContentView;
/** 分类列表菜单 */
@property (weak, nonatomic) IBOutlet UITableView *classTableView;
/** 选择 */
@property(strong,nonatomic) NSIndexPath * selectIndex;
/** 数组 */
@property(strong,nonatomic) NSMutableArray * dataArray;
/** 是否处于展示状态 */
@property(assign,nonatomic) BOOL isShow;

@property (weak, nonatomic) IBOutlet UIView *tapView;

@property(weak,nonatomic) id<HomeClassViewDelegate>delegate;

+(HomeClassView*)CreateView;
/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;
/**
 *  显示视图
 */
-(void)showView;
/** 展示数组 */
-(void)loadViewWith:(NSArray*)array;
@end
