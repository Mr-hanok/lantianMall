//
//  IntegralBannerModel.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/9/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**积分商城轮播图模型*/
@interface IntegralBannerModel : NSObject
@property (nonatomic, copy) NSString *bannerId;
@property (nonatomic, copy) NSString *ad_url;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *ad_type;
@property (nonatomic, copy) NSString *ad_type_value;
@end
