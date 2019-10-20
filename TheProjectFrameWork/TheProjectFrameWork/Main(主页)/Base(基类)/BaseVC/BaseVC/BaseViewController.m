//
//  BaseViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseViewController.h"
//#import "LBXScanViewStyle.h"
//#import "LBXScanViewStyle.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NavigationBarView.h"
#import "NavigationBatTitleView.h"
#import "SearchViewController.h"
#import "MessageCenterViewController.h"
#import "AppAsiaRefreshHeader.h"
#import "LoginViewController.h"
#import <UIButton+WebCache.h>
@interface BaseViewController ()<UISearchBarDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    [self.navigationBarView SetIamgeView];
    self.currentPage = 1;
    self.backview.backgroundColor = [UIColor clearColor];
}

//设置状态栏背景颜色
//- (void)setStatusBarBackgroundColor:(UIColor *)color {
//    
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
//    
//    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
//        statusBar.backgroundColor = color;
//    }
//}

- (void)updataHeader:(UIScrollView *)scroller
{
    scroller.mj_header = self.header;
}
- (void)updataFooter:(UIScrollView *)scrollView
{
    scrollView.mj_footer = self.footer;
    __weak typeof(self) weakSelf = self;
    [[LaguageControl shareControl] languageChangeComplete:^{
        [weakSelf.footer reloadFooterTitle];
    }];
}
-(void)updataNewData:(UIScrollView*)scroller
{
    [self updataHeader:scroller];
    [self updataFooter:scroller];
}

-(void)beginRefresh
{
    [self.header beginRefreshing];
}

-(void)updateHeadView{

}
-(void)updateFootView
{

}
-(void)endRefresh
{
    [self.header endRefreshing];
    [self.footer endRefreshing];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /**
     *  统一背景颜色
     */
    self.view.backgroundColor = [UIColor colorWithString:@"#F3F5F7"];

    UIColor * color = kIsChiHuoApp ? [UIColor colorWithRed:55/255.0 green:55/255.0 blue:55/255.0 alpha:1.f]:[UIColor whiteColor];
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
//    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor colorWithString:@"#c90c1e"] colorWithAlphaComponent:1] showShowImage:nil];
    if (kIsChiHuoApp) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.f];
//        [self setStatusBarBackgroundColor:[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.f]];
        /**去导航黑线*/
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
        self.navigationController.navigationBar.translucent = NO;
        
    }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.navigationController.navigationBar.barTintColor = kNavigationColor;
            [self.navigationBarView SetIamgeView];
    }
    [UIApplication sharedApplication].statusBarStyle=  kIsChiHuoApp ? UIStatusBarStyleDefault: UIStatusBarStyleLightContent;

    [self BaseLoadView];
    self.view.backgroundColor = [UIColor whiteColor];

    }
/**
 
 *  设置navigationBar
 
 */
- (void)loadNavBarButton{
    if (!self.navigationBarView) {
        self.navigationBarView = [NavigationBarView loadView];
    }
    self.navigationBarView.frame = CGRectMake(0, 0, kIsChiHuoApp ? 32 : 80, 32);
    self.navigationBarView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationBarView];
}
/**
 *
 */
