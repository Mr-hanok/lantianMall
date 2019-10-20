//
//  OrderNumberHeadView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderNumberHeadView.h"

@implementation OrderNumberHeadView

- (void)configOrderHeadWithOrderNum:(NSString *)num orderState:(NSString *)state{
    self.typeNameLabel.textColor = kNavigationColor;
    self.orderNumLabel.text = [LaguageControlAppend(@"订单号") stringByAppendingString:num];
    switch ([state integerValue]) {
        case 0:
            self.typeNameLabel.text = LaguageControl(@"已取消");
            break;
        case 10:
            self.typeNameLabel.text = LaguageControl(@"待付款");
            break;

        case 20:
            self.typeNameLabel.text = LaguageControl(@"待发货");
            break;

        case 30:
            self.typeNameLabel.text = LaguageControl(@"已发货");
            break;

        case 40:
            self.typeNameLabel.text = LaguageControl(@"已完成");
            break;

            
    }
}

@end
