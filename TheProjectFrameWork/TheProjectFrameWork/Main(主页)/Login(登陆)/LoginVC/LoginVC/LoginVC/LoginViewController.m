//
//  LoginViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTextField.h"
#import "LoginButton.h"
#import "OtherLoginView.h"
#import "AppAsiaShare.h"
#import "FacebookUserModel.h"
#import "NSDate+Conversion.h"
@interface LoginViewController ()<UITextFieldDelegate,LoginTextFieldDelegate,OtherLoginViewDelegate>
{
    LoginButton * _loginButton;
    LoginButton * _visitorsBuy;
    NSString * _userNumber;
    NSString * _passWord;
    BOOL _isVerify;
}
@end

@implementation LoginViewController
{
    LoginTextField * verificationCode;
}

-(void)getisToturBuy:(VisitorsBuyBlock)block
{
    self.buyBlcok = block;
}
#pragma life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLoginView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNav];
    self.title = [LaguageControl languageWithString:@"登录"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = kNavigationColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
#pragma mark --AddPrivateMethods 添加的私有方法
- (void)judegLoginButtonStage
{
    BOOL stage = (_userNumber.length >= 1 && _passWord.length >=6);
    [_loginButton settingButtonSelectWithSelected:stage];
}
/**
 *  设置导航栏相关属性
 */
- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
   
    if(_isPrompt)
    {
        _visitorsBuy.hidden = NO;
        self.navigationController.navigationBar.barTintColor = kNavigationColor;
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    }else
    {
        _visitorsBuy.hidden = YES;
        self.navigationController.navigationBar.barTintColor = kNavigationColor;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
}

- (void)BaseLoadView
{
    
}
/**
 *  加载登陆页面视图
 */
-(void)loadLoginView{
    
    self.navigationController.navigationBar.translucent = NO;
    // 用户名输入
    LoginTextField * userNumTextField = [[LoginTextField alloc] initWithText:nil placeholder:[LaguageControl languageWithString:@"输入您的手机号/帐户"] isSecureTextEntry:NO isAuthCode:NO];
    // 密码输入
    LoginTextField * passwordTextField = [[LoginTextField alloc] initWithText:nil placeholder:[LaguageControl languageWithString:@"请输入密码"] isSecureTextEntry:YES isAuthCode:NO];
    // 验证码输入
    verificationCode = [[LoginTextField alloc] initWithText:nil placeholder:[LaguageControl languageWithString:@"请输入验证码"] isSecureTextEntry:NO isAuthCode:YES];
    
    verificationCode.textField.autocorrectionType = UITextAutocorrectionTypeNo;

    userNumTextField.delegate = self;
    passwordTextField.delegate = self;
    verificationCode.delegate = self;
    
    // 登录按钮
    __weak typeof(self) weakSelf = self;
    _loginButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf loginEvent];
    } title:@"登录"];
    
    // 找回密码
    UIButton * retrievePwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [retrievePwdBtn setTitle:[LaguageControl languageWithString:@"找回密码"] forState:UIControlStateNormal];
    [retrievePwdBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    retrievePwdBtn.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
    [retrievePwdBtn addTarget:self action:@selector(retrievePwd) forControlEvents:UIControlEventTouchUpInside];
    // 快速注册
    UIButton *registerQuickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerQuickBtn setTitle:[LaguageControl languageWithString:@"快速注册"] forState:UIControlStateNormal];
    [registerQuickBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    registerQuickBtn.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
    [registerQuickBtn addTarget:self action:@selector(registerQuick) forControlEvents:UIControlEventTouchUpInside];
//    _visitorsBuy = [[LoginButton alloc] initWithActionBlock:^(id sender) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf visitorsBuy];
//    } title:@"游客购买"];
    [_visitorsBuy settingButtonSelectWithSelected:YES];
    _visitorsBuy.backgroundColor = [UIColor colorWithString:@"#F22F33"];
    //  其他登录方式
    OtherLoginView * otherLoginView = [[OtherLoginView alloc] init];
    otherLoginView.delegate = self;
    [self.view addSubview:userNumTextField];
    [self.view addSubview:passwordTextField];
    [self.view addSubview:verificationCode];
    [self.view addSubview:_loginButton];
    [self.view addSubview:retrievePwdBtn];
    [self.view addSubview:registerQuickBtn];
    [self.view addSubview:_visitorsBuy];
    [self.view addSubview:otherLoginView];
    [userNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kScaleHeight(50));
        make.height.mas_equalTo(kScaleHeight(46));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(20));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(20));
    }];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(userNumTextField.mas_height);
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(20));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(20));
        make.top.equalTo(userNumTextField.mas_bottom).mas_offset(kScaleHeight(8));
    }];
    [verificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(userNumTextField.mas_height);
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(20));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(20));
        make.top.equalTo(passwordTextField.mas_bottom).mas_offset(kScaleHeight(8));
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationCode.mas_bottom).mas_offset(kScaleHeight(20));
        make.height.mas_equalTo(kScaleHeight(40));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(20));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(20));
    }];
    [retrievePwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginButton.mas_left);
        make.top.equalTo(_loginButton.mas_bottom).mas_offset(kScaleHeight(20));
        make.height.equalTo(registerQuickBtn.mas_height);
    }];
    [registerQuickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_loginButton.mas_right);
        make.top.equalTo(retrievePwdBtn.mas_top);
        make.height.mas_lessThanOrEqualTo(kScaleHeight(30));
    }];
    [_visitorsBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(20));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(20));
        make.top.equalTo(retrievePwdBtn.mas_bottom).mas_offset(kScaleHeight(15));
        make.height.mas_equalTo(kScaleHeight(40));
        make.bottom.greaterThanOrEqualTo(otherLoginView.mas_top).mas_offset(-kScaleHeight(20));
    }];
    [otherLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(20));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(20));
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
    _visitorsBuy.hidden = !_isPrompt;
    // 暂时隐藏Facebook登录
    otherLoginView.hidden = YES;
}



