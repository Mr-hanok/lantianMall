//
//  PersonalViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PersonalViewController.h"
#import "MineTableViewHeaderView.h"
#import "MineAccountViewController.h"
#import "LoginViewController.h"
#import "PayAttentionGoodsViewController.h"
#import "PayAttentionShopViewController.h"
#import "LookDetialViewController.h"
#import "MineWalletViewController.h"
#import "MinePointsViewController.h"
#import "MineBalanceViewController.h"
#import "CameraTakeMamanger.h"
#import "AllOrdersViewController.h"
#import "AppAsiaShare.h"
#import "MineOrderCell.h"
#import "AllorderCell.h"
#import "MinePropertyCell.h"
#import "DefaultTableViewCell.h"
#import "ShareView.h"
#import "ComplaintManagerViewController.h"
#import "PersonViewModel.h"
#import "VIPPriceManagerViewController.h"
#import "FanLiViewController.h"
#import "ReferrerViewController.h"
/**
 *  根据登录状态阻止用户进入页面
 */
#define kLoginStatus if(![UserAccountManager shareUserAccountManager].loginStatus)\
    {\
        [HUDManager showWarningWithText:@"登录之后更精彩"];\
        return;\
    }

static NSString * PersonalTabelViewIdentifier = @"PersonalTabelViewCell";
static NSString * MineOrderIdentifier = @"MineOrderCell";
static NSString * AllorderCellIdentifier = @"AllorderCell";
static NSString * MinePropertyCellIdentifier = @"MinePropertyCell";
@interface PersonalViewController ()<UITableViewDelegate,UIActionSheetDelegate,UITableViewDataSource,UIAlertViewDelegate,MineTableViewHeaderViewDelegate,AllorderCellDelegate,MinePropertyCellDelegate,MineOrderCellDelegate,ShareViewDelegate>
@property (nonatomic , strong) MineTableViewHeaderView * headerView;

@property (nonatomic , strong) PersonViewModel * model;
@property (nonatomic , strong) UITableView * mineTableView;///< 界面内容tableview

@end
@implementation PersonalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updataHeader:self.mineTableView];

    
//    [self.model downloadNewIconUrl:[UserAccountManager shareUserAccountManager].userModel.iconUrl];
}
- (void)updateHeadView
{
    [self.model refreshUserInfo];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"我的");
    self.view.userInteractionEnabled = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.headerView updateViewInfo];
    [_model refreshUserInfo];
    [self.mineTableView reloadData];
}

-(void)BaseLoadView{
}

- (void)replaceUserIconWithImage:(UIImage *)image
{
   [self.model replaceUserIconWithImage:image];
}


