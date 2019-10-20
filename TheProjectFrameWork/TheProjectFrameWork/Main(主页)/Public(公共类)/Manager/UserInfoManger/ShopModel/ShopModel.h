//
//  ShopModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopModel : NSObject
@property (nonatomic , copy) NSString * store_icon;
@property (nonatomic , assign) NSInteger store_id;
@property (nonatomic , copy) NSString * store_name;
@property (nonatomic , assign) double blance;
@property (nonatomic , assign) double glod;
@property (nonatomic , assign) BOOL goldRechargeSwitch;
@property (nonatomic, assign) CGFloat glodScale;
@end
