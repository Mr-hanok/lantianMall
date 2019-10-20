//
//  NewStationMessageModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/10/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewStationMessageModel : NSObject
/** 消息ID */
@property(strong,nonatomic) NSString * messageID;
/** 消息发送时间 */
@property(strong,nonatomic) NSString * messageaddtime;
/** 消息内容 */
@property(strong,nonatomic) NSString * messageContent;
/** 来自用户名 */
@property(strong,nonatomic) NSString * fromUserName;
/** 来自用户ID */
@property(strong,nonatomic) NSString * fromUserId;
/** 聊天对象名 */
@property(strong,nonatomic) NSString * toUserName;
/** 聊天对象ID */
@property(strong,nonatomic) NSString * toUserId;
/** 标题 */
@property(strong,nonatomic) NSString * title;
/** 是否读 */
@property(strong,nonatomic) NSString * type;

@end