#pragma mark - tableviewDelegate&&DataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
       return 2;
    }else if (section == 5 ){
        /**邀请好友*/
        return 0;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 5 ? 0 : kScaleHeight(10);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  section == 8 ? kScaleHeight(10) :0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MineTableViewHeaderView * view = [MineTableViewHeaderView new];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MineTableViewHeaderView * view = [MineTableViewHeaderView new];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
      /**订单部分*/
        case 0:
        {
            if(indexPath.row)
            {
                MineOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:MineOrderIdentifier];
                cell.delegate = self;
                [cell loadOrderStatus];
                return cell;
            }else
            {
                AllorderCell * cell = [tableView dequeueReusableCellWithIdentifier:AllorderCellIdentifier];
                cell.delegate = self;
                cell.type = PersonalTypeOrder;
                [cell loadTitle:[LaguageControl languageWithString:@"我的订单"] accessory:[LaguageControl languageWithString:@"查看全部订单"] image:[UIImage imageNamed:@"dingdantubiao"]];
                return cell;
            }
            
        }
            break;
            case 1:
        {   /**账号积分*/
                MinePropertyCell * cell = [tableView dequeueReusableCellWithIdentifier:MinePropertyCellIdentifier];
                [cell loadWithModel:nil];
                 cell.delegate = self;
                return cell;
        }
            
        case 2:
        {/**我的优惠券*/
            DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalTabelViewIdentifier];
            cell.title = @"我的优惠券";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 3:
        {/**我的优惠券*/
            DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalTabelViewIdentifier];
            cell.title = @"我的返利";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 4:
        {/**我的优惠券*/
            DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalTabelViewIdentifier];
            cell.title = @"我推荐的人";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        case 5:
        {   
            DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalTabelViewIdentifier];
            cell.title = @"邀请好友";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            return cell;
        }
            break;
        case 6:
        {
            DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalTabelViewIdentifier];
            cell.title = [LaguageControl languageWithString:@"投诉管理"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            return cell;
        }
            break;
        case 7:
        {
            DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalTabelViewIdentifier];
            cell.title = [LaguageControl languageWithString:@"联系客服"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
            break;
        default:
        {
            DefaultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PersonalTabelViewIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.title = @"更多";
            return cell;
        }
            break;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section != 0 && indexPath.section != 1)
    {
        return kScaleHeight(44);
    }
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 7)
    {// 点击 联系客服
        [NetWork PostNetWorkWithUrl:@"/buyer/kf_info" with:nil successBlock:^(NSDictionary *dic) {
            NSString *telphonestr = dic[@"data"]?:@"";
            [UserAccountManager shareUserAccountManager].servicePhone = telphonestr?:@"";
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            NSString * content = [NSString stringWithFormat:@"%@%@",@"是否拨打客服电话",telphonestr];
            UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:content delegate:self cancelButtonTitle:[LaguageControl languageWithString:@"取消"] destructiveButtonTitle:[LaguageControl languageWithString:@"拨打"] otherButtonTitles:nil, nil];
            action.tag = 100;
            [action showInView:self.view];
#pragma clang diagnostic pop
            
        } FailureBlock:^(NSString *msg) {
            if (msg.length>10) {
                [UserAccountManager shareUserAccountManager].servicePhone = msg?:@"";
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
                NSString * content = [NSString stringWithFormat:@"%@%@",@"是否拨打客服电话",msg];
                UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:content delegate:self cancelButtonTitle:[LaguageControl languageWithString:@"取消"] destructiveButtonTitle:[LaguageControl languageWithString:@"拨打"] otherButtonTitles:nil, nil];
                action.tag = 100;
                [action showInView:self.view];
#pragma clang diagnostic pop

            }
        } errorBlock:^(id error) {
            
        }];

    }
    if(indexPath.section == 6)
    {// 点击 投诉管理
        kLoginStatus;
        ComplaintManagerViewController * controller = [[ComplaintManagerViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        self.tabBarController.tabBar.hidden = YES;
    }
    if(indexPath.section == 5)
    {   /**邀请好友*/
        ShareView * share = [[ShareView alloc] init];
        share.delegate = self;
        [share displayToWindow];
    }
    if(indexPath.section == 4)
    {   /**我的返利*/
        kLoginStatus;
        ReferrerViewController *vc = [[ReferrerViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.section == 3)
    {   /**我推荐的人*/
        kLoginStatus;
        FanLiViewController *vc = [[FanLiViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.section == 2)
    {   /**我的优惠劵*/
        kLoginStatus;
        VIPPriceManagerViewController *vc = [[VIPPriceManagerViewController alloc]init];
        vc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 8) {
        //发现

    }
}



#pragma mark - other Delegate
/**
 *  点击了头像信息
 */
- (void)headerClickIcon
{
    if([UserAccountManager shareUserAccountManager].loginStatus)
    {
        UIActionSheet * iconSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:[LaguageControl languageWithString:@"取消"] destructiveButtonTitle:[LaguageControl languageWithString:@"相机"] otherButtonTitles:[LaguageControl languageWithString:@"相册"], nil];
        iconSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
        iconSheet.tag = 101;
        [iconSheet showInView:self.view];

    }else
    {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        [self presentViewController:loginStoryBoard.instantiateInitialViewController animated:YES completion:^{
        }];
    }   
}

/**
 *  账户管理
 */
- (void)mineTableViewHeaderAccountManager
{
    self.tabBarController.tabBar.hidden = YES;
    __weak typeof(self) weakSelf = self;
    MineAccountViewController * controller = [[MineAccountViewController alloc] initWithLogoutBackCall:^{
        [weakSelf.mineTableView reloadData];
    }];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)mineTableViewHeaderAssisClickWithType:(NSInteger)type
{
    /**
     *  type == 1  关注商品
     *  type == 2  关注店铺
     *  type == 3  我的店铺
     */
    __kindof UIViewController * controller = nil;
    switch (type) {
        case 1:
        {
            kLoginStatus;
            PayAttentionGoodsViewController * view = [[PayAttentionGoodsViewController alloc] init];
            view.isShop = NO;
            controller = view;
        }
            break;
        case 2:
        {
            kLoginStatus;
            PayAttentionGoodsViewController * view = [[PayAttentionGoodsViewController alloc] init];
            view.isShop = YES;
            controller = view;
        }
            break;
        default:
        {
            [self mineShop];
        }
            break;
    }
    if(controller)
    {
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        self.tabBarController.tabBar.hidden = YES;
    }
}
- (void)allorderClickEventWithType:(NSInteger)type
{
    kLoginStatus;
    PersonalTypes types = type;
    __kindof UIViewController * vc;
    switch (types) {
        case PersonalTypeWallet:
        {
            MineWalletViewController * view =  [[MineWalletViewController alloc] init];
            view.buyer = YES;
            vc = view;
        }
            break;
        case PersonalTypePoint:
        {
            vc = [[MinePointsViewController alloc] init];
        }
            break;
        case PersonalTypeOrder:
        {
            vc = [[AllOrdersViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
        }
            break;
        default:
            break;
    }
    if(vc) {
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
/**
 *  点击订单 （已取消等）
 */
- (void)buyerOrderStatus:(OrderTypes)status
{
    kLoginStatus;
    if(OrderTypesRefund == status)
    {// 退款
        LookDetialViewController * view = [LookDetialViewController new];
        view.ordertype = OrderTypesRefund;
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    
    }else
    {
        LookDetialViewController * view = [LookDetialViewController new];
        view.ordertype = status;
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
}
- (void)minePropertyClickEventWithIndex:(NSInteger)tag
{
    kLoginStatus;
    MinePropertyType type = tag;
    __kindof UIViewController * controller;
    switch (type) {
        case MinePropertyTypeWallet:
        {
           MineWalletViewController * view = [[ MineWalletViewController alloc]init];
            view.buyer = YES;
            controller = view;
        }
            break;
        case MinePropertyTypePointShop:
        {
            if ([[NSUserDefaults standardUserDefaults]boolForKey:@"integralStoreSwitch"]) {
                [self.tabBarController setSelectedIndex:2];
                return;

            }else{

            }
        }
            break;
        case MinePropertyTypeWalletDetails:
        {
            MineBalanceViewController * view = [[MineBalanceViewController alloc] init];
            view.type = 1;
            view.buyer = YES;
            controller = view;
        }
            break;
        case MinePropertyTypePointShopDetails:
        {
            MinePointsViewController * view = [[MinePointsViewController alloc] init];
            controller = view;
        }
            break;
        default:
            break;
    }
    if(controller) {
           self.tabBarController.tabBar.hidden = YES;
           controller.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:controller animated:YES];
    }
}
-(void)minePropertyIntegralMallClickEvent{
    kLoginStatus
}
/**
 *  返回选择语言
 *
 *  @param language <#language description#>
 */
- (void)mineTableViewHeader:(MineTableViewHeaderView *)header Language:(LanguageTypes)language
{
    [[LaguageControl shareControl] setType:language];
    [header settingLanguage:language];
    [self.mineTableView reloadData];
    [_headerView updateViewInfo];
    [self.footer reloadFooterTitle];
}
/**
 *  点击联系客服
 *
 *
 *  @return <#return value description#>
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == actionSheet.cancelButtonIndex)
        return;
    if(actionSheet.tag == 100)
    {
        /**
         *  拨打客服电话
         */
        NSString * servicePhone = [[UserAccountManager shareUserAccountManager].servicePhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        servicePhone = [servicePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString * phoneNO = [NSString stringWithFormat:@"tel:%@",servicePhone];
        UIWebView * callWebView = [[UIWebView alloc] init];
        [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNO]]];
        [self.view addSubview:callWebView];
    }
    if(actionSheet.tag == 101)
    {
        /**
         *  修改头像
         */
        if(buttonIndex == 1)
        {
            [self localPhotos];
        }
        if(buttonIndex == 0)
        {
            [self localCamera];
        }
    }
}
- (void)localPhotos
{
    [[CameraTakeMamanger sharedInstance] imageWithPhotoInController:self handler:^(UIImage *image, NSString *imagePath) {
        [self replaceUserIconWithImage:image];
    } cancelHandler:nil];
}
- (void)localCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [HUDManager showWarningWithText:@"相机不可用"];
        return;
    }
    [[CameraTakeMamanger sharedInstance]imageWithCameraInController:self handler:^(UIImage *image, NSString *imagePath) {
        [self replaceUserIconWithImage:image];
    } cancelHandler:nil];
}


/**
 *  点击我的店铺
 */
- (void)mineShop
{
    
    if (![UserAccountManager shareUserAccountManager].loginStatus) {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        [self presentViewController:loginStoryBoard.instantiateInitialViewController animated:YES completion:^{
        }];
        return;
    }
    [self.model getUserShopInfo];

}
#pragma mark - share
- (void)shareEventWithView:(ShareView *)view type:(ShareTypes)type
{
    NSString * shareURL = [NSString stringWithFormat:@"%@/regInviter?user_id=%@",KAppRootUrl,kUserId];
    [AppAsiaShare shareType:type title:@"电商示例" text:@"电商示例" WithContentUrl:shareURL imagePath:nil success:^{
        [view removeFromWindow];
    } fail:^(NSString *errorMessage) {
        [HUDManager showWarningWithError:errorMessage];
        [view removeFromWindow];
    } cancel:^{
        [view removeFromWindow];
    }];
}

- (void)reloadUserInfo
{
    [self.model refreshUserInfo];
}
#pragma mark - setter and getter method
- (UITableView *)mineTableView
{
    if(!_mineTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.tableHeaderView = self.headerView;
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.estimatedRowHeight = 100;
        tableview.separatorColor = [UIColor clearColor];
        tableview.backgroundColor = kBGColor;
        [tableview registerClass:[MineOrderCell class] forCellReuseIdentifier:MineOrderIdentifier];
        [tableview registerClass:[AllorderCell class] forCellReuseIdentifier:AllorderCellIdentifier];
        [tableview registerClass:[MinePropertyCell class] forCellReuseIdentifier:MinePropertyCellIdentifier];
        [tableview registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:PersonalTabelViewIdentifier];
        [self.view addSubview:tableview];
        _mineTableView = tableview;
        [_mineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    return _mineTableView;
}
- (MineTableViewHeaderView *)headerView
{
    if(!_headerView)
    {
        MineTableViewHeaderView * tempHeaderView =[[MineTableViewHeaderView alloc] initWithUserModel:[UserAccountManager shareUserAccountManager].userModel];
        tempHeaderView.frame = CGRectMake(0, 0, KScreenBoundWidth, kScaleHeight(150));
        tempHeaderView.delegate = self;
        _headerView = tempHeaderView;
    }
    return _headerView;
}
- (PersonViewModel *)model
{
    if(!_model)
    {
        _model = [[PersonViewModel alloc] init];
        _model.controller = self;
        _model.headerView = self.headerView;
        _model.tableView  = self.mineTableView;
    }
    return _model;
}

@end
