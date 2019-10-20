//
//  EditAddressViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  地址编辑页面

#import "EditAddressViewController.h"
#import "AddressAccountInfoCell.h"
#import "AddressRegionCell.h"
#import "AddressModel.h"
#import "TextViewCell.h"
#import "BaseTableViewCell.h"
#import "ComplaintItemsView.h"
#import "AddressSelectCell.h"
#import "AdressAreaModel.h"


static NSString * AddressAccountInfoCellId = @"AddressAccountInfoCell";
static NSString * AddressRegionCellId = @"AddressRegionCell";
static NSString * TextViewCellId = @"TextViewCell";
static NSString * TableViewCellId = @"tableviewcell";
static NSString * AddressSelectCellId = @"AddressSelectCell";

@interface EditAddressViewController ()<UITableViewDelegate,UITableViewDataSource,AddressAccountInfoCellDelegate,TextViewCellDelegate,AddressRegionCellDelegate,ComplaintItemsViewDelegate,AddressSelectCellDelegate>

@property (nonatomic , weak) UITableView * addressTableView;
@property (nonatomic , strong) UISwitch * defaultSwitch; ///< 选择默认开关
@property (nonatomic , strong) UIBarButtonItem * rightItem;
@property (nonatomic, assign) CountryType countryId;
@property (nonatomic, strong) NSMutableArray *areaArray;
@property (nonatomic, strong) AdressDetailModel *detailModel;

@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, copy) NSString *trueName;//真实姓名
@property (nonatomic, copy) NSString *telephone;//联系电话
@property (nonatomic, copy) NSString *area_info;//地址描述
@property (nonatomic, copy) NSString *zip;//邮编
@property (nonatomic, copy) NSString *areaId;//区域id
@property (nonatomic, copy) NSString *isDefault;//是否默认
@end
@implementation EditAddressViewController
{
    AddressRegionCell * countryCell;

}
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.addressTableView reloadData];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    self.areaArray = [NSMutableArray array];
    if (!self.model) {
        self.title = LaguageControl(@"新建地址");
        self.isDefault = @"0";
    }else {
        self.title = LaguageControl(@"编辑地址");
        self.defaultSwitch.on = _model.defaultAddress;
        //请求地址详情
        [HUDManager showLoadingHUDView:self.view];
//        [self getdataDetial];

    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section) return 1;
    else{
        if (self.model) return self.detailModel ? 5 : 0;
        else return 5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kScaleHeight(15);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footer = [UIView new];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!indexPath.section)
    {
        switch (indexPath.row) {
            case 0:
            case 1:
            case 2:
                return kScaleHeight(44);
            case 3:
                return UITableViewAutomaticDimension;
                break;
            default:
                return kScaleHeight(100);
                break;
        }
    }
    return kScaleHeight(44);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!indexPath.section)
    {
        switch (indexPath.row) {
            case EditAddressOptionName:
            {
               AddressAccountInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressAccountInfoCellId];
                cell.index = indexPath.row;
                cell.title = LaguageControl(@"收货人");
                cell.text = self.detailModel.trueName;
                cell.delegate = self;
                return cell;
            }
                break;
            case EditAddressOptionPhone:
            {
                AddressAccountInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressAccountInfoCellId];
                cell.index = indexPath.row;
                cell.title = LaguageControl(@"联系电话");
                cell.text = self.detailModel.telephone;
                cell.delegate = self;
                return cell;
            }
                break;
            case EditAddressOptionCountry:
            {
                AddressRegionCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressRegionCellId];
                cell.delegate = self;
                return cell;
            }
            case EditAddressOptionPostCode:
            {
                AddressSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressSelectCellId];
                cell.delegate = self;
                cell.textField.text = self.detailModel.zip;
                [cell configCellWithAreaArray:self.areaArray withcountry:self.countryId] ;
                
                self.index = indexPath;
                self.areaId = cell.cityModel.areaId;
                self.zip = cell.textField.text;
                return cell;
            }
                break;
                case EditAddressOptionAddress:
            {
                TextViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TextViewCellId];
                cell.delegate = self;
                cell.placeholder = LaguageControl(@"请填写详细地址，不少于5个字");
                cell.text = self.detailModel.area_info;
                return cell;
            }
            default:
                break;
        }
    }
    BaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellId];
    cell.accessoryView = self.defaultSwitch;
    cell.textLabel.text = LaguageControl(@"设为默认");
    cell.textLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - other Delegate
/**
 *  收货人以及联系电话获取
 */
- (void)addrssAccountWithIndex:(NSInteger)index textField:(UITextField *)textField
{
    switch (index) {
        case EditAddressOptionName:
        {
            self.trueName = textField.text;
        }
            break;
        case EditAddressOptionPhone:
        {
            self.telephone = textField.text;
        }
            break;
        default:
            break;
    }
}
/**
 *  点击国家
 */
- (void)addressRegionClick:(AddressRegionCell *)cell
{
    countryCell = cell;
    ComplaintItemsView * popView = [[ComplaintItemsView alloc] initWithTitles:@[LaguageControl(@"马来西亚"),LaguageControl(@"文莱"),LaguageControl(@"新加坡")]];
    popView.delegate = self;
    popView.contentColor = [UIColor colorWithString:@"#F0F0F0"];
    popView.toolColor = [UIColor whiteColor];
    popView.buttonColor = [UIColor colorWithString:@"#C90C1E"];
    [popView displayToWindow];
}
/**
 *  地址输入框返回文字
 */
