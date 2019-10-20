//
//  EditAddressNewViewController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EditAddressNewViewController.h"
#import <IQTextView.h>
#import "ComplaintItemsView.h"
#import "AddressModel.h"
#import "SelectAddressPickerView.h"
#import "AreaModel.h"
@interface EditAddressNewViewController ()<ComplaintItemsViewDelegate,UITextFieldDelegate,UITextViewDelegate,SelectAddressPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryTF;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UITextField *postTF;
@property (weak, nonatomic) IBOutlet IQTextView *detailTV;
@property (weak, nonatomic) IBOutlet UILabel *defaultLalbel;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@property (nonatomic, assign) CountryType countryId;
@property (nonatomic, strong) AdressDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UIButton *countrybtn;

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, copy) NSString *isDefault;
@property (weak, nonatomic) IBOutlet UILabel *locationAreaLabel;
@property (weak, nonatomic) IBOutlet UITextField *areaTF;
@property (nonatomic, copy) NSString *areaid;

@property (nonatomic, strong) AdressAreaModel *areainfoModel;

@property (weak, nonatomic) IBOutlet UIView *defaultView;

@property (nonatomic, strong) AddressModel *testModel;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultViewHeigth;

@property (nonatomic , copy) NSArray<AreaModel *> * areaInfos;

@end

@implementation EditAddressNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = LaguageControl(@"编辑地址");
    self.countryTF.backgroundColor = kNavigationColor;
    self.detailTV.delegate = self;
    self.locationAreaLabel.userInteractionEnabled = YES;
    self.nameLabel.text = LaguageControlAppend(@"收货人");
    self.phoneLabel.text = LaguageControlAppend(@"手机号码");
    self.countryLabel.text = LaguageControlAppend(@"所在地区");
    self.postLabel.text = LaguageControlAppend(@"邮编");
    self.defaultLalbel.text = LaguageControlAppend(@"设为默认");
    self.detailTV.placeholder = LaguageControl(@"请填写详细地址,1-50字符");
    self.postTF.placeholder = LaguageControl(@"不知道邮编,默认000000");
    self.areaLabel.text = LaguageControlAppend(@"地区");
    self.areaTF.placeholder = LaguageControl(@"地区");
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    self.phoneTF.placeholder = LaguageControl(@"请输入电话号码");
    [self.phoneTF setKeyboardType:UIKeyboardTypeNumberPad];
    self.countryId = CountryTypeMala;
    if (!self.model) {
        self.title = LaguageControl(@"新建地址");
        self.isDefault = @"0";
    }else {
        self.title = LaguageControl(@"编辑地址");
        self.defaultBtn.selected = _model.defaultAddress;
        //请求地址详情
        [HUDManager showLoadingHUDView:self.view];
        [self getdataDetial];
    }
    //游客隐藏默认地址
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        self.defaultView.hidden = NO;
        self.defaultViewHeigth.constant = 44.0f;
    }else{
        self.defaultView.hidden = YES;
        self.defaultViewHeigth.constant = 0.0f;
    }
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectArea)];
    [self.locationAreaLabel addGestureRecognizer:tap];
}
-(void)backToPresentViewController
{
    [super backToPresentViewController];
    if (self.block&&self.testModel)
    {
        self.block(self.testModel);
    }
    
}
- (UIBarButtonItem *)rightItem
{
    if(!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:LaguageControl(@"保存") style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
        _rightItem.tintColor = kIsChiHuoApp ? kTextDeepDarkColor :[UIColor whiteColor];
    }
    return _rightItem;
}

-(void)GetBlocksWIth:(AddressModelCallBack)block
{
    self.block = block;
    
}

#pragma mark - uitextviewdelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.phoneTF) {
        if (self.countryId==0||self.countryId==1||self.countryId==2||self.countryId==3) {
            return YES;
        }
        [HUDManager showWarningWithText:@"请先选择国家"];
        return NO;
    }else {
        return YES;
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    //结束编辑 根据邮编 获取地区
//    [self getdataAreaInfoByZipWith:self.countryId zip:textField.text];
}
- (void)selectAddress:(NSString *)address areaId:(NSString *)areaId
{
    self.locationAreaLabel.text = address;
    self.areaid = areaId;
}
#pragma mark - event response

/**保存*/
-(void)saveAddress{
    [self.view endEditing:YES];
    if ([self dataCheck]) {
        [HUDManager showLoadingHUDView:self.view];
        [self getdataSaveOrEdit];
    }
}
/**选择国家按钮*/
- (IBAction)countryBtnClick:(UIButton *)sender {
        [self.view endEditing:YES];
        ComplaintItemsView * popView = [[ComplaintItemsView alloc] initWithTitles:@[LaguageControl(@"马来西亚"),LaguageControl(@"文莱"),LaguageControl(@"新加坡")]];
        popView.delegate = self;
        popView.contentColor = [UIColor colorWithString:@"#F0F0F0"];
        popView.toolColor = [UIColor whiteColor];
        popView.buttonColor = [UIColor colorWithString:@"#C90C1E"];
        [popView displayToWindow];
}

