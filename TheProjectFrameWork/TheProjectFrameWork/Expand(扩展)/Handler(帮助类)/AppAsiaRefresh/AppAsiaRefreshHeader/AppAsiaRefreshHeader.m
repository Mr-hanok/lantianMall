//
//  AppAsiaRefreshHeader.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/10/31.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AppAsiaRefreshHeader.h"

@implementation AppAsiaRefreshHeader
+ (AppAsiaRefreshHeader *)AppAsiaRefreshHeaderHandleBlock:(void (^)(void))block
{

    AppAsiaRefreshHeader * header = [AppAsiaRefreshHeader headerWithRefreshingBlock:^{
        if(block)
        {
            block();
        }
    }];
    
    if (kIsChiHuoApp) {

    }else{
//            header.lastUpdatedTimeLabel.hidden = YES;
//            header.stateLabel.hidden = YES;
//            //设置普通状态的动画图片
//            [header setImages:@[[UIImage imageNamed:@"animation0"]] forState:MJRefreshStateIdle];
//        
//            // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//            [header setImages:@[[UIImage imageNamed:@"animation0"]] forState:MJRefreshStatePulling];
//            // 设置正在刷新状态的动画图片
//            NSArray * arrays = @[[UIImage imageNamed:@"animation0"],
//                                 [UIImage imageNamed:@"animation1"],
//                                 [UIImage imageNamed:@"animation2"],
//                                 [UIImage imageNamed:@"animation3"],
//                                 [UIImage imageNamed:@"animation4"],
//                                 [UIImage imageNamed:@"animation5"],
//                                 [UIImage imageNamed:@"animation6"],
//                                 [UIImage imageNamed:@"animation7"],
//                                 [UIImage imageNamed:@"animation8"],
//                                 [UIImage imageNamed:@"animation9"],
//                                 [UIImage imageNamed:@"animation10"]
//                                 ];
//            [header setImages:arrays forState:MJRefreshStateRefreshing];
  
    }

    return header;
}

@end
