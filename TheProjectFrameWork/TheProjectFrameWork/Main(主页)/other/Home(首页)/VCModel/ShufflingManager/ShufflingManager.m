//
//  ShufflingManager.m
//  TheProjectFrameWork
//
//  Created by maple on 16/10/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShufflingManager.h"
#import "ShufflingInternalWebViewController.h"
#import "GoodsDetialViewController.h"
#import "AllOrdersViewController.h"
#import "PayAttentionShopViewController.h"
#import "PromotionGoodsViewController.h"

@implementation ShufflingManager
+(UIViewController*)ShufflingManagerPushType:(NSString *)Type withValue:(NSString *)Vaule
{
     UIViewController * view ;
    // 1、内部 2、外部 、0不跳转

    switch ([Type integerValue])
    {
        case 1:
            view = [BaseWebViewController new];
            [view setValue:Vaule forKey:@"webUrl"];
            break;
        case 2:
            view = [ShufflingInternalWebViewController new];
            [view setValue:Vaule forKey:@"requestURl"];
            break;
        default:
            break;
    }
    view.hidesBottomBarWhenPushed = YES;
    return view;
    
}

@end

