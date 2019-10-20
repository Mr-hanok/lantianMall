//
//  HomeFloorModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "HomeGoodsDetial.h"
@interface HomeFloorModel : BaseModel
@property(strong,nonatomic) NSString * floorid;
@property(strong,nonatomic) NSString * gf_name;
@property(strong,nonatomic) NSString * section;
@property(strong,nonatomic) NSArray <HomeGoodsDetial *> * gf_list_goods;

@end
