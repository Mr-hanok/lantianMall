//
//  AppAsiaRefreshFooter.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/10/31.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AppAsiaRefreshFooter.h"

@implementation AppAsiaRefreshFooter

+ (AppAsiaRefreshFooter *)AppAsiaRefreshFooterHandleBlock:(void (^)(void))block
{
    AppAsiaRefreshFooter * footer = [AppAsiaRefreshFooter footerWithRefreshingBlock:^{
        if(block)
        {
            block();
        }
    }];
    [footer reloadFooterTitle];
    return footer;
}
- (void)reloadFooterTitle
{
    [self setTitle:LaguageControl(@"上拉可以加载更多") forState:MJRefreshStateIdle]; // 普通闲置状态
    [self setTitle:LaguageControl(@"松开立即刷新") forState:MJRefreshStatePulling]; // 松开就可以进行刷新的状态
    [self setTitle:LaguageControl(@"正在刷新数据中...") forState:MJRefreshStateRefreshing]; // 正在刷新中的状态
    [self setTitle:LaguageControl(@"松开立即加载更多") forState:MJRefreshStateWillRefresh]; // 即将刷新的状态
    [self setTitle:LaguageControl(@"~已经到底了哦~") forState:MJRefreshStateNoMoreData];  // 所有数据加载完毕，没有更多的数据了
}

@end
