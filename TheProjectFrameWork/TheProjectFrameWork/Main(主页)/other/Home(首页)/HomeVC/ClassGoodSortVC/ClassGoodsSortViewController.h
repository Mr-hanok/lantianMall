//
//  ClassGoodsSortViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SelectedResult)(NSString * result);

@interface ClassGoodsSortViewController : BaseViewController

@property(strong,nonatomic) NSString * titles;

@property(copy,nonatomic) SelectedResult blcok;
/**
 *  获取选择信息
 *
 *  @param block <#block description#>
 */
-(void)GetSelected:(SelectedResult)block;


@end
