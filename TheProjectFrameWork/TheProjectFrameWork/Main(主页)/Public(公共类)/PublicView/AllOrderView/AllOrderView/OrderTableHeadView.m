//
//  OrderTableHeadView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderTableHeadView.h"
#import "BuyerOrderModel.h"

@implementation OrderTableHeadView
- (IBAction)shopbtnClick:(UIButton *)sender {
    if (self.shopbtnClickBlock) {
        self.shopbtnClickBlock(sender.tag);
    }
}
- (IBAction)selVipPirciAction:(UIButton *)sender {
    if (self.selectVipPrictBlock) {
        self.selectVipPrictBlock(sender.tag);
    }
}

-(void)LoadData:(id)model with:(OrderTypes)type
{
    self.typeLabel.textColor = kNavigationColor;
    BuyerOrderModel * models = model;
    CGSize size = [NSString sizeWithString:models.store_name font:KSystemFont(15) maxHeight:60 maxWeight:KScreenBoundWidth];
    self.shopNameWidth.constant =  MIN(MAX(size.width+20, 60), KScreenBoundWidth-200);
    self.shopNameLabel.text = models.store_name;
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.shopNameLabel.font = KSystemFont(11);
        self.typeLabel.font = KSystemFont(11);
    }
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.typeLabel.font = KSystemFont(11);
    }
    switch (type)
    {
        case OrderTypesScuccess:
                        self.typeLabel.text = LaguageControl(@"已完成");
            break;
        case OrderTypesApplyRefunding:
                        self.typeLabel.text = LaguageControl(@"申请退款中");
            break;
        case OrderTypesRefundFailure:
                        self.typeLabel.text = LaguageControl(@"退款失败");
            break;
        case OrderTypesRefundSuccess:
                        self.typeLabel.text =LaguageControl( @"退款成功");
            break;
        case OrderTypesCanCel:
                        self.typeLabel.text =LaguageControl( @"已取消");
            break;
        case OrderTypesToPayment:
                        self.typeLabel.text = LaguageControl(@"待付款");
            break;
        case OrderTypesToPayUnderLine:
            self.typeLabel.text = LaguageControl(@"线下支付待审核");
            break;
        case OrderTypesToSend:
                        self.typeLabel.text = LaguageControl(@"待发货");
            break;
        case OrderTypesToSendING:
            self.typeLabel.text = LaguageControl(@"准备发货");
            break;
        case OrderTypesToAccePt:
                        self.typeLabel.text = LaguageControl(@"待收货");
            break;
        case OrderTypesToEvaluation:
                        self.typeLabel.text = LaguageControl(@"已收货");
           break;
        case OrderTypesRefundCanCel:
            self.typeLabel.text = LaguageControl(@"取消退款");
            break;
        case OrderTypesPingTuan:
            self.typeLabel.text = LaguageControl(@"拼单中");
            break;
        default:
            self.typeLabel.text = @"";
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
