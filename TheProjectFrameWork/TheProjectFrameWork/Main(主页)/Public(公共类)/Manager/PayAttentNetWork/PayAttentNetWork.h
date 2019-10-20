//
//  PayAttentNetWork.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PayAttentNetWork : NSObject
/** 关注 */
+(void)PayAttentNetWorkisGoods:(BOOL)goods withtypeid:(NSString*)theTypeID Success:(void (^)(BOOL success))blcok ;

/** 取消关注 */
+(void)CancelPayAttentNetWorkisGoods:(BOOL)goods withtypeid:(NSString*)theTypeID Success:(void (^)(BOOL success))blcok ;

@end
