//
//  DistributionTypeSelectVCViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
typedef void(^GetType)(NSDictionary * dictionary ,BOOL Fast);

@interface DistributionTypeSelectVCViewController : LeftViewController
@property(strong,nonatomic) NSString * selectedType;
@property(strong,nonatomic) NSArray * array;
@property(copy,nonatomic) GetType block;
-(void)GetSendType:(GetType)block;
@end
