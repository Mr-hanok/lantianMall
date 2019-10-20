//
//  StationMessageChatViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface StationMessageChatViewController : LeftViewController
/**发送对象id  */
@property(strong,nonatomic) NSString * toUserID;
/** 类型 */
@property(strong,nonatomic) NSString * type;
//如果 type 买家联系卖家 type 为 0 卖家联系买家 type 为1  如果从站内信进入则不传 即 为 空。


@end
