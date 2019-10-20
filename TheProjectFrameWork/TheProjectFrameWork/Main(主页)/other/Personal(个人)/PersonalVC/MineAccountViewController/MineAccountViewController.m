//
//  MineAccountViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineAccountViewController.h"
#import "DefaultTableViewCell.h"
#import "AccountCellModel.h"
#import "LoginButton.h"
#import "MineAccountFooterView.h"
#import "MineAccountPopView.h"
#import "CountDownButton.h"
#import "MineViewModel.h"
#import "ChangePhoneOptionsViewController.h"
#import "NSString+HidePhone.h"

static NSString * DefaultTableViewCellId = @"accountDefaultTableViewCell";

@interface MineAccountViewController ()<UITableViewDelegate,UITableViewDataSource,MineAccountPopViewDelegate>
@property (nonatomic , weak) UITableView * accountTableView;
@property (nonatomic , strong) NSMutableArray <AccountCellModel *>* dataArray;
@property (nonatomic , strong) MineViewModel * model;
@end
@implementation MineAccountViewController

#pragma mark - init
- (instancetype)initWithLogoutBackCall:(LogoutBackCallBlock)logout
{
    self = [super init];
    if(self)
    {
        _logoutEvent = logout;
    }
    return self;
}

#pragma mark - life cycly
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updataHeader:self.accountTableView];
    [self.header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"我的账户"];
}

- (void)updateHeadView
{
    [MineViewModel getMineInfo:^(MineViewModel * model ,id error) {
        if(!error)
        {
            _dataArray = nil;
            self.model = model;
        }else
        {
            [HUDManager showWarningWithError:error];            
        }
        [self.accountTableView reloadData];
        [self endRefresh];
    }];
}
#pragma mark - tableviewDelegate && DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataArray[[self cellIndexWithIndexPath:indexPath]];
    DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DefaultTableViewCellId];
    cell.alignment = YES;
    [cell loadWithModel:model];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 5;
        case 2:
            return 2;
        case 3:
            return 1;
        default:
            return 1;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1 && indexPath.row ==0) {
        return 0;
    }
    return kScaleHeight(44);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kScaleHeight(10);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineAccountOptions option = [self cellIndexWithIndexPath:indexPath];
    Class vc;
    id model = self.dataArray[[self cellIndexWithIndexPath:indexPath]];
    switch (option) {
        case MineAccountOptionAccount:
            break;
        case MineAccountOptionBalance:
            break;
        case MineAccountOptionEmail:
        {
            if([UserAccountManager shareUserAccountManager].userModel.email.length == 0)
            {
                AccountEmailPopView * view = [[AccountEmailPopView alloc] initWithType:MineAccountOptionEmail];
                view.delegate = self;
                view.model = model;
                [view displayFromWindow];

            }else
            {
                ChangePhoneOptionsViewController * email = [[ChangePhoneOptionsViewController alloc] init];
                email.buyer = YES;
                email.type = PopVerifyTypesEmail;
                [self.navigationController pushViewController:email animated:YES];
            }
        }
            break;
        case MineAccountOptionPhone:
        {
            if([UserAccountManager shareUserAccountManager].userModel.mobile.length == 0)
            {
                AccountPhonePopView * view = [[AccountPhonePopView alloc] initWithType:MineAccountOptionPhone];
                view.delegate = self;
                view.model = model;
                [view displayFromWindow];
            }else
            {
                ChangePhoneOptionsViewController * phone = [[ChangePhoneOptionsViewController alloc] init];
                phone.buyer = YES;
                phone.type = PopVerifyTypesPhone;
                [self.navigationController pushViewController:phone animated:YES];
            }
        }
            break;
        case MineAccountOptionName:
        {
            AccountNamePopView * view = [[AccountNamePopView alloc] initWithType:MineAccountOptionName];
            view.delegate = self;
            view.model = model;
            [view displayFromWindow];
        }
            
            break;
        case MineAccountOptionSex:
        {
            AccountSexPopView * view = [[AccountSexPopView alloc] initWithType:MineAccountOptionSex];
            view.delegate = self;
            view.model = model;
            [view displayFromWindow];
        }
            break;
        case MineAccountOptionBirthdate:
        {
            AccountBirthPopView * view = [[AccountBirthPopView alloc] initWithType:MineAccountOptionBirthdate];
            view.model = model;
            view.delegate = self;
            [view displayFromWindow];
        }
            break;
        case MineAccountOptionAddressManagr:
        {
            vc = NSClassFromString(@"AddressManagerViewController");
        }
            break;
        case MineAccountOptionAccountSafe:
        {
            vc = NSClassFromString(@"AccountSafeViewController");
        }
            break;
        case MineAccountOptionCertification:
        {
            vc = NSClassFromString(@"NameAuthViewController");
        }
            break;
        default:
            break;
    }
    if(vc)
    {
        [self.navigationController pushViewController:[vc new] animated:YES];

    }
}
#pragma mark - popViewDelegate
- (void)accountPop:(id)popView GetCode:(CountDownButton *)sender
{
    [sender startTimer];
}

