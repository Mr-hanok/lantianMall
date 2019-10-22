//
//  BaseWebViewController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/9/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "LoginViewController.h"
#import "PayAttentionShopViewController.h"
#import "StationMessageChatViewController.h"
#import "MywalletViewController.h"
#import "GoodsDetialViewController.h"

@interface BaseWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webView;
/**据说所有链接都要带这个参数 包括h5内部的跳转*/
@property (nonatomic, copy) NSString *h5Token;
@property (nonatomic, copy) NSString *tempUrlStr;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) BOOL isLogining;
@property (nonatomic, strong) UIButton *backbtn;
@property (nonatomic, strong) UIButton *rightBackbtn;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self clearWebViewMemary];
    [self firtLoadWebView];
    

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(kRegisterSuccessNoti:) name:@"kRegisterSuccessNoti" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(kLookOtherOrderNoti:) name:@"kLookOtherOrderNoti" object:nil];

}
#pragma mark - 查看其它订单通知
- (void)kLookOtherOrderNoti:(NSNotification *)noti{
//    NSDictionary *userinfo= noti.userInfo;
    NSString *temrooturl =[[KAppRootUrl componentsSeparatedByString:@"/mobile"] firstObject];
    NSString *urlstr = [temrooturl stringByAppendingString:@"/phoneh5_zh/allMenu.html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]]];
    
}

#pragma mark - 注册成功后刷新页面
- (void)kRegisterSuccessNoti:(NSNotification *)noti{
    NSDictionary *userinfo= noti.userInfo;
    self.isLogining = NO;
    if (userinfo[@"value"]) {
        [self handleInvalidTokenAction];
    }
}
- (void)firtLoadWebView{
//    self.webUrl = @"http://www.baidu.com";
    /**包涵token 直接加载 否则拼接上*/
    if ([self.webUrl containsString:@"appToken="]|| [self.webUrl containsString:@"/mobile/doc_agree"]) {
        NSURL *url = [NSURL URLWithString:self.webUrl];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }else{
        //[self.h5Token isEqualToString:@""]||self.h5Token == nil
       NSString *temtoken =  [[NSUserDefaults standardUserDefaults] objectForKey: @"kDefaultH5Token"];
        if (temtoken.length && ![temtoken isEqualToString:@"temp"]) {
            self.h5Token = temtoken?:@"temp";

            self.webUrl = [self loadRequestWithToken:temtoken?:@"temp" urlString:self.webUrl];
            
        }else{
            WeakSelf(self);
            [HUDManager showLoadingHUDView:self.view];
            [NetWork getH5TokenCompletion:^(NSString *tips, NSError *error, NSString *token) {
                
                if (error) {
                    self.webView.hidden = YES;
                }else{
                    self.webView.hidden = NO;
                    weakSelf.h5Token = token?:@"temp";
                    [[NSUserDefaults standardUserDefaults] setObject:token?:@"temp" forKey:@"kDefaultH5Token"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    weakSelf.webUrl = [weakSelf loadRequestWithToken:token?:@"temp" urlString:weakSelf.webUrl];
                }
                
            }];

        }

        
    }
}
-(void)clearWebViewMemary{
    if ([[[UIDevice currentDevice]systemVersion]intValue ] >= 9.0) {
        
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
          completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             for (WKWebsiteDataRecord *record in records)
                             {
                                 //if ( [record.displayName containsString:@"baidu"]) //取消备注，可以针对某域名做专门的清除，否则是全部清除
                                 //               {
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                        }];
                                 //               }
                             }
                         }];
        
    }else{
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSLog(@"%@", cookiesFolderPath);
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}
- (void)logout
{
    [NetWork PostNetWorkWithUrl:@"/logout" with:nil successBlock:^( NSDictionary * content) {
        [HUDManager showWarningWithText:@"退出成功"];
        [[UserAccountManager shareUserAccountManager] logout];
        [self clearWebViewMemary];
        NSString *temprooturl = [[KAppRootUrl componentsSeparatedByString:@"/mobile"] firstObject];
        self.webUrl = [NSString stringWithFormat:@"%@%@",temprooturl,@"/phoneh5_zh/index.html?&appToken="];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"kDefaultH5Token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.tempUrlStr = nil;
        self.h5Token = nil;
        [self firtLoadWebView];

    } errorBlock:^(NSString *error) {
        
        [HUDManager showWarningWithText:@"退出失败"];

    }];
    
}

