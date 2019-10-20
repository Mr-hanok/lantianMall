//
//  OrderTableFootView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

@class OrderTableFootView;
#import <UIKit/UIKit.h>

@protocol OrderTableFootViewDelegate <NSObject>

@optional

/** 删除订单 */
-(void)DelegateOrderButtonClickedWithSection:(NSInteger)section;

/** 联系卖家 */
-(void)ConnectSellerButtonClickedWithSection:(NSInteger)section;

/** 投诉 */
-(void)complaintsButtonClickedWithSection:(NSInteger)section;

/** 评价 */
-(void)ToevaluationButtonClickedWithSection:(NSInteger)section;

/** 退款 */
-(void)refundButtonClickedWithSection:(NSInteger)section;

/** 查看物流 */
-(void)CheckTheLogisticsButtonClickedWithSection:(NSInteger)section;

/** 确认收货 */
-(void)ConfimAceptButtonClickedWithSection:(NSInteger)section;

/** 付款 */
-(void)PayMoneyButtonClickedWithSection:(NSInteger)section;

/** 取消订单 */
-(void)CanCelOrderButtonClickedWithSection:(NSInteger)section;

/** 取消退款 */
-(void)CanCelrefundButtonClickedWithSection:(NSInteger)section;

/** 查看评价 */
-(void)LookEvaluationButtonClickedWithSection:(NSInteger)section;


-(void)OrderMoreButtonClicked:(UIButton*)button withOrderType:(OrderTypes)type andSection:(NSInteger)section andView:(OrderTableFootView*)view;



@end

@interface OrderTableFootView : UITableViewHeaderFooterView
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIButton *middleButton;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property(assign,nonatomic) OrderTypes celltype;

@property(assign,nonatomic) NSInteger  section;

@property (weak, nonatomic) IBOutlet UILabel *totalcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *inclDeliveryLabel;
/** 是否发货 */
@property(assign,nonatomic) BOOL  evaluate;


@property (weak, nonatomic) IBOutlet UIButton *left2Buttom;


@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midBtnLeadingConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftbtnLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left2BtnLeadIngConstraint;
@property(weak,nonatomic) id <OrderTableFootViewDelegate> delegate;

-(void)loaddata:(id)model with:(OrderTypes)type withSection:(NSInteger) section;

@end
