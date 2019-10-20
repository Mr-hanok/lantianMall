//
//  GoodsView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"
@class GoodsDetialModel;

@protocol GoodsViewDelegate <NSObject>

-(void)GoodsViewscrollerToNext;

-(void)shareButtonClicked;

-(void)GoodsViewSelected:(NSString*)number andpamar:(NSString*)pamara andpamarID:(NSString*)pamarID with:(PoPTypes)types;


@end

typedef void(^GoodsViewBlock)(id model , BOOL success);

@interface GoodsView : BaseView

@property(strong,nonatomic) GoodsDetialModel * model;
/** 弹出视图类型 */
@property(assign,nonatomic) PoPTypes type;

@property(copy,nonatomic) GoodsViewBlock block;

/** <#注释#> */
@property(weak,nonatomic)id<GoodsViewDelegate> delegate;
/** 加载顶部轮播图 */
-(void)LoadData:(NSArray*)array;

-(void)PopShowViewWith:(PoPTypes)type andblock:(GoodsViewBlock)blcok;

@end
