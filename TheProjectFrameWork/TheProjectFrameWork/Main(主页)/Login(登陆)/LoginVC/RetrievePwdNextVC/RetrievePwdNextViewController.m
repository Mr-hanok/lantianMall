//
//  RetrievePwdNextViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RetrievePwdNextViewController.h"
#import "RegisterTextField.h"
#import "LoginButton.h"
#import "CountDownButton.h"
#import "NSString+HidePhone.h"
@interface RetrievePwdNextViewController ()<RegisterTextFielDelegate,CountDownButtonDelegate>
{
    UILabel * _promptLabel;
    UILabel * _userLabel;
    RegisterTextField * _captchaTF;
    LoginButton * _nextBtn;
    CountDownButton * _countDownButton;
    UIButton * _contactService;
}
@end
@implementation RetrievePwdNextViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadLoginView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_countDownButton invalidateTimer]; // 停止定时器
}
- (void)loadLoginView
{
    _promptLabel = [[UILabel alloc] init];
    _promptLabel.textColor = [UIColor colorWithString:@"#f22f33"];
    _userLabel = [[UILabel alloc] init];
    _userLabel.textColor = [UIColor colorWithString:@"#616161"];
    _captchaTF = [[RegisterTextField alloc] initWithPlaceholder:@"请输入验证码" isVerify:NO];
    _captchaTF.delegate = self;
    __weak typeof(self) weakSelf = self;
    _nextBtn = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf nextRetrievePwd];
    } title:@"下一步"];
    _countDownButton = [[CountDownButton alloc] initWithInterval:60 Target:self Sel:@selector(getVerificationCode)];
    _countDownButton.delegate = self;
    _promptLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    _userLabel.font = _promptLabel.font;
    _contactService = [UIButton buttonWithType:UIButtonTypeCustom];
    _contactService.titleLabel.numberOfLines = 0;
    [_contactService setTitle:[LaguageControl languageWithString:@"遇到问题？请联系客服"]  forState:UIControlStateNormal];
    [_contactService setTitleColor:[UIColor colorWithString:@"#f22f33"] forState:UIControlStateNormal];
    _contactService.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    _contactService.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:_promptLabel];
    [self.view addSubview:_userLabel];
    [self.view addSubview:_captchaTF];
    [self.view addSubview:_nextBtn];
    [self.view addSubview:_countDownButton];
    [self.view addSubview:_contactService];
    _promptLabel.text = [NSString stringWithFormat:@"%@%@",LaguageControl(@"验证码已发送到"),_type==1?_user.email:[NSString hidePhone:_user.mobile]];
    _promptLabel.numberOfLines = 0;
    _userLabel.text = [NSString stringWithFormat:@"%@ : %@",LaguageControl(@"账户"),_user.username];
    [_countDownButton startTimer];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;
    void (^layoutBlock)(MASConstraintMaker * make) = ^(MASConstraintMaker * make){
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
    };
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kScaleHeight(13));
    }];
    [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_promptLabel.mas_bottom).mas_offset(kScaleHeight(43));
    }];
    [_captchaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.top.equalTo(_userLabel.mas_bottom).mas_offset(kScaleHeight(20));
        make.height.mas_equalTo(kScaleHeight(40));
        make.right.equalTo(_countDownButton.mas_left).mas_offset(-kScaleWidth(15)).priority(750);
    }];
    [_countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.top.equalTo(_userLabel.mas_bottom).mas_offset(kScaleHeight(20));
        make.height.mas_equalTo(kScaleHeight(40));
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(0.36f).priority(500);
    }];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.top.equalTo(_captchaTF.mas_bottom).mas_offset(kScaleHeight(45));
        make.height.mas_equalTo(kScaleHeight(40));

    }];
    [_contactService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nextBtn.mas_bottom).mas_offset(kScaleHeight(5));
        make.left.equalTo(_nextBtn.mas_left);
        make.right.lessThanOrEqualTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
    }];
}
/**
 *  倒计时停止
 *
 *  @return <#return value description#>
 */
- (void)countDownStop
{
    _code = nil;
}
/**
 *  点击获取验证码
 */
