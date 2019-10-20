//
//  PayOnLineViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PayOnLineViewController.h"
#import "PaySuccessViewController.h"

@interface PayOnLineViewController ()<UIWebViewDelegate,NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *onlinePayWebView;

/** 请求 */
@property(strong,nonatomic) NSURLRequest * urlrequset;

@property(assign,nonatomic) BOOL isAuthed;

@end

@implementation PayOnLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.onlinePayWebView.delegate = self;
    self.onlinePayWebView.scrollView.bounces = NO;
    self.onlinePayWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.onlinePayWebView.scrollView.scrollEnabled = YES;
    [self.onlinePayWebView sizeToFit];
    NSLog(@"WebView--------------%@------------------------",self.payurls);
    //预留参数的网址 NSString *baseUrlString = @"http://lolbox.duowan.com/phone/apiCheckUser.php?action=getPlayersInfo&serverName=%@&target=%@";
//    NSString *paramServer = @"电信十四"; NSString *paramName = @"蛋壳儿";
//    合成新的网址 NSString *urlString = [NSString stringWithFormat:baseUrlString,paramServer,paramName];
//    将网址转化为UTF8编码
    NSString * urlStringUTF8 = [self.payurls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL * url = [NSURL URLWithString:urlStringUTF8];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    [self.onlinePayWebView loadRequest:request];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(becomeActive)
//                                                 name:UIApplicationDidBecomeActiveNotification
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(resignActive)
//                                                 name:UIApplicationWillResignActiveNotification
//                                               object:nil];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.payurls]];


//    [self.onlinePayWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.payurls]]];


//    [self NetWork:@""];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
/*
 * 返回APP
 */
- (void)becomeActive
{
    
}
/**
 *  跳出APP 支付
 */
-(void)resignActive
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CheckPayINfo
{
    if (self.payOrderID)
    {
        NSDictionary * dic = @{@"orderPayId":self.payOrderID};
        
        [NetWork PostNetWorkWithUrl:@"/getPatStatus" with:dic successBlock:^(NSDictionary *dic)
         {
             if ([dic[@"status"] integerValue] == 1)
             {
                 self.orderMoney = [NSString stringWithFormat:@"%@",dic[@"data"]];
                 [self PopPaySuccessViewController];
             }
             else
             {
                 [HUDManager showWarningWithText:@"支付失败"];
             }
         } errorBlock:^(NSString *error)
         {
             [HUDManager showWarningWithText:@"支付失败"];
             
         }];
    }
    else
    {
        [HUDManager showWarningWithText:@"支付失败"];
    }

}
/**
 *  跳转支付成功页面
 */
-(void)PopPaySuccessViewController
{
    
    PaySuccessViewController * view = [[PaySuccessViewController alloc] init];
    view.payType  = self.onLinePayType;
    view.moneyStr = self.orderMoney;
    view.FatherVC = self.FatherVC;
    [self.navigationController pushViewController:view animated:YES];
}


#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)awebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString* scheme = [[request URL] scheme];
    
    if ([scheme isEqualToString:@"https"])
    {
        //如果是https:的话，那么就用NSURLConnection来重发请求。从而在请求的过程当中吧要请求的URL做信任处理。
        if (!self.isAuthed) {
            self.urlrequset = request;
            NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [conn start];
            [awebView stopLoading];
            return NO;
        }
        
    }
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//     NSString * urls   = webView.request.URL.absoluteString;
//    NSLog(@"title---url-%@--",urls);
//    NSString *lJs = @"document.documentElement.innerHTML";//获取当前网页的html
//    
//    NSString * string = [webView stringByEvaluatingJavaScriptFromString:lJs];
//    NSLog(@"Html---url-%@--",string);

    
}
#pragma mark ================= NSURLConnectionDataDelegate <NSURLConnectionDelegate>

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    
    return YES;
}
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
    if ([challenge previousFailureCount]== 0)
    {
        
        //NSURLCredential 这个类是表示身份验证凭据不可变对象。凭证的实际类型声明的类的构造函数来确定。
        NSURLCredential* cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:cre forAuthenticationChallenge:challenge];
    }
    else
    {
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
    
}


- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    
    return request;
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.isAuthed = YES;
    //webview 重新加载请求。
    [self.onlinePayWebView loadRequest:self.urlrequset];
   
    [connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}



@end
