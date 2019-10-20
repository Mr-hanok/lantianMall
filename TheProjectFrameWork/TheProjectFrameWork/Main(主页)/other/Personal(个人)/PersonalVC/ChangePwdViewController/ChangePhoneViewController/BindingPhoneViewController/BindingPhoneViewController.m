//
//  BindingPhoneViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BindingPhoneViewController.h"
#import "TableViewPromptHeaderView.h"
#import "RegisterTextField.h"
#import "LoginButton.h"
#import "CountDownButton.h"
#import "MineShopAccountModel.h"
#import "ComplaintItemsView.h"
#import "PersonalViewController.h"
@interface BindingPhoneViewController ()<RegisterTextFielDelegate,CountDownButtonDelegate,SelectePhoneTextFieldDelegate,ComplaintItemsViewDelegate>
{
    TableViewPromptHeaderView * _headerView;
    __kindof UIView * _payPassWord;
    LoginButton * _commitButton;
    RegisterTextField * _captchaTF;
    CountDownButton * _countDownButton;
    NSString * code;
}
@end
@implementation BindingPhoneViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self viewLoadSubviews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:_type?@"修改绑定邮箱":@"修改绑定手机号"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_countDownButton invalidateTimer];
}
- (void)viewWillLayoutSubviews
{
    __weak typeof(self) weakSelf = self;
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kTopSpace).priority(750);
        make.right.left.equalTo(weakSelf.view);
    }];
    [_payPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_headerView.mas_bottom).mas_offset(kScaleHeight(2));
    }];
    [_captchaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.top.equalTo(_payPassWord.mas_bottom).mas_offset(kScaleHeight(20));
        make.height.mas_equalTo(kScaleHeight(40));
        make.right.equalTo(_countDownButton.mas_left).mas_offset(-kScaleWidth(15)).priority(750);
    }];
    [_countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.top.equalTo(_payPassWord.mas_bottom).mas_offset(kScaleHeight(20));
        make.height.mas_equalTo(kScaleHeight(40));
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(0.36f).priority(500);
    }];
    [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_countDownButton.mas_bottom).mas_offset(kScaleHeight(10));
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
    }];
}
- (void)viewLoadSubviews
{
    _headerView = [[TableViewPromptHeaderView alloc] init];
    if(_type)
    {
        RegisterTextField * tempView = [[RegisterTextField alloc] initWithPlaceholder:@"输入您的邮箱号" isVerify:NO];
        tempView.delegate = self;
        _payPassWord = tempView;
    }else
    {
        SelectePhoneTextField * tempView = [[SelectePhoneTextField alloc] initWithTitle:@"" placeholder:@"输入您的手机号"];
        tempView.delegate = self;
        _payPassWord = tempView;
    }
    _captchaTF = [[RegisterTextField alloc] initWithPlaceholder:@"请输入验证码" isVerify:NO];
    _countDownButton = [[CountDownButton alloc] initWithInterval:60 Target:self Sel:@selector(testGetCode)];
    _countDownButton.delegate = self;
    _captchaTF.delegate = self;
    __weak typeof(self) weakSelf = self;
    _commitButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf bindingPhone];
    } title:@"确定绑定"];
    [self.view addSubview:_headerView];
    [self.view addSubview:_payPassWord];
    [self.view addSubview:_commitButton];
    [self.view addSubview:_captchaTF];
    [self.view addSubview:_countDownButton];
    [self loadViewWords];
}
- (void)loadViewWords
{
    _headerView.text =_type?@"绑定邮箱号可以最大程度保障您的账户安全":@"绑定手机号可以最大程度保障您的账户安全";
}
/**
 *  获取验证码
 */
