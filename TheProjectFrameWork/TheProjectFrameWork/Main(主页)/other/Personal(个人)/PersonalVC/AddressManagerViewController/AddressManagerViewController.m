//
//  AddressManagerViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AddressManagerViewController.h"
#import "LoginButton.h"
#import "AddressManagerCell.h"
#import "AddressModel.h"
#import "EditAddressNewViewController.h"
static NSString * AddressManagerCellId = @"AddressManagerCell";
@interface AddressManagerViewController ()<UITableViewDelegate,UITableViewDataSource,AddressManagerCellDelegate>

@property (nonatomic , weak) UITableView * addressTableView;

@property (nonatomic , weak) UIView * footerView;

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UILabel *l;
@property (nonatomic, strong) UILabel *l1;
@end
@interface AddressManagerViewController ()
{
}
@end
@implementation AddressManagerViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self.addressTableView reloadData];
    self.title = @"地址管理";
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取地址列表
    self.view.backgroundColor = kBGColor;
    [HUDManager showLoadingHUDView:self.view];
    [self getdataAdressList];

}

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressManagerCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressManagerCellId];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSelect) {
        AddressModel *adressmodel = self.dataArray[indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
        self.block(adressmodel);
    }
}
#pragma mark - other Delegate
- (void)addressManagerIsDefaultWithCell:(AddressManagerCell *)cell
{
    NSIndexPath *dexpath = [self.addressTableView indexPathForCell:cell];
    AddressModel *model = self.dataArray[dexpath.row];
    cell.isDefault = !model.defaultAddress;
    NSInteger defAdr = model.defaultAddress ? 1:0;
    [self getdataSetDefaultAdressWithAdressId:model.adressId cell:cell defaultAdr:defAdr];
}
- (void)addressManagerEditWithCell:(AddressManagerCell *)cell
{
    EditAddressNewViewController * view = [[EditAddressNewViewController alloc] init];
    view.model = cell.model;
//    view.indexPath = cell.indexPath;
//    view.delegate = self;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)addressManagerDeleteWithCell:(AddressManagerCell *)cell
{
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除该地址吗?" preferredStyle:UIAlertControllerStyleAlert];
    // 2.实例化按钮:actionWithTitle
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
                             {
                                 NSIndexPath *index = [self.addressTableView indexPathForCell:cell];
                                 AddressModel *model = self.dataArray[index.row];
                                 [HUDManager showLoadingHUDView:self.view];
                                 [self getdataDelAdressWithAdressId:model.adressId index:index];
                                 
                             }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertControl animated:YES completion:nil];
    
}
#pragma mark event response
/**
 *  点击新建地址
 */
- (void)clickAddAddress
{
    EditAddressNewViewController * view = [[EditAddressNewViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

#pragma mark - getter and setter
- (UITableView *)addressTableView
{
    if(!_addressTableView)
    {
        
        UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:tableview];
        
        tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableview.separatorColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.rowHeight = kScaleHeight(155);
        [tableview registerClass:[AddressManagerCell class] forCellReuseIdentifier:AddressManagerCellId];
        __weak typeof(self) weakSelf = self;
        CGFloat tabbarHeight = self.tabBarController.tabBar.frame.size.height;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view.mas_bottom).mas_offset(-(kScaleHeight(60)-tabbarHeight));
        }];
        self.footerView.userInteractionEnabled = YES;
        _addressTableView = tableview;
        _addressTableView.backgroundColor = kBGColor;

    }
    return _addressTableView;
}
- (UIView *)footerView
{
    if(!_footerView)
    {
        UIView * view = [UIView new];
        [self.view addSubview:view];
        __weak typeof(self) weakSelf = self;
        self.tabBarController.edgesForExtendedLayout = UIRectEdgeNone;
        view.backgroundColor = kBGColor;
        LoginButton * addAddress = [[LoginButton alloc] initWithActionBlock:^(id sender) {
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf clickAddAddress];

        } title:@"新建地址" image:[UIImage imageNamed:@"jaihao"]];
        [addAddress settingButtonSelectWithSelected:YES];
        [view addSubview:addAddress];
        [addAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
            make.height.equalTo(view.mas_height).multipliedBy(0.7f);
            make.right.equalTo(view.mas_right).mas_offset(-kScaleWidth(24));
            make.left.equalTo(view.mas_left).mas_offset(kScaleWidth(24));
        }];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(kScaleHeight(60));
        }];
        _footerView = view;
    }
    return _footerView;
}