- (IBAction)reloadAction:(UIButton *)sender {
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.tempUrlStr?:self.webUrl]]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isHaveNavi) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"kRegisterSuccessNoti" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"kLookOtherOrderNoti" object:nil];

}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
/** 返回按钮事件 */
-(void)backToPresentViewController{
    if (!self.isHaveTabbar) {
        /**返回按钮点击*/
        if ([self.webView canGoBack]) {
            //如果有则返回
            [self.webView goBack];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
#pragma mark - WKNavigationDelegate
//// 页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//
//}
//// 当内容开始返回时调用
//- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
//}
#pragma mark - WKScriptMessageHandler
//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"getAppVersion"]) {
        NSString * jsStr = [NSString stringWithFormat:@"getAppVersionCallBack('%@')", KVersion];
        [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"%@----%@",result, error);
        }];
    }
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    NSString * jsStr = [NSString stringWithFormat:@"getAppVersionCallBack('%@')", KVersion];
//    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//
//    }];

}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if (error.code==-999) {
        return;
    }
    [HUDManager showWarningWithText:@"页面异常"];
    self.webView.hidden = YES;
}
//// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [HUDManager showWarningWithText:@"页面异常"];
    self.webView.hidden = YES;
}
//// 接收到服务器跳转请求之后再执行
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//
//}
//// 在收到响应后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//
//    decisionHandler(WKNavigationResponsePolicyAllow);
//
//}
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
//    if (!navigationAction.targetFrame.isMainFrame) {
//        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
    
    self.webView.hidden = NO;
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL absoluteString];
    if ([scheme containsString:@"https://webchat.7moor.com"]|| [scheme containsString:@"about:blank"]) {
        self.rightBackbtn.hidden = NO;
    }else{
        self.rightBackbtn.hidden = YES;
    }
    NSLog(@"%@",scheme);
    /**token过期后 请求token 拼接上*/
    if ([scheme containsString:@"//tj/token/invalid_2"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        NSString *temms = [[scheme componentsSeparatedByString:@"?msg="]lastObject];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:temms?:@"当前角色无操作权限" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }])];
        [self presentViewController:alertController animated:YES completion:nil];

        
    }else if ([scheme containsString:@"/tj/token/invalid_1"]){
        decisionHandler(WKNavigationActionPolicyCancel);
        [self handleInvalidTokenAction];
    }
    else if ([scheme containsString:@"/tj/token/invalid"] || [scheme containsString:@"loginPage.do"]|| [scheme containsString:@"Appsia_login.html"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [self loginJump];
        return;
    }else{
        if ([scheme containsString:@"/phoneh5_zh/index.html"]) {
            self.backbtn.hidden = YES;
        }else{
            self.backbtn.hidden = NO;
        }
        
        if ([self nativeJump:scheme decisionHandler:decisionHandler]) {
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
       
        if ([scheme containsString:@"&appToken="]) {
            NSString *schemeUrl = [[scheme componentsSeparatedByString:@"&appToken="] firstObject];
//            NSString *temurl = [[self.tempUrlStr componentsSeparatedByString:@"&appToken="] firstObject];
            
            if ([scheme containsString:@"&appToken=temp"]&&[self.tempUrlStr containsString:schemeUrl]&&![self.tempUrlStr containsString:@"&appToken=temp"]) {
                [self backToPresentViewController];
//                decisionHandler(WKNavigationActionPolicyCancel);
            }else{
                
            }
//            NSLog(@"%@\n%@",scheme,self.tempUrlStr);
            decisionHandler(WKNavigationActionPolicyAllow);
            self.tempUrlStr = scheme;

        }else{
            if ([scheme containsString:@"about:blank"]) {
                decisionHandler(WKNavigationActionPolicyAllow);
            }else{
                decisionHandler(WKNavigationActionPolicyCancel);
                [self loadRequestWithToken:self.h5Token urlString:scheme];
            }
        }
    }
    
}
#pragma mark - WKUIDelegate

////2.WebVeiw关闭（9.0中的新方法）
//- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
//
//}
//3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
////4.弹出一个输入框（与JS交互的）
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
//
//}
////5.显示一个确认框（JS的）
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
//
//
//}


#pragma mark - private method
- (void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenBoundWidth, [UIApplication sharedApplication].statusBarFrame.size.height)];
    topview.backgroundColor = kNavigationColor;
    [self.view addSubview:topview];
    
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    configuration.userContentController = userContentController;
    /**js调用原生 给oc传图片链接下载*/
    [configuration.userContentController addScriptMessageHandler:self name:@"getAppVersion"];

    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
//    preferences.minimumFontSize = 8.0;
    //是否支持JavaScript
    preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    configuration.preferences = preferences;
    
    CGRect webframe ;
    if (self.isHaveNavi) {
        webframe = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight);
    }else{
        webframe = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, KScreenBoundWidth, KScreenBoundHeight-[UIApplication sharedApplication].statusBarFrame.size.height);
    }
    if (self.isHaveTabbar) {
        
    }else{
        
    }
