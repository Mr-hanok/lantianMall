//
//  FanLiViewController.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/12.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface FanLiViewController : LeftViewController

@end

@interface FanLiModel :NSObject
@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *mark;
@end
