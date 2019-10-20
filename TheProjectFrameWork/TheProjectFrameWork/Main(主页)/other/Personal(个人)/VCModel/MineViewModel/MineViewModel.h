//
//  MineViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MineViewModel;
typedef void(^completeBlock)(MineViewModel * model, id error);

@interface MineViewModel : NSObject
@property (nonatomic , copy) NSString * username;       ///< 用户名称

@property (nonatomic , assign) double availableBalance;         ///< 可用余额

@property (nonatomic , copy) NSString * email;          ///< 电子邮箱

@property (nonatomic , copy) NSString * telephone;          ///< 手机号

@property (nonatomic , copy) NSString * trueName;           ///< 真实姓名

@property (nonatomic , assign) NSInteger  sex;            ///< 性别

@property (nonatomic , copy) NSString * birthday;      ///< 出生日期

@property (nonatomic , copy) NSString * AddressManagr;  ///< 地址管理

@property (nonatomic , copy) NSString * AccountSafe;    ///< 账户安全


+ (void)getMineInfo:(completeBlock)block;



@end