//    self.webView = [[WKWebView alloc]initWithFrame:CGRectZero];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    self.view.backgroundColor = self.webView.backgroundColor = kBGColor;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate =self;
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
           make.left.right.mas_equalTo(self.view);
           make.top.mas_equalTo(topview.mas_bottom);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.left.right.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(topview.mas_bottom);
        }
    }];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, kStatusHeight+(self.isHaveNavi?44:0), KScreenBoundWidth, 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    [self.view addSubview:self.progressView];
    
    if (!self.isHaveNavi) {
        WeakSelf(self)
        UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, 50  , 44)];
        [backbtn bk_addEventHandler:^(id  _Nonnull sender) {
            [weakSelf backToPresentViewController];
        } forControlEvents:UIControlEventTouchUpInside];
        self.backbtn = backbtn;
        [self.view addSubview:backbtn];
        
        self.rightBackbtn = [[UIButton alloc]initWithFrame:CGRectMake(KSCREEN_WIDTH-50, [UIApplication sharedApplication].statusBarFrame.size.height, 50  , 44)];
        self.rightBackbtn.hidden = YES;
        [self.rightBackbtn setImage:[UIImage imageNamed:@"baicha"] forState:UIControlStateNormal];
        [self.rightBackbtn bk_addEventHandler:^(id  _Nonnull sender) {
            [weakSelf backToPresentViewController];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.rightBackbtn];
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView) {
            [self.navigationItem setTitle:self.webView.title];
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if (object == self.webView) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            
            if(self.webView.estimatedProgress >= 1.0f) {
                
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
- (void)loginSuccessAction{
   NSString *temptoken =  [[NSUserDefaults standardUserDefaults] objectForKey:@"kDefaultH5Token"];
    self.h5Token = temptoken;
    self.tempUrlStr =  [self loadRequestWithToken:temptoken?:@"temp" urlString:self.tempUrlStr];

}

- (void)handleInvalidTokenAction{
    
    WeakSelf(self)
    [NetWork getH5TokenCompletion:^(NSString *tips, NSError *error, NSString *token) {
        
        if (error) {
            self.webView.hidden = YES;
        }else{
         
            weakSelf.h5Token = token?:@"temp";
            [[NSUserDefaults standardUserDefaults] setObject:token?:@"temp" forKey:@"kDefaultH5Token"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            weakSelf.tempUrlStr =  [weakSelf loadRequestWithToken:token?:@"temp" urlString:weakSelf.tempUrlStr];

        }
        
    }];
}
- (NSString *)loadRequestWithToken:(NSString *)token urlString:(NSString *)urlStr
{
    
    NSString *tempTokenstr = [NSString stringWithFormat:@"&appToken=%@",token];
    if (![UserAccountManager shareUserAccountManager].loginStatus  ) {
        
        tempTokenstr = [NSString stringWithFormat:@"&appToken=%@",@""];
        
    }else{
        if ([token isEqualToString:@"temp"]) {
            tempTokenstr = [NSString stringWithFormat:@"&appToken=%@",@""];
        }else{
            tempTokenstr = [NSString stringWithFormat:@"&appToken=%@",token];
        }
    }
    if ([urlStr containsString:@"?"]) {
        
        if ([urlStr containsString:@"appToken="]) {
            NSArray *temparray = [urlStr componentsSeparatedByString:@"appToken="];
            NSString *laststr = [temparray lastObject];
            NSString *ttoken = [[laststr componentsSeparatedByString:@"&"] firstObject];
            if ([ttoken isEqualToString:@""]) {
                urlStr = [urlStr stringByAppendingString:token?:@""];
                urlStr = [NSString stringWithFormat:@"%@%@%@",temparray.firstObject,token,laststr];
            }else{
                urlStr = [urlStr stringByReplacingOccurrencesOfString:ttoken withString:token];
            }
//            urlStr = [urlStr stringByReplacingOccurrencesOfString:ttoken withString:token];
            
        }else{
            urlStr = [NSString stringWithFormat:@"%@%@",urlStr,tempTokenstr];
        }
        
    }else{
        urlStr = [NSString stringWithFormat:@"%@?%@",urlStr,tempTokenstr];
    }
    if (![urlStr containsString:@"source=ios"]) {
        urlStr = [NSString stringWithFormat:@"%@&source=ios",urlStr];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    return urlStr;
    
}
- (void )loginJump{
//    if(![UserAccountManager shareUserAccountManager].loginStatus){
        if (self.isLogining) {
            return;
        }
        WeakSelf(self)
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚未登录! 请先登录" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        
        [alert showAlertWithCompletionHandler:^(NSInteger idx) {
            if (idx == 1) {
                UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                UINavigationController *nav = loginStoryBoard.instantiateInitialViewController;

                LoginViewController * view = (LoginViewController*)nav.topViewController;
                view.isPrompt = YES;
                view.isWeb = YES;
                view.successLoginBlock = ^(BOOL isscccess){
                    weakSelf.isLogining = NO;
                    if (isscccess) {
                        [weakSelf loginSuccessAction];
//                        [weakSelf handleInvalidTokenAction];
                    }
                };
                [weakSelf presentViewController:nav animated:YES completion:^{
                }];
                weakSelf.isLogining = YES;
                
            }else{
                weakSelf.isLogining = NO;
                
            }
        }];
        
//    }else{
//        [self handleInvalidTokenAction];
//    }
}

- (BOOL)nativeJump:(NSString *)scheme decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if ([scheme containsString:@"/back"]||[scheme containsString:@"phoneh5_zh/404.html"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return YES;
    }
    if ([scheme containsString:@"app://logout"]) {
        /**退出*/
        [self logout];
        return YES;
    }
//    if ([scheme containsString:@"phoneh5_zh/talkingMessage.html"]) {
//        /**客服聊天*/
//    //47.92.77.113/phoneh5_zh/talkingMessage.html?fromUserId=116&fromUserName=%E9%9C%8D%E5%BB%BA%E8%B6%85&toUserId=117&toUserName=Allen
//        NSString *tousertempstr = [[scheme componentsSeparatedByString:@"&toUserId="] lastObject];
//        NSString *touserid = [[tousertempstr componentsSeparatedByString:@"&toUserName="]firstObject];
//        NSString *tousername = [[tousertempstr componentsSeparatedByString:@"&toUserName="]lastObject];
//        StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
//        view.type = @"0";
//        view.toUserID = touserid;
//        view.title = tousername;
//        [self.navigationController pushViewController:view animated:YES];
//        return YES;
//    }else
    if ([scheme containsString:@"tel:"]) {
        /**打电话*/
        NSURL *phoneNumberURL = [NSURL URLWithString:scheme];
        [[UIApplication sharedApplication] openURL:phoneNumberURL];
        return YES;
    }

    if ([scheme containsString:@"app://openurl"]) {
        NSString *urlset = [[scheme componentsSeparatedByString:@"app://openurl?url="]lastObject];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlset]];
        return YES;
    }
  //http://www.cjltmall.com/phoneh5_zh/Appsia_cashier.html?payType=1&source=undefined&price=128&isUserRebate=0&orderId=9185
//    if ([scheme containsString:@"phoneh5_zh/Appsia_cashier.html"]) {
//        /**选择支付方式*/
//        NSString *tousertempstr = [[scheme componentsSeparatedByString:@"payType="] lastObject];
//        NSArray *temparray1 = [tousertempstr componentsSeparatedByString:@"&source=undefined&price="];
//        NSString *payType = [temparray1 firstObject];
//        NSString *tempstr =[temparray1 lastObject];
//        
//        NSString *price =
//        
//        NSString *orderid = [[tousertempstr componentsSeparatedByString:@"&orderId="] lastObject];
//        MywalletViewController * view = [[MywalletViewController alloc] init];
//        if (self.FatherVC)
//        {
//            view.FatherVC = self.FatherVC;
//        }
//        view.isOffline = NO;
//        view.orderPayMoney = moneystr;
//        view.orderNumber = orderid;
//        view.isGoods = YES;
//        self.tabBarController.tabBar.hidden =YES;
//        [self.navigationController pushViewController:view animated:YES];
//        return YES;
//    }
    
    if ([scheme containsString:@"phoneh5_zh/guestPayBill.html"]) {
        /**提交订单*/
        NSString *tousertempstr = [[scheme componentsSeparatedByString:@"&totalPrice="] lastObject];
        NSString *moneystr = [[tousertempstr componentsSeparatedByString:@"&orderId="] firstObject];
        NSString *orderid = [[tousertempstr componentsSeparatedByString:@"&orderId="] lastObject];
        MywalletViewController * view = [[MywalletViewController alloc] init];
        if (self.FatherVC)
        {
            view.FatherVC = self.FatherVC;
        }
        view.isOffline = NO;
        view.orderPayMoney = moneystr;
        view.orderNumber = orderid;
        view.isGoods = YES;
        self.tabBarController.tabBar.hidden =YES;
        [self.navigationController pushViewController:view animated:YES];
        return YES;
    }
    
    return NO;
}
@end
