//
//  MineShopAccountModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MineShopAccountModel;
typedef void(^completeBlock) (MineShopAccountModel * model,id error);
@interface MineShopAccountModel : NSObject
@property (nonatomic , copy) NSString * userName; ///< 账户号

@property (nonatomic , copy) NSString * store_name;
@property (nonatomic , copy) NSString * store_email;
@property (nonatomic , copy) NSString * store_telephone;
@property (nonatomic , copy) NSString * store_ower; ///< 负责人
@property (nonatomic , assign) NSInteger store_owner_sex;
@property (nonatomic , copy) NSString * storeClass;

@property (nonatomic , copy) NSString * gradeName;
@property (nonatomic , assign) BOOL managed_self;
@property (nonatomic , assign) BOOL isPay;

@property (nonatomic , assign) CGFloat description_evaluate_halfyear; ///< 描述相符
@property (nonatomic , assign) CGFloat service_evaluate_halfyear;///< 服务态度
@property (nonatomic , assign) CGFloat ship_evaluate_halfyear; ///< 发货速度
@property (nonatomic , copy) NSString * store_credit; ///< 信用等级
@property (nonatomic , assign) NSInteger store_type; ///<  店铺类型
@property (nonatomic , copy) NSString *storeType; ///<  店铺类型
+ (void)getMineShopAccountInfoWithStoreID:(NSInteger)store_id complete:(completeBlock)complete;

@end
