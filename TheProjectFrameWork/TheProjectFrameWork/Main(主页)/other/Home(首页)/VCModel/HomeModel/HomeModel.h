//
//  HomeModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "HomeFloorModel.h"
@interface HomeModel : BaseModel
@property(strong,nonatomic) NSString * homeid;
@property(strong,nonatomic) NSString * gf_name;
@property(strong,nonatomic) NSString * section;
@property(strong,nonatomic) NSArray <HomeFloorModel*>* childs;


@end
