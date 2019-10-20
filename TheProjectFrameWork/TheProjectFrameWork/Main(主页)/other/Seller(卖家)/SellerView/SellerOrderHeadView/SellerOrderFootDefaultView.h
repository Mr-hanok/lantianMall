//
//  SellerOrderFootDefaultView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SellerOrderFootDefaultView;

@protocol SellerOrderFootDefaultViewDelegate <NSObject>

@optional
/** 修改费用 */
-(void)SellerChangeMoneyButtonClickedWithSection:(NSInteger)section;

/** 取消订单 */
-(void)SellerCanCelOrderButtonClickedWithSection:(NSInteger)section;

/** 投诉 */
-(void)SellercomplaintsButtonClickedWithSection:(NSInteger)section;

/** 发货 */
-(void)SellerSendGoodsButtonClickedWithSection:(NSInteger)section;

/** 准备发货 */
-(void)SellerSendINGSGoodsButtonClickedWithSection:(NSInteger)section;

/** 线下发货 */
-(void)SellerSendINGSGoodsUndelineButtonClickedWithSection:(NSInteger)section;

/** 退款 */
-(void)SellerrefundButtonClickedWithSection:(NSInteger)section;

/** 查看物流 */
-(void)SellerCheckTheLogisticsButtonClickedWithSection:(NSInteger)section;

/** 评价买家 */
-(void)SellerToevaluationBuyyerButtonClickedWithSection:(NSInteger)section;

/** 删除订单 */
-(void)SellerDelegateOrderButtonClickedWithSection:(NSInteger)section;

/** 查看评价 */
-(void)SellerLookevaluationButtonClickedWithSection:(NSInteger)section;




-(void)SellerOrderMoreButtonClicked:(UIButton*)button withOrderType:(SellerOrderTypes)type andSection:(NSInteger)section andView:(SellerOrderFootDefaultView*)view;


@end

@interface SellerOrderFootDefaultView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UIButton *middleButton;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalcoutLabel;
@property (weak, nonatomic) IBOutlet UILabel *invLabel;

@property(assign,nonatomic) SellerOrderTypes  types;

@property(weak,nonatomic) id <SellerOrderFootDefaultViewDelegate> delegate;

@property(assign,nonatomic) NSInteger section;

@property(assign,nonatomic) BOOL evaluate;

-(void)loadDataModel:(id)model With:(SellerOrderTypes)types  senction:(NSInteger)section;
@end
