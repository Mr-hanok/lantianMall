//
//  HomeActivityModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeActivityModel : NSObject

@property (nonatomic , copy) NSString * activityID;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * imgPath;
@property (nonatomic, assign) NSInteger activityType;
@property (nonatomic, copy) NSString *nav_url;
@end
