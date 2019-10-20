//
//  NameAuthViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NameAuthViewController.h"
#import "RegisterTextField.h"
#import "LoginButton.h"

@interface NameAuthViewController ()
{
    RegisterTextField * _nameTextField;
    RegisterTextField * _IDTextField;
    LoginButton * _nextButton;
}
@end
@implementation NameAuthViewController
#pragma mark - life cycle 
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadViews];
}
- (void)loadViews
{
    _nameTextField = [[RegisterTextField alloc] init];
    _IDTextField = [[RegisterTextField alloc] init];
    __weak typeof(self) weakSelf = self;
    _nextButton = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf clickNext];

    } title:@"下一步"];
    [self.view addSubview:_nameTextField];
    [self.view addSubview:_IDTextField];
    [self.view addSubview:_nextButton];
    _nameTextField.title = @"真实姓名";
    _IDTextField.title = @"身份证号";
    _nameTextField.placeholder = @"输入姓名";
    _IDTextField.placeholder = @"输入身份证号";
    _nameTextField.sideline = YES;
    _nameTextField.sideline = YES;
    [_nextButton settingButtonSelectWithSelected:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"实名认证";
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;
    [_nameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kScaleHeight(8)+kTopSpace);
        make.height.mas_equalTo(kScaleHeight(40));
    }];
    [_IDTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(_nameTextField.mas_bottom);
        make.height.equalTo(_nameTextField.mas_height);
    }];
    [_nextButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.top.equalTo(_IDTextField.mas_bottom).mas_offset(kScaleHeight(30));
        make.height.equalTo(_nameTextField.mas_height);
    }];
}

/**
 *  点击下一步
 */
- (void)clickNext
{
    Class vc = NSClassFromString(@"ShootPhotoViewController");
    [self.navigationController pushViewController:[vc new] animated:YES];
}
#pragma mark - setter and getter

@end
