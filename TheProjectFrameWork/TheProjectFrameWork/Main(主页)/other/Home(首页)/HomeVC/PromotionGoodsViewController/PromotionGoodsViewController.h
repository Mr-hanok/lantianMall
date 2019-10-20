//
//  PromotionGoodsViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
@class PromotionGoodsViewModel;
@interface PromotionGoodsViewController : LeftViewController
@property (nonatomic , strong) PromotionGoodsViewModel * model;
@property (nonatomic , assign) NSInteger promotionID;
@end
