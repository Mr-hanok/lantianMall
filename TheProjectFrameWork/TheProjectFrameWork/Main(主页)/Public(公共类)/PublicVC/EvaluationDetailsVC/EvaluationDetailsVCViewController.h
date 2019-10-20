//
//  EvaluationDetailsVCViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
#import "GoodsEvaluationModel.h"

@interface EvaluationDetailsVCViewController : LeftViewController
/** 评论id */
@property(strong,nonatomic) NSString * evaluationID;
@property(strong,nonatomic) GoodsEvaluationModel * models;

@end
