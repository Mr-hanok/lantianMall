//
//  ImageModel.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property (nonatomic, copy) NSString *acc_name;
@property (nonatomic, copy) NSString *acc_path;
@property (nonatomic, copy) NSString *imageId;


@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, copy) NSString *deleteStatus;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *cover_album;
@property (nonatomic, copy) NSString *config;
@property (nonatomic, copy) NSString *goods_main_list;
@property (nonatomic, copy) NSString *goods_list;

@end