- (void)testGetCode
{
    if(_type)
    { // 邮箱
        RegisterTextField * tempView = _payPassWord;
        if(![NSString validateEmail:tempView.text] || tempView.text.length == 0)
        {
            [HUDManager showWarningWithText:@"请输入正确的电子邮箱"];
            return;
        }
        [HUDManager showLoadingHUDView:Kwindow withText:@"请稍等"];
        [NetWork PostNetWorkWithUrl:@"/sendEmail" with:@{@"email":tempView.text,@"type":@"email_bing_email_notify"} successBlock:^(NSDictionary *dic) {
            code = dic[@"message"];
            [HUDManager hideHUDView];
            [_countDownButton startTimer];
        } FailureBlock:^(NSString *msg) {
            [HUDManager hideHUDView];
            [HUDManager showWarningWithError:msg];
        } errorBlock:^(id error) {
            [HUDManager hideHUDView];
            [HUDManager showWarningWithError:error];
        }];
    }else
    { // 手机号
        SelectePhoneTextField * tempView = _payPassWord;
        if (![NSString verifyPhoneWithAreaCode:tempView.areaPhoneCode phone:tempView.phone] || tempView.phone.length == 0)
        {
            [HUDManager showWarningWithText:@"请输入正确的手机号"];
            return;
        }
        [HUDManager showLoadingHUDView:Kwindow withText:@"请稍等"];
        NSString * mobile = [NSString stringWithFormat:@"%@%@",tempView.areaPhoneCode,tempView.phone];
//        [NetWork PostNetWorkWithUrl:@"/send_mobile_message" with:@{@"mobile":[mobile stringByReplacingOccurrencesOfString:@"+" withString:@""],@"type":@"sms_bing_mobile__notify"} successBlock:^(NSDictionary *dic) {
//            code = dic[@"message"];
//            [HUDManager hideHUDView];
//            [_countDownButton startTimer];
//        } FailureBlock:^(NSString *msg) {
//            [HUDManager hideHUDView];
//            [HUDManager showWarningWithError:msg];
//        } errorBlock:^(id error) {
//            [HUDManager hideHUDView];
//            [HUDManager showWarningWithError:error];
//        }];
        
        [NetWork PostNetWorkSendMessageWith:MessageCodeTypeChangePhone mobile:mobile successBlock:^(NSDictionary *dic) {
            code = dic[@"message"];
            [_countDownButton startTimer];

        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithError:msg];

        } errorBlock:^(id error) {
            
        }];
        
        
//        [NetWork PostNetWorkWithUrl:@"/getMsgCode" with:@{@"phone":[mobile stringByReplacingOccurrencesOfString:@"+" withString:@""]} successBlock:^(NSDictionary *dic) {
//            [HUDManager hideHUDView];
//            code = dic[@"message"];
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
- (void)countDownStop
{
    code = nil;
    [_commitButton settingButtonSelectWithSelected:NO];
}
#pragma mark - RegisterTextFielDelegate
- (void)currentTextString:(NSString *)text textField:(id)textField
{
    NSString * textString = nil;
    if(_type)
    {
        RegisterTextField * tempView =  _payPassWord;
        textString = tempView.text;
    }else
    {
        SelectePhoneTextField * tempView = _payPassWord;
        textString = tempView.phone;
    }
    if(textString != 0 && _captchaTF.text.length != 0)
    {
        [_commitButton settingButtonSelectWithSelected:YES];
    }else
    {
        [_commitButton settingButtonSelectWithSelected:NO];
    }
}
- (void)selectPhoneChangeArea:(SelectePhoneTextField *)textFide
{
    if(!_buyer)
    {
        return;
    }
    ComplaintItemsView * view = [[ComplaintItemsView alloc] initWithTitles:@[@"+60",@"+65",@"+673"]];
    view.delegate = self;
    view.contentColor = [UIColor colorWithString:@"#F0F0F0"];
    view.toolColor = [UIColor whiteColor];
    view.buttonColor = [UIColor colorWithString:@"#C90C1E"];
    [view displayToWindow];
}


- (void)selectPhoneTextChange:(SelectePhoneTextField *)textFidel
{
    if(textFidel.phone.length != 0 && _captchaTF.text.length != 0)
    {
        [_commitButton settingButtonSelectWithSelected:YES];
    }else
    {
        [_commitButton settingButtonSelectWithSelected:NO];
    }
}
- (void)complaintItemWithTitle:(NSString *)title
{
    SelectePhoneTextField * tempView = _payPassWord;
    [tempView chaneAreaCode:title];
}
#pragma mark event respond
/**
 *  确定绑定(需要先验证)
 */
- (void)bindingPhone
{
    NSString * url = nil;
    if(_buyer)
    {
    _type ? (url = @"/buyer/bind_email"):(url = @"/buyer/bind_telePhone");
    }else
    {
    _type ? (url = @"/buyer/seller_update_email"):(url = @"/buyer/seller_update_telePhone");
    }
    
    NSString * info = nil;
    
    if(_type)
    {
        RegisterTextField * tempView = _payPassWord;
        info = tempView.text;
        if(![NSString validateEmail:info])
        {
            [HUDManager showWarningWithText:@"请输入正确的邮箱号"];
            return;
        }
        [self validationEmail:info code:_captchaTF.text completed:^(BOOL successful, id error) {
            if(successful)
            {
                [self bindindWithUserInfo:info url:url];
            }else
            {
                [HUDManager showWarningWithError:error];
            }
        }];
        
    }else
    {
        SelectePhoneTextField * tempView = _payPassWord;
        info = [NSString stringWithFormat:@"%@%@",tempView.areaPhoneCode,tempView.phone];
        [self validationPhone:info code:_captchaTF.text completed:^(BOOL successful, id error) {
            if(successful)
            {
                [self bindindWithUserInfo:info url:url];
            }else
            {
                [HUDManager showWarningWithError:error];
                [_countDownButton stopTimeing];
            }
        }];
    }

}

- (void)validationEmail:(NSString *)email code:(NSString *)validationCode completed:(void (^) (BOOL successful , id error))completed
{
    [NetWork PostNetWorkWithUrl:@"/buyer/validation_email" with:@{@"email":email,@"code":validationCode} successBlock:^(NSDictionary *dic) {
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
- (void)bindindWithUserInfo:(NSString *)info url:(NSString *)url
{
    
    NSMutableDictionary * parasm = [@{_type?@"email":@"telePhone":_type?info:[info stringByReplacingOccurrencesOfString:@"+" withString:@""]} mutableCopy];
    if(_buyer)
    {
        [parasm setObject:kUserId forKey:@"user_id"];
    }else
    {
        [parasm setObject:@([UserAccountManager shareUserAccountManager].shopModel.store_id) forKey:@"store_id"];
    }
    
    [NetWork PostNetWorkWithUrl:url with:parasm successBlock:^(NSDictionary *dic) {
        [HUDManager showWarningWithText:dic[@"message"]];
        [self popToPersonController];
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager showWarningWithError:error];
    }];
}
- (void)validationPhone:(NSString *)phone code:(NSString *)validationCode completed:(void (^) (BOOL successful , id error))completed
{
    
    [NetWork PostNetWorkWithUrl:@"/buyer/validation_phone" with:@{@"phone_num":[phone stringByReplacingOccurrencesOfString:@"+" withString:@""],@"code":validationCode,@"useType":@"change_phone"} successBlock:^(NSDictionary *dic) {
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

- (void)popToPersonController
{
    for (BaseViewController __kindof * controller in self.navigationController.viewControllers
         ) {
        if([controller isKindOfClass:[PersonalViewController class]])
        {
            PersonalViewController * person = controller;
            [person reloadUserInfo];
            break;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
