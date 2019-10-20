//
//  ClassGoodScreeningViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^ScreenSelectedResult)(NSString * screenString ,NSString * screeenOther);

@interface ClassGoodScreeningViewController : BaseViewController
/** 是否是排序 */

@property(strong,nonatomic) NSString * titleName;

@property(strong,nonatomic) NSString * modelsID;

@property(copy,nonatomic) ScreenSelectedResult block;
/**
 *  <#Description#>
 *
 *  @param block <#block description#>
 */
-(void)GetSelected:(ScreenSelectedResult)block;

@end
