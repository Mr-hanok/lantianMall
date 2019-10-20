//
//  AddCartNetWork.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCartNetWork : NSObject

/**
 *  加入购物车
 *
 *  @param goodsID <#goodsID description#>
 *  @param number  <#number description#>
 *  @param specifd <#specifd description#>
 *  @param block   <#block description#>
 */
+(void)AddCartNetWorkgoodid:(NSString*)goodsID number:(NSString*)number specifi:(NSString*)specifd block:(void (^)(BOOL success, NSString * number))block;
@end