- (void)textViewCellValueChangeWithText:(NSString *)text
{
    self.area_info = text;
}
/**
 *  选择国家
 */

-(void)complaintItemWithTitle:(NSString *)title row:(NSInteger)row{
    countryCell.country = title;
    self.countryId = row;
    //请求国家数据
    [HUDManager showLoadingHUDView:self.view];
    [self getdataAreaInfoWith:self.countryId areaId:@""];
}
/**
 *  返回邮编
 */
- (void)addressCell:(AddressSelectCell *)cell zipCode:(NSString *)code
{
    self.zip = code;
}
/**
 *  返回picker areamodel
 */
- (void)addressCell:(AddressSelectCell *)cell areaModel:(AdressAreaModel *)model{
    cell.textField.text = model.zip;
    self.areaId = model.areaId;

}
#pragma mark - event respond 
/**
 *  保存
 */
- (void)saveAddress
{
    if ([self dataCheck]) {
        [HUDManager showLoadingHUDView:self.view];
        [self getdataSaveOrEdit];
    }
    //    if([_delegate respondsToSelector:@selector(editAddressViewController:)])
//    {
//        [_delegate editAddressViewController:self];
//    }
}
- (void)isDefaultWithSwitch:(UISwitch *)sender
{
    _model.defaultAddress = sender.on;
    self.isDefault = sender.on ? @"1":@"0";
}


#pragma mark - setter and getter
- (UITableView *)addressTableView
{
    if(!_addressTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        [tableview registerClass:[AddressSelectCell class] forCellReuseIdentifier:AddressSelectCellId];
        [tableview registerClass:[AddressAccountInfoCell class] forCellReuseIdentifier:AddressAccountInfoCellId];
        [tableview registerClass:[AddressRegionCell class] forCellReuseIdentifier:AddressRegionCellId];
        [tableview registerClass:[TextViewCell class] forCellReuseIdentifier:TextViewCellId];
        [tableview registerClass:[BaseTableViewCell class] forCellReuseIdentifier:TableViewCellId];
        
        tableview.delegate = self;
        tableview.dataSource = self;
        [self.view addSubview:tableview];
        _addressTableView = tableview;
    }
    return _addressTableView;
}
- (UISwitch *)defaultSwitch567
{
    if(!_defaultSwitch)
    {
        _defaultSwitch = [[UISwitch alloc] init];
        [_defaultSwitch addTarget:self action:@selector(isDefaultWithSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _defaultSwitch;
}
- (UIBarButtonItem *)rightItem
{
    if(!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:LaguageControl(@"保存") style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
        _rightItem.tintColor = [UIColor whiteColor];
        
    }
    return _rightItem;
}

#pragma mark -NetWork
///**地址详情*/
//-(void)getdataDetial{
//    //area_id=32777&user_id=32777
//    NSDictionary * parms = @{@"user_id":kUserId,@"id":self.model.adressId};
//    
//    [NetWork PostNetWorkWithUrl:UserAdressDetailAction with:parms successBlock:^(NSDictionary *dic) {
//        
//        self.detailModel = [AdressDetailModel mj_objectWithKeyValues:dic[@"data"][@"address"]];
//        self.areaArray = [AdressAreaModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"area"]];
//        [self.addressTableView reloadData];
//        
//    } FailureBlock:^(NSString *msg) {
//        [self endRefresh];
//        [HUDManager showWarningWithText:msg];
//    } errorBlock:^(NSError *error) {
//        [self endRefresh];
//    }];
//}

/**保存编辑接口*/
-(void)getdataSaveOrEdit{
    //area_id=32777&user_id=32777
    NSDictionary * parms = @{@"area_id":self.areaId,@"user_id":kUserId,@"area_info":self.area_info,@"trueName":self.trueName,@"telephone":self.telephone,@"mobile":self.telephone,@"defaultAddress":self.isDefault,@"zip":self.zip};
    
    [NetWork PostNetWorkWithUrl:UserAdressSaveListAction with:parms successBlock:^(NSDictionary *dic) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
}

/**获取区域信息 //  countryId 2 文莱 1 马来 3 新加坡*/
-(void)getdataAreaInfoWith:(CountryType)countryId areaId:(NSString *)areaId{
    //area_id=32777&user_id=32777
    NSDictionary * parms = @{@"countryId":@(countryId),@"user_id":kUserId,@"id":areaId};
    
    [NetWork PostNetWorkWithUrl:UserAdressAreaInfoAction with:parms successBlock:^(NSDictionary *dic) {
        
        NSArray *lists = dic[@"data"];
        self.areaArray = [AdressAreaModel mj_objectArrayWithKeyValuesArray:lists];
        [self.addressTableView reloadRowsAtIndexPaths:@[self.index] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {

    }];
}
- (BOOL)dataCheck{
    if (self.zip.length == 0) {
        [HUDManager showWarningWithText:@"请填写邮编"];
        return NO;
    }
    if (self.areaId.length == 0) {
        [HUDManager showWarningWithText:@"请选择区域"];
        return NO;
    }
    if (self.area_info.length<5) {
        [HUDManager showWarningWithText:@"请填写详细地址,不少于5个字"];
        return NO;
    }
    if (self.trueName.length ==6) {
        [HUDManager showWarningWithText:@"请输入姓名"];
        return NO;
    }
    if (self.telephone.length ==6) {
        [HUDManager showWarningWithText:@"请填写联系电话"];
        return NO;
    }
    
    return YES;
}

@end