-(void)BaseLoadView
{
}
-(void)backToPresentViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadNavigabarTitleView
{
    if (!self.navigationTitleview)
    {
        self.navigationTitleview = [NavigationBatTitleView loadView];
    }
    self.navigationItem.titleView = self.navigationTitleview;
    self.navigationTitleview.searchBar.layer.cornerRadius = 15;
    self.navigationTitleview.searchBar.layer.masksToBounds = YES;
    self.navigationTitleview.searchBar.backgroundImage = [UIImage new];
    self.navigationTitleview.searchBar.delegate = self;
}
/** 加载navigationBar点击事件 */
-(void)loadLeftnavigabarTouchEvent{
    [self.navigationBarView.leftButton setImage:[UIImage imageNamed: kIsChiHuoApp ? @"back_bt_7" : @"back_bt_7"] forState:UIControlStateNormal];
//    [self.navigationBarView.leftButton.imageView setContentMode:UIViewContentModeScaleAspectFill];

    [self.navigationBarView.leftButton addTarget:self action:@selector(backToPresentViewController) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setBackBtn {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:NSClassFromString(self.description), nil];
    navigationBar.backIndicatorImage = [UIImage imageNamed:@"back_bt_7"];
    navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back_bt_7"];
    
    if (self.tabBarController == nil) {
        self.navigationItem.backBarButtonItem = backItem;
    } else {
        
        if (self.tabBarController.navigationController == nil) {
            self.navigationItem.backBarButtonItem = backItem;
        }else{
            self.tabBarController.navigationItem.backBarButtonItem = backItem;
        }
    }
    
    
}

/** 加载navigationBar点击事件 */
-(void)loadRightnavigabarTouchEvent{
    [self.navigationTitleview.rightButton setBadgeBGColor:[UIColor blackColor]];
    [self.navigationTitleview.rightButton addTarget:self action:@selector(messageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationTitleview.rightButton setImage:[UIImage imageNamed:@"xinxi"] forState:UIControlStateNormal];
}

/**
 *  消息按钮点击
 *
 *  @param sender <#sender description#>
 */
- (void)messageButtonClicked:(UIButton *)sender
{
    MessageCenterViewController * view = [[MessageCenterViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark --UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    return NO;
}

#pragma makr -UITextFieldDelegate --关于表情的部分处理！！！

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.textInputMode.primaryLanguage == NULL ||[textField.textInputMode.primaryLanguage isEqualToString:@"emoji"])
    {
        return NO;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{

    if (textView.textInputMode.primaryLanguage == NULL ||[textView.textInputMode.primaryLanguage isEqualToString:@"emoji"]) {
        return NO;
    }
    return YES;
}
/**判断是否登陆*/
- (BOOL)loginAction{
    if (![UserAccountManager shareUserAccountManager].loginStatus) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚未登录! 请先登录" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        [alert showAlertWithCompletionHandler:^(NSInteger idx) {
            if (idx == 1) {
                UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                UINavigationController *nav = loginStoryBoard.instantiateInitialViewController;
                LoginViewController * view = (LoginViewController*)nav.topViewController;
                view.isPrompt = YES;
                [self presentViewController:nav animated:YES completion:^{
                }];
            }
        }];
        return NO;
    }
    return YES;
    
}


#pragma mark - setter && getter 
- (AppAsiaRefreshHeader *)header
{
    if(!_header)
    {
        __weak typeof(self) weakSelf = self;
        _header = [AppAsiaRefreshHeader AppAsiaRefreshHeaderHandleBlock:^{
            [weakSelf updateHeadView];
        }];
    }
    return _header;
}
- (AppAsiaRefreshFooter *)footer
{
    if(!_footer)
    {
        __weak typeof(self) weakSelf = self;
        _footer = [AppAsiaRefreshFooter AppAsiaRefreshFooterHandleBlock:^{
            [weakSelf updateFootView];
        }];
    }
    return _footer;
}

#pragma mark -- 导航栏搜索 左右按钮
-(void)setRightBtnImage:(UIImage *)btnImage Size:(CGSize)size eventHandler:(void (^)(id sender))handler {
    UIButton* btn       = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch  = YES;
    btn.frame           = CGRectMake(0, 0, size.width, size.height);
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:btnImage forState:UIControlStateNormal];
    
    [btn bk_addEventHandler:^(id sender) {
        handler(btn);
    } forControlEvents:UIControlEventTouchUpInside];
    if (self.tabBarController == nil) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        if (self.tabBarController.navigationController == nil) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }else{
            self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }
    }
}
-(void)setLeftBtnImage:(NSString *)btnImagestr eventHandler:(void (^)(id sender))handler {
    UIButton * btn       = [[UIButton alloc]init];
    btn.frame           = CGRectMake(0, 0, 30, 30);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    btn.backgroundColor = [UIColor clearColor];
    if ([btnImagestr hasPrefix:@"http"]) {
        [btn sd_setImageWithURL:[NSURL URLWithString:btnImagestr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"logo"]];
        
        [btn bk_addEventHandler:^(id sender) {
            handler(btn);
        } forControlEvents:UIControlEventTouchUpInside];
    }else{
        [btn setImage:[UIImage imageNamed:btnImagestr?:@"logo"] forState:UIControlStateNormal];
        
        [btn bk_addEventHandler:^(id sender) {
            handler(btn);
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *leftbtnitem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    if (self.tabBarController == nil) {
        self.navigationItem.leftBarButtonItem = leftbtnitem;
    } else {
        
        if (self.tabBarController.navigationController == nil) {
            self.navigationItem.leftBarButtonItem = leftbtnitem;
        }else{
            self.tabBarController.navigationItem.leftBarButtonItem = leftbtnitem;
        }
    }
}
- (void)setCenterSearchViewWithDelegete:(id)delegate{
    UITextField *text = [[UITextField alloc]init];
    text.frame = CGRectMake(0, 0, KScreenBoundWidth-60, 30);
    text.placeholder = @"请输入搜索内容";
    text.textColor = [UIColor whiteColor];
    UIImageView *view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed:@"fangdajing"];
    view.frame = CGRectMake(0, 0, 35, 35);
    view.contentMode = UIViewContentModeCenter;
//    text.backgroundColor = [UIColor whiteColor];
    text.leftView = view;
    text.leftViewMode = UITextFieldViewModeAlways;
    text.layer.cornerRadius = 15.f;
    text.layer.masksToBounds = YES;
    text.delegate = delegate;
    text.font = [UIFont systemFontOfSize:13];
    text.returnKeyType = UIReturnKeySearch;
    [text setBackground:[UIImage imageNamed:@"searchbgview"]];
    
    self.navigationItem.titleView = text;
    
}
@end