- (void)accountPop:(MineAccountPopView *)popView SaveInfo:(AccountCellModel *)model
{
    /**
     *  4 = 真实姓名
     *  5 = 性别
     *  6 = 生日
     */
    if (popView.type == 2) {
        /**绑定邮箱*/
        [NetWork PostNetWorkWithUrl:@"/buyer/bind_email" with:@{@"user_id":kUserId,@"email":model.prompt} successBlock:^(NSDictionary *dic) {
            _model.email = model.prompt;
            [self.accountTableView reloadData];
            [HUDManager showWarningWithText:@"修改信息成功"];
            [popView removeFromWindow];
            
        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithError:msg];
        } errorBlock:^(NSError *error) {
            [HUDManager showWarningWithError:error];
        }];
        return;
    }
   
    if(popView.type == 4 || popView.type == 5 || popView.type == 6 || popView.type == 3)
    {
        NSMutableDictionary * pamrse = [@{} mutableCopy];
        switch (popView.type) {
            case 4:
                [pamrse setObject:model.prompt forKey:@"trueName"];
                break;
            case 5:
                // 1是男，0是女，-1是保密
            {
                if ([model.prompt isEqualToString:@"男"]) {
                    [pamrse setObject:@1 forKey:@"sex"];
                }else if ([model.prompt isEqualToString:@"女"]){
                     [pamrse setObject:@0 forKey:@"sex"];
                }else{
                     [pamrse setObject:@(-1) forKey:@"sex"];
                }
            }
                break;
            case 6:
                [pamrse setObject:model.prompt forKey:@"birthday"];
                break;
            case 3:
                [pamrse setObject:model forKey:@"telephone"];
                [pamrse setObject:model forKey:@"mobile"];
                break;
        }
        [popView removeFromWindow];
        [pamrse setObject:kUserId forKey:@"user_id"];
        [NetWork PostNetWorkWithUrl:@"/buyer/update_info" with:pamrse successBlock:^(NSDictionary *dic) {
            [self updateWithDic:dic];
        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithError:msg];
        } errorBlock:^(NSError *error) {
            [HUDManager showWarningWithError:error];
        }];
    }
    
}
- (void)updateWithDic:(NSDictionary *)dic
{
    MineViewModel * model = [[MineViewModel alloc] init];
    model = [MineViewModel mj_objectWithKeyValues:dic[@"data"]];
    _model = model;
    _dataArray = nil;
    [self.accountTableView reloadData];
    [HUDManager showWarningWithText:@"修改信息成功"];
}
#pragma mark private Method
- (NSInteger)cellIndexWithIndexPath:(NSIndexPath *)indexPath
{
 if(!indexPath.section)
 {
     return indexPath.row;
 }else
 {
     if(indexPath.section == 1)
     {
         return indexPath.row + 2;
     }else if (indexPath.section == 2)
     {
         return indexPath.row + 7;
     }else if (indexPath.section == 3)
     {
         return 9;
     }
 }
    return 1;
}
- (NSIndexPath *)cellIndexWithNum:(NSInteger)num
{
    if(num >1 && num < 7)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:num-2 inSection:1];
        return indexPath;
    }
    return nil;
}
/**
 *  登出
 */
