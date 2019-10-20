//
//  AdvertListModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/9/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface AdvertListModel : BaseModel
/** 广告ID */
@property(copy,nonatomic) NSString * advermodelID;
/** URl */
@property(copy,nonatomic) NSString * ad_url;
/** 时间 */
@property(copy,nonatomic) NSString * addTime;
/** 图片URL */
@property(copy,nonatomic) NSString * img_url;
/** 类型 */
@property(copy,nonatomic) NSString * ad_type;
/** 类型值 */
@property(copy,nonatomic) NSString * ad_type_value;

@property (nonatomic, copy) NSString *imgPath;

@end
