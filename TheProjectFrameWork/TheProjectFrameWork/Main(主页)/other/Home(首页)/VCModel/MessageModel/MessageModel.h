//
//  messageModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

/** 消息列表 */
@property(strong,nonatomic) NSString * messageTitle;

/** 消息id */
@property(strong,nonatomic) NSString * messageID;

/** 消息内容 */
@property(strong,nonatomic) NSString * messageContent;

/** 消息时间 */
@property(strong,nonatomic) NSString * messageTime;

@end
