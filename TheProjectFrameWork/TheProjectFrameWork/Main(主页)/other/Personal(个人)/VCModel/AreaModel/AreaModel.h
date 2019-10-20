//
//  AreaModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2017/2/15.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CityModel;
@class TownModel;

@interface AreaModel : NSObject
@property (nonatomic , copy) NSString * areaId;
@property (nonatomic , copy) NSString * areaName;
@property (nonatomic , strong) NSArray <CityModel *> * cities;

@end

@interface CityModel : NSObject
@property (nonatomic , copy) NSString * areaId;
@property (nonatomic , copy) NSString * areaName;
@property (nonatomic , strong) NSArray <TownModel *>* counties;

@end
@interface TownModel : NSObject
@property (nonatomic , copy) NSString * areaId;
@property (nonatomic , copy) NSString * areaName;


@end
