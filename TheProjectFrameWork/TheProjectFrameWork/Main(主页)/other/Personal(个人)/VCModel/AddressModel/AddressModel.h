//
//  AddressModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  地址管理模型

#import <Foundation/Foundation.h>
#import "AdressAreaModel.h"

@interface AddressModel : NSObject

@property (nonatomic, copy) NSString *adressId;

@property (nonatomic, copy) NSString *deleteStatus;

@property (nonatomic , copy) NSString * name; ///< 姓名

@property (nonatomic , copy) NSString * phone; ///< 手机号

@property (nonatomic , copy) NSString * telePhone; ///< 固定电话

@property (nonatomic , copy) NSString * address; ///< 地址

@property (nonatomic , assign) BOOL defaultAddress; ///< 是否为默认地址

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *zip;

@property (nonatomic, strong) AdressAreaModel *area;

@end


/**地址详情模型*/
@interface AdressDetailModel : NSObject
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *area_info;
@property (nonatomic, copy) NSString *zip;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) NSInteger country;
@property (nonatomic, strong) AdressAreaModel *marea;
@end