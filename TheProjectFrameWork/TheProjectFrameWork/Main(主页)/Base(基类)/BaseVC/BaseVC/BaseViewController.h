//
//  BaseViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppAsiaRefreshHeader.h"
#import "AppAsiaRefreshFooter.h"
#import "ShoppingNotView.h"
#import "UIControl+BlocksKit.h"
@class NavigationBatTitleView;
@class NavigationBarView;
@interface BaseViewController : UIViewController

@property(strong,nonatomic) UIViewController * FatherVC;

@property(strong,nonatomic) NavigationBatTitleView * navigationTitleview ;

@property(strong,nonatomic) NavigationBarView * navigationBarView ;

@property(strong,nonatomic) AppAsiaRefreshHeader * header;

@property(strong,nonatomic) AppAsiaRefreshFooter * footer;

@property (nonatomic, assign)NSInteger currentPage ;

@property (nonatomic, assign)BOOL EndRefresh;

@property(strong,nonatomic) ShoppingNotView * backview;




/**
 *  视图即将加载时候调用
 */
-(void)BaseLoadView;

/** 返回按钮事件 */
-(void)backToPresentViewController;

/** 设置titleView */
-(void)loadNavigabarTitleView;

/** 设置navugationbar */
- (void)loadNavBarButton;

/** 加载navigationBar点击事件 */
-(void)loadLeftnavigabarTouchEvent;

/** 加载navigationBar点击事件 */
-(void)loadRightnavigabarTouchEvent;

-(void)updataNewData:(UIScrollView*)scroller;
/**
 *  加载头部刷新
 *
 *  @param scroller <#scroller description#>
 */
- (void)updataHeader:(UIScrollView *)scroller;
- (void)updataFooter:(UIScrollView *)scrollView;


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


- (BOOL)loginAction;


- (void)setCenterSearchViewWithDelegete:(id)delegate;
-(void)setLeftBtnImage:(NSString *)btnImagestr eventHandler:(void (^)(id sender))handler;
-(void)setRightBtnImage:(UIImage *)btnImage Size:(CGSize)size eventHandler:(void (^)(id sender))handler;
@end