/**设为默认*/
- (IBAction)switchBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    self.isDefault = sender.selected ? @"1":@"0";
}

/**
 *  选择国家
 */
-(void)complaintItemWithTitle:(NSString *)title row:(NSInteger)row{
    self.countryTF.text = title;
    self.countryId = row;
    self.areaTF.text = @"";
    self.postTF.text = @"";
    
}
/**
 *  选择所在地区
 */
- (void)selectArea
{
    [self.view endEditing:YES];
    if(self.areaInfos.count != 0 && self.areaInfos != nil)
    {
        SelectAddressPickerView * view = [[SelectAddressPickerView alloc] initWithAreaInfos:self.areaInfos];
        view.delegate = self;
        [view displayToWindow];
    }else
    {
        [HUDManager showLoadingHUDView:Kwindow withText:@"请稍候"];
        [NetWork PostNetWorkWithUrl:@"/buyer/areaInfos" with:nil successBlock:^(NSDictionary *dic) {
            self.areaInfos = [AreaModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"dateInfo"]];
            SelectAddressPickerView * view = [[SelectAddressPickerView alloc] initWithAreaInfos:self.areaInfos];
            view.delegate = self;
            [view displayToWindow];
        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithError:msg];
        } errorBlock:^(id error) {
            [HUDManager showWarningWithError:error];
        }];
    }
}
#pragma mark -NetWork
/**地址详情*/
-(void)getdataDetial{
    //area_id=32777&user_id=32777
    NSDictionary * parms = @{@"user_id":kUserId,@"id":self.model.adressId};
    
    [NetWork PostNetWorkWithUrl:UserAdressDetailAction with:parms successBlock:^(NSDictionary *dic) {
        
        self.detailModel = [AdressDetailModel mj_objectWithKeyValues:dic[@"data"][@"address"]];
        
        self.nameTF.text = self.detailModel.trueName;
        
        self.phoneTF.text = self.detailModel.telephone ? self.detailModel.telephone : self.detailModel.mobile;

        self.postTF.text = self.detailModel.zip;
        self.defaultBtn.selected = self.model.defaultAddress;
        self.detailTV.text = self.detailModel.area_info;
        self.isDefault = self.model.defaultAddress ? @"1" :@"0";
        
        self.countryId = self.detailModel.country;
        self.countrybtn.enabled = NO;
        
        AdressAreaModel *model2 =self.detailModel.marea.childs[0];
        AdressAreaModel *model3 = model2.childs[0];
        if (model2 != nil) {
            if (model3 != nil) {
                self.locationAreaLabel.text =[NSString stringWithFormat:@"%@,%@,%@",self.detailModel.marea.areaName,model2.areaName,model3.areaName];
                self.areaid = model3.areaId;
            }else{
                self.locationAreaLabel.text = [NSString stringWithFormat:@"%@,%@",self.detailModel.marea.areaName,model2.areaName];
                self.areaid = model2.areaId;
            }
        }else{
            self.locationAreaLabel.text =[NSString stringWithFormat:@"%@",self.detailModel.marea.areaName];
            self.areaid = self.detailModel.marea.areaId;
        }
 
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
}

/**保存编辑接口*/
- (void)getdataSaveOrEdit{
    
    NSString * userid ;
    if ([UserAccountManager shareUserAccountManager].loginStatus) {//登陆
        userid = kUserId;
    }else {
        userid = [UserAccountManager shareUserAccountManager].cartUserID;
    }
    NSString *telPhoneNum = self.phoneTF.text;
    NSDictionary * parms = @{@"area_id":self.areaid?:@"",@"user_id":userid,@"area_info":self.detailTV.text,@"trueName":self.nameTF.text,@"telephone":telPhoneNum,@"mobile":telPhoneNum,@"defaultAddress":self.isDefault,@"zip":self.postTF.text,@"id":self.model.adressId?:@""};
    
    __weak typeof(self) weakself = self;
    [NetWork PostNetWorkWithUrl:UserAdressSaveListAction with:parms successBlock:^(NSDictionary *dic)
    {
        
        if ([UserAccountManager shareUserAccountManager].loginStatus) {//登陆
            [self backToPresentViewController];

        }else {//游客保存
            AddressModel *adrModel = [AddressModel mj_objectWithKeyValues:dic[@"data"]];
            
            if (weakself.block)
            {
                self.testModel = adrModel;
            [UserAccountManager shareUserAccountManager].cartUserAddress = adrModel.adressId;
            }
            [self backToPresentViewController];

        }

        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
}
/**根据邮编获取区域信息 // 邮编zip  countryId 2 文莱 1 马来 3 新加坡*/
-(void)getdataAreaInfoByZipWith:(CountryType)countryId zip:(NSString *)zip{
    [HUDManager showLoadingHUDView:self.view];
    NSDictionary * parms = @{@"country":@(countryId),@"zip":zip};
    
    [NetWork PostNetWorkWithUrl:UserAdressByeZipAction with:parms successBlock:^(NSDictionary *dic) {
        
        self.areainfoModel = [AdressAreaModel mj_objectWithKeyValues:dic[@"data"]];
        if (self.countryId == CountryTypeBrunei) {//文莱 三级
            if (self.areainfoModel.childMArea == nil) {
               self.areaTF.text =[NSString stringWithFormat:@"%@",self.areainfoModel.areaName];
                self.areaid = self.areainfoModel.areaId;

            }else {
                AdressAreaModel *model2 =self.areainfoModel.childMArea;
                if (model2.childMArea == nil) {
                    self.areaTF.text =[NSString stringWithFormat:@"%@,%@",model2.areaName,self.areainfoModel.areaName];
                    self.areaid = model2.areaId;

                }else{
                    AdressAreaModel *model3 = model2.childMArea;
                    self.areaTF.text =[NSString stringWithFormat:@"%@,%@,%@",model3.areaName,model2.areaName,self.areainfoModel.areaName];
                    self.areaid = model3.areaId;

                }
            }
//            AdressAreaModel *model2 =self.areainfoModel.childMArea;
//            AdressAreaModel *model3 = model2.childMArea;
//            self.areaTF.text =[NSString stringWithFormat:@"%@-%@-%@",self.areainfoModel.areaName,model2.areaName,model3.areaName];
//            self.areaid = model3.areaId;
        }else {
            
            
            if (self.areainfoModel.childMArea == nil) {
                self.areaTF.text =[NSString stringWithFormat:@"%@",self.areainfoModel.areaName];
                self.areaid = self.areainfoModel.areaId;
                
            }else {
                AdressAreaModel *model2 =self.areainfoModel.childMArea;
                self.areaTF.text =[NSString stringWithFormat:@"%@,%@",model2.areaName,self.areainfoModel.areaName];
                self.areaid = model2.areaId;
            }

            
            
//            AdressAreaModel *model2 =self.areainfoModel.childMArea;
//            self.areaTF.text =[NSString stringWithFormat:@"%@-%@",self.areainfoModel.areaName,model2.areaName];
//            self.areaid = model2.areaId;
        }
        
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg];
        self.areaTF.text = @"";
        self.areaid = @"";
    } errorBlock:^(NSError *error) {
        
    }];
}

#pragma mark - private methods
- (BOOL)dataCheck{
    
    if ([self.nameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length ==0) {
        [HUDManager showWarningWithText:@"请输入收货人"];
        return NO;
    }
    
    if (self.phoneTF.text.length ==0) {
        [HUDManager showWarningWithText:@"请填写联系电话"];
        return NO;
    }
    if (self.phoneTF.text.length != 11 || ![NSString textFieldreplacementString:self.phoneTF.text]) {
        [HUDManager showWarningWithText:@"请输入正确的手机号"];
        return NO;
    }
    
    if ([self.postTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        [HUDManager showWarningWithText:@"请填写邮编"];
        return NO;
    }
    if ([self.postTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 6 || ![NSString textFieldreplacementString:self.postTF.text]) {
        [HUDManager showWarningWithText:@"请填写6位数字邮编"];
        return NO;
    }
    
    if (self.detailTV.text.length > 50 || self.detailTV.text.length < 1) {
        [HUDManager showWarningWithText:@"请填写详细地址,1-50个字符"];
        return NO;
    }
    
    if (self.nameTF.text.length < 2 ||self.nameTF.text.length > 25) {
        [HUDManager showWarningWithText:@"收货人应该是2-25位字符"];
        return NO;
    }
    if (self.areaid == nil || [self.areaid isEqualToString:@""]) {
        [HUDManager showWarningWithText:@"请选择地区"];
        return NO;
    }
    
//    if (![NSString textFieldNOChinese:self.detailTV.text]) {
//        [HUDManager showWarningWithText:LaguageControl(@"请输入英文地址")];
//        return NO;
//    }
//    if (![NSString textFieldNOChinese:self.nameTF.text]) {
//        [HUDManager showWarningWithText:LaguageControl(@"请输入英文名称")];
//        return NO;
//    }
    return YES;
}


@end
