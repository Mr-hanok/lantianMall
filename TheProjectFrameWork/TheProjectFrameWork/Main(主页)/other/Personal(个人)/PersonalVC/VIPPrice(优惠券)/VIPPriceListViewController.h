//
//  VIPPriceListViewController.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/23.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//
typedef enum : NSUInteger {
    VipPriceTypeAll=1,
    VipPriceTypeUnuse=2,
    VipPriceTypeUse=3,
    VipPriceTypeOutTime=4,
} VipPriceType;
#import "LeftViewController.h"

@interface VIPPriceListViewController : LeftViewController

@property (nonatomic, assign) VipPriceType type;
@end