- (void)getVerificationCode
{
    if(_type == 1)
    {
        [NetWork PostNetWorkWithUrl:@"/sendEmail" with:@{@"email":_user.email,@"type":@"email_edit_loginpwd_notify"} successBlock:^(NSDictionary *dic) {
            [_countDownButton startTimer];
        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithError:msg];
        } errorBlock:^(id error) {
            [HUDManager showWarningWithError:error];
        }];
    }else
    {
        [NetWork PostNetWorkWithUrl:@"/send_mobile_message" with:@{@"mobile":[[UserAccountManager shareUserAccountManager].userModel.mobile stringByReplacingOccurrencesOfString:@"+" withString:@""],@"type":@"sms_edit_loginpwd__notify"} successBlock:^(NSDictionary *dic) {
            [_countDownButton startTimer];
        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithError:msg];
        } errorBlock:^(id error) {
            [HUDManager showWarningWithError:error];
        }];
        
        
        
//        [NetWork PostNetWorkWithUrl:@"/getMsgCode" with:@{@"phone":[[UserAccountManager shareUserAccountManager].userModel.mobile stringByReplacingOccurrencesOfString:@"+" withString:@""]} successBlock:^(NSDictionary *dic) {
//            [HUDManager hideHUDView];
//            [_countDownButton startTimer];
//        } FailureBlock:^(NSString *msg) {
//            [HUDManager hideHUDView];
//            [HUDManager showWarningWithError:msg];
//        } errorBlock:^(id error) {
//            [HUDManager hideHUDView];
//            [HUDManager showWarningWithError:error];
//        }];

    }
}
/**
 *  下一步
 */
- (void)nextRetrievePwd
{

    if(_type == 1)
    { // 邮箱
        [self validationEmail:_user.email code:_captchaTF.text completed:^(BOOL successful, id error) {
           if(successful)
           {
               [self performSegueWithIdentifier:@"changePwd" sender:nil];

           }else
           {
               [HUDManager showWarningWithError:error];

           }
        }];
    }else
    { // 手机
        [self validationPhone:_user.mobile code:_captchaTF.text completed:^(BOOL successful, id error) {
            if(successful)
            {
                [self performSegueWithIdentifier:@"changePwd" sender:nil];
                
            }else
            {
                [HUDManager showWarningWithError:error];
                
            }
        }];
    }
}

- (void)validationEmail:(NSString *)email code:(NSString *)code completed:(void (^) (BOOL successful , id error))completed
{
    [NetWork PostNetWorkWithUrl:@"/buyer/validation_email" with:@{@"email":email,@"code":code} successBlock:^(NSDictionary *dic) {
        if([dic[@"status"] boolValue])
        {
            completed (YES , nil);
        }else
        {
            completed(NO, dic[@"message"]);
        }
    } FailureBlock:^(NSString *msg) {
        completed(NO, msg);
    } errorBlock:^(id error) {
        completed(NO , error);
    }];
}

- (void)validationPhone:(NSString *)phone code:(NSString *)code completed:(void (^) (BOOL successful , id error))completed
{
    [NetWork PostNetWorkWithUrl:@"/buyer/validation_phone" with:@{@"phone_num":[phone stringByReplacingOccurrencesOfString:@"+" withString:@""],@"code":code,@"useType":@"change_pwd"} successBlock:^(NSDictionary *dic) {
        if([dic[@"status"] boolValue])
        {
            completed (YES , nil);
        }else
        {
            completed (NO, dic[@"message"]);
        }
    } FailureBlock:^(NSString *msg) {
        completed (NO , msg);
    } errorBlock:^(id error) {
        completed (NO , error);
    }];
}
- (void)currentTextString:(NSString *)text textField:(RegisterTextField *)textField
{
    if(text.length == 0)
    {
        [_nextBtn settingButtonSelectWithSelected:NO];
    }else
    {
        [_nextBtn settingButtonSelectWithSelected:YES];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"changePwd"])
    {
        id vc = segue.destinationViewController;
        [vc setValue:@(_user.userId) forKeyPath:@"userName"];
    }
}
- (void)setCode:(NSString *)code
{
    _code = code;
    [_countDownButton startTimer];
}
@end
