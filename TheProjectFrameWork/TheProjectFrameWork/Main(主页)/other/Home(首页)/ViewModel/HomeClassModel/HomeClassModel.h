//
//  HomeClassModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface HomeClassModel : BaseModel
@property(copy,nonatomic) NSString * goodsID;

@property(copy,nonatomic) NSString * goodsName;

@property(strong,nonatomic) NSArray * childrens;

@property (nonatomic, copy) NSString *icon_img;

@property(assign,nonatomic) BOOL  nextChilds;
@property (nonatomic, assign) float height;

- (float)configHeight;

@end
