//
//  ChooseComplaintGoodsViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
@class BuyerOrderModel;
@interface ChooseComplaintGoodsViewController : LeftViewController
@property(strong,nonatomic) BuyerOrderModel * orderModel;
@property (nonatomic , assign) BOOL buyer;
@end
