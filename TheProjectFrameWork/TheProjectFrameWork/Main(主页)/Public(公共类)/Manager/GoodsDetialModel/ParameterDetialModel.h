//
//  ParameterDetialModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface ParameterDetialModel : BaseModel
@property(strong,nonatomic) NSString * parameterDetialID;
@property(strong,nonatomic) NSString * parameterDetialValues;
@property (nonatomic, copy) NSString *imgUrl;
@property(assign,nonatomic) BOOL  ISSelecteD;
@property (nonatomic, assign) BOOL isCanSelected;


@end
