//
//  ClassGoodsViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//


#import "LeftViewController.h"

@interface ClassGoodsViewController : LeftViewController

@property(strong,nonatomic) NSString * goodID;

@property(strong,nonatomic) NSString * goodName;

@property(assign,nonatomic) BOOL isSTore;

@property(strong,nonatomic) NSString * sortSting;


@end
