//
//  SellerOrderHeadDefaultView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SellerOrderHeadDefaultView.h"
#import "BuyerOrderModel.h"

@implementation SellerOrderHeadDefaultView

-(void)loadData:(id)model with:(SellerOrderTypes)type section:(NSInteger)section
{
    self.orderTypeLabel.textColor = kNavigationColor;
    BuyerOrderModel *models= model;
    self.evaluate = models.evaluate;
    if (KScreenBoundWidth>320)
    {
        self.orderTypeLabel.font = KSystemFont(12);
        self.orderNumberLabel.font = KSystemFont(12);
    }
    else
    {
        self.orderTypeLabel.font = KSystemFont(11);
        self.orderNumberLabel.font = KSystemFont(11);
    }
    self.orderNumberLabel.text = LaguageControlAppendStrings(@"订单编号",models.order_id);
    switch (type) {
        case SellerOrderTypesSuccess:
            self.orderTypeLabel.text = LaguageControl(@"已完成");
            break;
        case SellerOrderTypesToPay:
            self.orderTypeLabel.text = LaguageControl(@"待付款");

            break;
        case SellerOrderTypesToSend:
            self.orderTypeLabel.text = LaguageControl(@"待发货");

            break;
        case SellerOrderTypesToAccept:
            self.orderTypeLabel.text = LaguageControl(@"待收货");

            break;
        case SellerOrderTypesToEvaluation:
            self.orderTypeLabel.text = LaguageControl(@"已收货");
            break;
        case SellerOrderTypesCanCeled:
            self.orderTypeLabel.text = LaguageControl(@"已取消");

            break;
        case SellerOrderTypesRefund:
            self.orderTypeLabel.text = LaguageControl(@"申请中");
            break;
        case SellerOrderTypesSendIng:
           
            self.orderTypeLabel.text = LaguageControl(@"准备发货");
            break;
        case SellerOrderTypesRefundSuccess:
            self.orderTypeLabel.text = LaguageControl(@"已退款");
            break;
        case SellerOrderTypesToPayUnderLine:
            self.orderTypeLabel.text = LaguageControl(@"线下支付待审核");
            break;
        default:
            self.orderTypeLabel.text = LaguageControl(@"订单状态对不上");
            
            break;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
