//
//  BaseView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefresh.h"
#import "AppAsiaRefreshFooter.h"
#import "AppAsiaRefreshHeader.h"
@interface BaseView : UIView

@property(weak,nonatomic) UIViewController * ViewController;

@property(strong,nonatomic) AppAsiaRefreshHeader * header;

@property(strong,nonatomic) AppAsiaRefreshFooter * footer;
+(id)loadView;

-(void)updataNewData:(UIScrollView*)scroller;

-(void)beginRefresh;

-(void)endRefresh;

/**
 *  刷新头部
 */
-(void)updateHeadView;
/**
 *  刷新尾部
 */
-(void)updateFootView;
@end
