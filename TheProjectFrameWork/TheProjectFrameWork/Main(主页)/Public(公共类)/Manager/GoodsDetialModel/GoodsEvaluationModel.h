//
//  GoodsEvaluationModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsEvaluationModel : BaseModel
/** 评论ID */
@property(strong,nonatomic) NSString * evaluationID;
/** 评论时间 */
@property(strong,nonatomic) NSString * addTime;
/** 买家信用等级 */
@property(strong,nonatomic) NSString * evaluateBuyerVal;
/** 买家评论信息 */
@property(strong,nonatomic) NSString * evaluateInfo;
/** 商品头像 */
@property(strong,nonatomic) NSString * goodsAcc;
/** 商品iD */
@property(strong,nonatomic) NSString * goodsId;
/** 商品名称 */
@property(strong,nonatomic) NSString * goodsName;
/** 购买时间 */
@property(strong,nonatomic) NSString * goods_by_date;
/** 规格 */
@property(strong,nonatomic) NSString * goods_spec;
/** 图片 */
@property(strong,nonatomic) NSString * imag1;

@property(strong,nonatomic) NSString * imag2;

@property(strong,nonatomic) NSString * imag3;

/** 买家头像 */
@property(strong,nonatomic) NSString * userAcc;
/** 买家信用等级 */
@property(strong,nonatomic) NSString * userCredit;
/** 用户名 */
@property(strong,nonatomic) NSString * userName;

@end
