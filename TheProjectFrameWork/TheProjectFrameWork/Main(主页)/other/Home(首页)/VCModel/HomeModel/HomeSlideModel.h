//
//  HomeSlideModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"
#import "DetialSlideModel.h"

@interface HomeSlideModel : BaseModel
@property(strong,nonatomic) NSString * slideID;
@property(strong,nonatomic) NSString * ap_status;
@property(strong,nonatomic) NSString * ap_show_type;
@property(strong,nonatomic) NSString * ap_type;

@property(strong,nonatomic) NSArray <DetialSlideModel *> * advs;
@end
