//
//  NetWork+BodyAndCookie.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NetWork.h"

@interface NetWork (BodyAndCookie)

/**
 *  设置请求头
 *
 *  @param request <#request description#>
 */
+(void)setHttpBody:(AFHTTPRequestSerializer*)request;
/**
 *  设置cookie
 */
+(void)setHttpCookie;
/**
 *  删除cookie
 */
+(void)deleteHttpCookic;
/**
 *  获取cookie
 */
+(void)getHttpCookie;

@end
