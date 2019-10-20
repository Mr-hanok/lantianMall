//
//  GoodsParameterModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

#import "ParameterDetialModel.h"

@interface GoodsParameterModel : BaseModel
@property(strong,nonatomic) NSString * parameterID;
@property(strong,nonatomic) NSString * parameterName;
@property(strong,nonatomic) NSArray * parameterDataArray;
@property(strong,nonatomic) NSArray <ParameterDetialModel *> * gcpList;
@property (nonatomic, copy) NSString *type;
@end



/**sku规格信息*/


@interface SkuModel : NSObject

@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *sku_id;
@property (nonatomic, copy) NSString *sku_name;
@property (nonatomic, copy) NSString *specpids;
@property (nonatomic, copy) NSString *stocks;
@property (nonatomic, copy) NSString *addTime;
@end
