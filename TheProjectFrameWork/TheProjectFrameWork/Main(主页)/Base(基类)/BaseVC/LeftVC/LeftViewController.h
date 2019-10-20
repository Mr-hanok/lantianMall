//
//  LeftViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseViewController.h"

@interface LeftViewController : BaseViewController
/**导航栏右侧按钮*/
- (void)loadRrightItemWithTitle:(NSString *)title;
- (void)loadRrightItemWithImage:(NSString *)title;

- (void)rightNaviButtonClick;
/**push*/
- (void)pushWithVCClass:(Class)vcClass properties:(NSDictionary*)properties;
- (void)pushWithVCClassName:(NSString*)className properties:(NSDictionary*)properties;

@end