/**
 *  返回
 *
 *  @param sender <#sender description#>
 */
- (IBAction)backToPresentViewController:(UIBarButtonItem *)sender {
    if (self.isWeb) {
        self.successLoginBlock(NO);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/**
 *  找回密码
 *
 *  @return <#return value description#>
 */
- (void)retrievePwd
{
    [self performSegueWithIdentifier:@"retrievePwd" sender:nil];
}

/**
 *  快速注册
 *
 *  @return <#return value description#>
 */
- (void)registerQuick
{
    
  //http://www.cjltmall.com/phoneh5_zh/signInWithEmail882.html?loginBack=2
    
    NSString *temprooturl = [[KAppRootUrl componentsSeparatedByString:@"/mobile"] firstObject];

//    BaseWebViewController * vc = [[BaseWebViewController alloc] init];
//    vc.webUrl = [NSString stringWithFormat:@"%@%@",temprooturl,@"/phoneh5_zh/signInWithEmail882.html?loginBack=2"];
//    [self.navigationController pushViewController:vc animated:YES];

    Class vc = NSClassFromString(@"DetailedRegisterViewController");
    [self.navigationController pushViewController:[vc new] animated:YES];
}
/**
 *  登录
 *
 *  @return <#return value description#>
 */
- (void)loginEvent
{
    if(!_isVerify)
    {
        [HUDManager showWarningWithText:@"验证码错误"];
        return;
    }
    [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
    UserAccountManager * manage = [UserAccountManager shareUserAccountManager];
    WeakSelf(self)
    [NetWork PostNetWorkWithUrl:@"/user_login" with:@{@"loginName":_userNumber,@"password":_passWord,@"pushUserID":manage.pushUserID?manage.pushUserID:@"",@"cart_session_id":manage.cartUserID?manage.cartUserID:@""} successBlock:^(NSDictionary *dic) {
        [HUDManager hideHUDView];
        [[NSUserDefaults standardUserDefaults] setObject:dic[@"token"]?:@"temp" forKey:@"kDefaultH5Token"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        [[UserAccountManager shareUserAccountManager] loginWithUserDic:dic[@"data"]];
        if (weakSelf.isWeb) {
            weakSelf.successLoginBlock(YES);
        }
        [weakSelf backToPresentViewController];
    } FailureBlock:^(NSString *msg) {
        [verificationCode refreshVerificationCode];
        [HUDManager hideHUDView];
        if (weakSelf.isWeb) {
            weakSelf.successLoginBlock(NO);
        }
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [verificationCode refreshVerificationCode];
        [HUDManager hideHUDView];
        if (weakSelf.isWeb) {
            weakSelf.successLoginBlock(NO);
        }
        [HUDManager showWarningWithError:error];
    }];
}
/**
 *  游客购买
 */
- (void)visitorsBuy
{
    if (self.buyBlcok) {
        __weak LoginViewController * weakself = self;
        [UserAccountManager shareUserAccountManager].isLogin = @"youzhile";
        weakself.buyBlcok(YES);
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }
}
/**
 *  返回事件
 */
-(void)backToPresentViewController{
    [HUDManager hideHUDView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  游客登录判断
 */
- (void)netWorkVisitorsBuy
{
    
}
#pragma mark - LoginTextFieldDelegate
- (void)currentUserNumber:(NSString *)userNumber
{
    _userNumber = userNumber;
    [self judegLoginButtonStage];
}
- (void)currentPassWord:(NSString *)password
{
    _passWord = password;
    [self judegLoginButtonStage];

}
- (void)verificationCode:(BOOL)isTure
{
    _isVerify = isTure;
    [self judegLoginButtonStage];
}
#pragma mark - OtherLoginViewDelegate
/**
 *  facebook登录
 *
 *  @param title <#title description#>
 */
- (void)otherLoginWithTitle:(NSString *)title
{
    [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
    [AppAsiaShare loginFacebookWithCompleteBlock:^(FacebookUserModel *facebookUser, NSError *err) {
        [HUDManager hideHUDView];
        if(facebookUser)
        {
            [self loginToFacebookWithModel:facebookUser error:^(NSString *error) {
                [HUDManager showWarningWithText:error];
            }];
        }
    }];
}

- (void)loginToFacebookWithModel:(FacebookUserModel *)facebook error:(void (^)(NSString *error))block
{
    if(facebook.email.length == 0)
    {
        if(block)
        {
            block(@"登录错误");
        }
        return;
    }
    [NetWork PostNetWorkWithUrl:@"/faceBack_saveUser" with:@{@"username":facebook.FacebookID,@"email":facebook.email,@"birthday":[NSDate conversionFacebookDate:facebook.birthday]}
        successBlock:^(NSDictionary *dic) {
            UserModel * user = [UserModel mj_objectWithKeyValues:dic[@"data"]];
            [[UserAccountManager shareUserAccountManager] facebookLoginWithUserModel:user facebookModel:facebook];
            [self backToPresentViewController];
        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithText:msg];
            [self backToPresentViewController];
        } errorBlock:^(id error) {
            [self backToPresentViewController];
        }];
}
@end