#pragma mark -NetWork
/**获取地址列表*/
-(void)getdataAdressList{
    
    NSDictionary * parms = @{@"user_id":kUserId};//32777
    [NetWork PostNetWorkWithUrl:UserAdressListAction with:parms successBlock:^(NSDictionary *dic) {
        NSArray *lists = dic[@"data"];
        self.dataArray = [AddressModel mj_objectArrayWithKeyValuesArray:lists];
        [self.addressTableView reloadData];
        if (self.dataArray.count == 0) {
            self.addressTableView.hidden = YES;
            [self placeholderview];
        }else{
            self.addressTableView.hidden = NO;
            [self placeholderview];
        }
        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
}

/**删除地址接口*/
-(void)getdataDelAdressWithAdressId:(NSString *)adressid index:(NSIndexPath *)index{
    
    NSDictionary * parms = @{@"user_id":kUserId,@"id":adressid};//32777
    [NetWork PostNetWorkWithUrl:UserAdressDelListAction with:parms successBlock:^(NSDictionary *dic) {
        
        [self.dataArray removeObjectAtIndex:index.row];
        [self.addressTableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (self.dataArray.count == 0) {
            self.addressTableView.hidden = YES;
            [self placeholderview];
        }else{
            self.addressTableView.hidden = NO;
            [self placeholderview];
        }
        if ([[UserAccountManager shareUserAccountManager].cartUserAddress isEqualToString:adressid]) {
            [UserAccountManager shareUserAccountManager].userModel.defaultAdddress = [UserAccountManager shareUserAccountManager].cartUserAddress =@"";
        }
        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
    
}

/**设置默认地址接口*/
-(void)getdataSetDefaultAdressWithAdressId:(NSString *)areaid cell:(AddressManagerCell *)cell defaultAdr:(NSInteger)defAddress{
    
    NSDictionary * parms = @{@"user_id":kUserId,@"id":areaid ,@"defaultAddress":@(defAddress)};//32777
    [NetWork PostNetWorkWithUrl:UserAdressDefaultAction with:parms successBlock:^(NSDictionary *dic)
     {
         [UserAccountManager shareUserAccountManager].userModel.defaultAdddress = [UserAccountManager shareUserAccountManager].cartUserAddress =areaid;
        [self getdataAdressList];
    } FailureBlock:^(NSString *msg) {
        cell.isDefault = !cell.isDefault;
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        cell.isDefault = !cell.isDefault;
        [self endRefresh];
    }];
}


#pragma mark - private methods
- (void)placeholderview{
    
    
    if (self.dataArray.count>0) {
        
        [self.iv removeFromSuperview];
        [self.l removeFromSuperview];
        [self.l1 removeFromSuperview];
    }else{
        
        self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenBoundWidth/2-50, KScreenBoundHeight/2-150, 100  , 320)];
        self.iv.image = [UIImage imageNamed:@"emptyAdress"];
        
        self.l = [[UILabel alloc]initWithFrame:CGRectMake(KScreenBoundWidth/2-125, KScreenBoundHeight/2-200, 250  , 20)];
        self.l.text = LaguageControl(@"没有收货地址咯!!");
        self.l.font = [UIFont systemFontOfSize:14];
        [self.l setTextAlignment:NSTextAlignmentCenter];
        self.l.textColor = [UIColor lightGrayColor];
        
        self.l1 = [[UILabel alloc]initWithFrame:CGRectMake(KScreenBoundWidth/2-150, KScreenBoundHeight/2-180, 300  , 20)];
        self.l1.text = LaguageControl(@"点击下方去新建自己的地址吧。");
        self.l1.font = [UIFont systemFontOfSize:14];
        [self.l1 setTextAlignment:NSTextAlignmentCenter];
        self.l1.textColor = [UIColor lightGrayColor];
        
        [self.view addSubview:self.iv];
        [self.view addSubview:self.l];
        [self.view addSubview:self.l1];
    }

}
@end
