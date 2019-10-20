//
//  ConfirmOrderViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface ConfirmOrderViewController : LeftViewController
@property(strong,nonatomic) NSString * goodsCartID;
@property(strong,nonatomic) NSString * StoreID;
@property(strong,nonatomic) NSString * goodsID;
@property(strong,nonatomic) NSString * addressID;
@property(strong,nonatomic) NSString * count;
@property(strong,nonatomic) NSString * gsp;
@property(assign,nonatomic) BOOL isBuyNow;
@end
