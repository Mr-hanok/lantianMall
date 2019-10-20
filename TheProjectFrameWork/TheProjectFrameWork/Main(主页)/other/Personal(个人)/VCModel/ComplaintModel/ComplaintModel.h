//
//  ComplaintModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  投诉管理数据模型
 */
@interface ComplaintModel : NSObject

@property (nonatomic , assign) NSInteger complaintID;

@property (nonatomic , assign) NSInteger  status; ///< 投诉状态 (0 = 新投诉 , 1 = 待申诉 , 2 = 对话中 , 3 = 待仲裁 , 4 = 已完成)

@property (nonatomic , copy) NSString * title; ///< 投诉主题(1＝买家投诉 2＝卖家投诉)

@property (nonatomic , copy) NSString * addTime;  ///< 投诉时间

@property (nonatomic , copy) NSString * fromUserName; ///< 投诉人
@property (nonatomic , copy) NSString * toUserId;



@property (nonatomic , copy) NSString * toUserName; ///< 被投诉人
@property (nonatomic , copy) NSString * fromUserId;

@property (nonatomic , copy) NSString * describe;  ///< 问题描述


@end