- (void)logout
{
    [NetWork PostNetWorkWithUrl:@"/logout" with:nil successBlock:^( NSDictionary * content) {
    [HUDManager showWarningWithText:@"退出成功"];
    [[UserAccountManager shareUserAccountManager] logout];
    _logoutEvent();
    [self.navigationController popViewControllerAnimated:YES];
    } errorBlock:^(NSString *error) {

    [[UserAccountManager shareUserAccountManager] logout];
    _logoutEvent();
    [self.navigationController popViewControllerAnimated:YES];
    }];

}


#pragma mark - setter && getter
- (UITableView *)accountTableView
{
    if(!_accountTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.separatorColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor  = kBGColor;
        [tableview registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:DefaultTableViewCellId];
        __weak typeof(self) weakSelf = self;
        UIView * footerView = [UIView new];
        footerView.backgroundColor = kBGColor;
        LoginButton * exit = [[LoginButton alloc] initWithActionBlock:^(id sender) {
            __strong __typeof__(weakSelf) strongSelf = weakSelf;
            [strongSelf logout];
        } title:@"退出登录"];
        [exit settingButtonSelectWithSelected:YES];
        [self.view addSubview:tableview];
        [self.view addSubview:footerView];
        [footerView addSubview:exit];
        
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view.mas_top).mas_offset(self.topLayoutGuide.length);
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.equalTo(weakSelf.view.mas_bottom).mas_offset(self.bottomLayoutGuide.length);
            }
        }];
        [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(weakSelf.view.mas_safeAreaLayoutGuideBottom);
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(weakSelf.view.mas_bottom);

            }
            make.height.mas_equalTo(kScaleHeight(54));
        }];
        [exit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(footerView);
            make.left.equalTo(footerView.mas_left).mas_offset(kScaleWidth(12));
            make.right.equalTo(footerView.mas_right).mas_offset(-kScaleWidth(12));
            make.height.mas_equalTo(footerView.mas_height).mas_offset(-10);
        }];
        _accountTableView = tableview;
    }
    return _accountTableView;
}
- (MineViewModel *)model
{
    if(!_model)
    {
        _model = [[MineViewModel alloc] init];
    }
    return _model;
}
- (NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        NSArray * titles = @[@"用户名称",@"可用余额",@"电子邮箱",@"手机号码",@"真实姓名",@"性别",@"生日",@"地址管理",@"账户安全"];
        NSArray * values = @[@(-1),@(_model.availableBalance),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1)];
        NSString * sex = nil;
        switch (self.model.sex) {
            case 1:
                sex = @"男";
                break;
            case 0:
                sex = @"女";
                break;
            default:
                sex = @"保密";
                break;
        }
        NSArray * prompts = @[self.model.username?self.model.username:[UserAccountManager shareUserAccountManager].userModel.username,@"",self.model.email?self.model.email:@"绑定邮箱", self.model.telephone?[NSString hidePhone:_model.telephone]:@"",self.model.trueName?self.model.trueName:@"",sex,self.model.birthday?[self dateWithString:_model.birthday]:@"",@"",@"可修改密码"];
        NSArray * boolArray = @[@(NO),@(NO),@(NO),@(YES),@(YES),@(YES),@(YES),@(YES),@(YES),@(YES)];
        _dataArray = [@[] mutableCopy];
        [titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            AccountCellModel * model = [[AccountCellModel alloc] initWithTitle:title value:values[idx]  prompt:prompts[idx] isAccessory:boolArray[idx]];
            [_dataArray addObject:model];
        }];
    }
    return _dataArray;
}


- (NSString *)dateWithString:(NSString *)backStr
{
    backStr = [backStr substringToIndex:10];
    return backStr;
}
@end
