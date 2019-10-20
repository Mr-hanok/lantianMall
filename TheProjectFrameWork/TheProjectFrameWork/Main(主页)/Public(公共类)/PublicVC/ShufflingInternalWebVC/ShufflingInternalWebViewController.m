//
//  ShufflingInternalWebViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/10/10.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShufflingInternalWebViewController.h"
#import <WebKit/WebKit.h>

@interface ShufflingInternalWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) WKWebView *shufflingWebView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation ShufflingInternalWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [HUDManager showLoadingHUDView:self.view];
    
    if (![self.requestURl hasPrefix:@"http"]) {
        self.requestURl = [NSString stringWithFormat:@"http://%@",self.requestURl];
    }
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    configuration.userContentController = userContentController;
    
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 8.0;
    //是否支持JavaScript
    preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    configuration.preferences = preferences;
    
    self.shufflingWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    self.view.backgroundColor = self.shufflingWebView.backgroundColor = kBGColor;
    self.shufflingWebView.scrollView.showsVerticalScrollIndicator = NO;
    self.shufflingWebView.scrollView.scrollEnabled = YES;
    self.shufflingWebView.scrollView.bounces = NO;
    self.shufflingWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.shufflingWebView.navigationDelegate = self;
    self.shufflingWebView.UIDelegate = self;

    [self.view addSubview:self.shufflingWebView];
    [self.shufflingWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            
           make.left.right.bottom.mas_equalTo(self.view.safeAreaInsets);
            make.top.mas_equalTo(self.view.mas_top);
            
        } else {
            make.left.right.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(self.view.mas_top);
        }
    }];
    
    
    
    

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.requestURl]];
    [request setHTTPMethod:@"POST"];
    [self.shufflingWebView loadRequest:request];

    [self.shufflingWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.shufflingWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, KScreenBoundWidth, 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];


}
-(void)backToPresentViewController{
    if ([self.shufflingWebView canGoBack]) {
        //如果有则返回
        [self.shufflingWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [self.shufflingWebView removeObserver:self forKeyPath:@"title"];
    [self.shufflingWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.shufflingWebView) {
            [self.navigationItem setTitle:self.shufflingWebView.title];
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == self.shufflingWebView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.shufflingWebView.estimatedProgress animated:YES];
            
            if(self.shufflingWebView.estimatedProgress >= 1.0f) {
                
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
                
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark--UIWebViewDelegate
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    self.shufflingWebView.hidden = YES;
//    [HUDManager showWarningWithText:@"链接有误!网页无法打开"];
//    [self.navigationController popViewControllerAnimated:YES];
}
@end
