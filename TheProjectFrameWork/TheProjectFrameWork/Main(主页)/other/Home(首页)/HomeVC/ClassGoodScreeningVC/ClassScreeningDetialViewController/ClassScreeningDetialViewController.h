//
//  ClassScreeningDetialViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

typedef void(^SelectedResult)(NSArray * resultArray ,NSString * result);

@interface ClassScreeningDetialViewController : LeftViewController

@property(strong,nonatomic) NSString * titles;

@property(strong,nonatomic) NSArray * dataArray;

@property(copy,nonatomic) SelectedResult blcok;
/**
 *  获取选择信息
 *
 *  @param block <#block description#>
 */
-(void)GetSelected:(SelectedResult)block;

@end
