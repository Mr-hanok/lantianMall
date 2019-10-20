//
//  EditAddressNewViewController.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
#import "AddressModel.h"
typedef void(^AddressModelCallBack)(AddressModel *adressModel);

@interface EditAddressNewViewController : LeftViewController
@property (nonatomic, strong) AddressModel *model;
@property (nonatomic, copy) AddressModelCallBack  block;
/** 获取地址信息 */
-(void)GetBlocksWIth:(AddressModelCallBack)block;

@end
