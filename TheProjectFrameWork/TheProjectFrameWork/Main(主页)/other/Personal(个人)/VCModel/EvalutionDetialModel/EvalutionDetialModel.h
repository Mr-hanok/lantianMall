//
//  EvalutionDetialModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EvalutionPhotoModel;
@interface EvalutionDetialModel : NSObject
//buyVal 好评 ＝ 1  中评＝ 0  －1 ＝ 差评
//imgs 图片ID
//evluateInfo 评价内容
@property (nonatomic , assign) NSInteger buyVal;
@property (nonatomic , strong) NSMutableArray <UIImage *>* images;
@property (nonatomic , copy) NSString * evluateInfo;
@property (nonatomic , copy) NSString * goodsCartId;


@end

@interface EvalutionPhotoModel : NSObject
@property (nonatomic , copy) NSString * imagePath;
@property (nonatomic , strong) UIImage * image;


@end
