//
//  NetWorkType.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NetWorkType.h"

#import "Reachability.h"

@implementation NetWorkType
/**
 *  网络状态判断
 *
 *  @return <#return value description#>
 */
+(NetWorkTypes)CheckNetWorkType
{
    // 1.检测wifi状态
    Reachability * wifi         = [Reachability reachabilityForLocalWiFi];
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability * conn          = [Reachability reachabilityForInternetConnection];
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        // 有wifi
        return NetWorkTypesWifi;
    }
    else if ([conn currentReachabilityStatus] != NotReachable) {
        // 没有使用wifi, 使用手机自带网络
        return  NetWorkTypesPhone ;
    }
    else { // 没有网络
        return  NetWorkTypesNoNe;
    }
}



@end
