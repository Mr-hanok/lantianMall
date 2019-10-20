//
//  PayHandle.h
//  TheProjectFrameWork
//
//  Created by maple on 2017/1/5.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    PayTypeWeChat,
    PayTypeWeZhifu,
    PayTypeWeChatOther,
} PayTypes;

@interface PayHandle : NSObject
+(void)PayWith:(PayTypes)type;
@end
