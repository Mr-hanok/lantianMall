//
//  LogisticsDetailsViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
#import "BuyerOrderModel.h"
/**物流详情页面*/
@interface LogisticsDetailsViewController : LeftViewController
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, strong) BuyerOrderModel *ordermodel;
@end


@interface WuLiuModel : NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *context;
@end
