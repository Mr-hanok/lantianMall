//
//  AppAsiaRefreshHeader.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/10/31.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface AppAsiaRefreshHeader : MJRefreshNormalHeader
+ (AppAsiaRefreshHeader *)AppAsiaRefreshHeaderHandleBlock:(void(^)(void))block;
@end
