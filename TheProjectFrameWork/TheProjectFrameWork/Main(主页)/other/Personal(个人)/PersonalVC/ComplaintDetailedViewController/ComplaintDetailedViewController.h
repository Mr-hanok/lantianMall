//
//  ComplaintDetailedViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  投诉管理详情

#import "LeftViewController.h"

@class ComplaintModel;
@interface ComplaintDetailedViewController : LeftViewController

@property (nonatomic , assign) NSInteger complaintId;
@property (nonatomic , assign) ComplaintModel * complaintModel;

@end
