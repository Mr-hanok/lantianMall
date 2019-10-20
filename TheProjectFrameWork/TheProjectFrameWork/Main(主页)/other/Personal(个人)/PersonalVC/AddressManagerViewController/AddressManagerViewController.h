//
//  AddressManagerViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
@class AddressModel;
typedef void(^AddressSelectBlock)(AddressModel *adressModel);
#import "LeftViewController.h"

@interface AddressManagerViewController : LeftViewController
@property (nonatomic, copy) AddressSelectBlock  block;
@property (nonatomic, assign) BOOL isSelect;//是否要选择地址返回 从订单也进来
@end
