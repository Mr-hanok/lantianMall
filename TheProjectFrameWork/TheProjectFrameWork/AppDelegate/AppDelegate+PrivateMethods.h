//
//  AppDelegate+PrivateMethods.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (PrivateMethods)
/**
 *  设置Window的根视图控制器
 */
-(void)ProjectSetRootViewController;
-(void)getMianDataFromServer;

-(void)NetWorkAdver:(void (^)(BOOL isSuccess))resultBloclk;
@end
