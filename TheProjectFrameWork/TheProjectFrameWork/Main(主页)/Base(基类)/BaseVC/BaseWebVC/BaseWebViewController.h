//
//  BaseWebViewController.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/9/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface BaseWebViewController : LeftViewController

@property (nonatomic ,copy) NSString *webUrl;

@property (nonatomic, assign) BOOL isHaveTabbar;

@property (nonatomic, assign) BOOL isHaveNavi;
@end
