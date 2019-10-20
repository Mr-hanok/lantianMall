//
//  ComplaintsViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  投诉

#import "ComplaintsViewController.h"
#import "ComplaintGoodsCell.h"
#import "ComplaintsContentCell.h"
#import "ComplaintItemsView.h"
#import "CameraTakeMamanger.h"
#import "PhotoInfoModel.h"
#import "BuyerOrderModel.h"
static NSString * ComplaintGoodsCellId = @"ComplaintGoodsCell";
static NSString * ComplaintsContentCellId = @"ComplaintsContentCell";
static NSString * ShootingPhotoCellId = @"ShootingPhotoCell";
@interface ComplaintsViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ComplaintsContentCellDelegate,ShootingPhotoCellDelegate>

@property (nonatomic , weak) UITableView * complaintsTabelView;
@property (nonatomic , weak) ComplaintsContentCell * contentCell;
@property (nonatomic , weak) ComplaintGoodsCell * describeCell;
@property (nonatomic , weak) ShootingPhotoCell * photoCell;
@property (nonatomic , weak) UIBarButtonItem * commit;

@end
@implementation ComplaintsViewController
{
    NSString * _complaintsContent;
    NSString * _complaintsDescribe;
    NSArray <ComplaintSubjectItemModel *> *_complaintSubjectItems;
}
#pragma mark - lift cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.complaintsTabelView reloadData];
    self.commit.tintColor = kIsChiHuoApp ? kTextDeepDarkColor : [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"投诉"];
}
/**
 *  点击提交
 */
- (void)clickCommot
{
    if(_contentCell.subjectTitle.length == 0 || _complaintsContent.length == 0)
    {
        [HUDManager showWarningWithText:@"请完善信息"];
        return;
    }
    self.commit.enabled = NO;
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍候"];
    /**
     *  首先上传图片，接着再上传投诉信息
     */
    if([_photoCell allImages].count)
    {
    [self loadImageWithBlock:^(NSArray *imageInfoModel) {
        if(!imageInfoModel)
        {
            [HUDManager hideHUDView];
            [HUDManager showWarningWithText:@"图片上传失败"];
            return;
        }
        [self launchComplaintWithPhotoInfo:imageInfoModel];
    }];
    }else
    {
        [self launchComplaintWithPhotoInfo:nil];
    }
    
}
- (void)launchComplaintWithPhotoInfo:(NSArray *)array
{
    NSMutableArray * tempArr = [@[] mutableCopy];
    tempArr = [array valueForKeyPath:@"photoID"];
    NSArray * describeArr = [_describeCell.contentArray valueForKeyPath:@"contentString"];
    NSString * photoId = [tempArr componentsJoinedByString:@","];
    NSString * describeString = [describeArr componentsJoinedByString:@","];
    [NetWork PostNetWorkWithUrl:@"/buyer/save_complaint" with:@{@"user_id":kUserId,@"of_id":_buyerOrder.buyoderid,@"store_id":_buyerOrder.store_id,@"goods_id":describeString,@"title":_complaintSubjectItems[_contentCell.subjectRow].itemId,@"content":_complaintsContent,@"photo":photoId?photoId:@"",@"type":_buyer?@(1):@(2)} successBlock:^(NSDictionary *dic) {
        [HUDManager showWarningWithText:@"发起投诉成功"];
        self.commit.enabled = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
    } FailureBlock:^(NSString *msg) {
        self.commit.enabled = YES;
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        self.commit.enabled = YES;
        [HUDManager showWarningWithError:error];
    }];
}
/**
 *  上传图片并返回
 *
 *  @return <#return value description#>
 */
- (NSArray *)loadImageWithBlock:(imageLoadCompleteBlock)block
{
    __block NSArray * imageArray = nil;
    [NetWork PostUpLoadImageWithImages:[_photoCell allImages] successBlock:^(NSArray<PhotoInfoModel *> *photoInfoArray) {
        imageArray = [photoInfoArray copy];
        block(imageArray);
    } FailureBlock:^(NSString *msg) {
        block(nil);
    } errorBlock:^(id error) {
        block(nil);
    }];
    return imageArray;
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        ComplaintGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintGoodsCellId];
        cell.buyerOrder = _buyerOrder;
        cell.goodsModel = _goodsModels;
        _describeCell = cell;
        return cell;
    }
    if(indexPath.row == 1)
    {
        ComplaintsContentCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintsContentCellId];
        cell.delegate = self;
        return cell;
    }
    ShootingPhotoCell * cell = [tableView dequeueReusableCellWithIdentifier:ShootingPhotoCellId];
    cell.delegate = self;
    return cell;
}

#pragma mark - other Delegate
- (void)complaintsSubjectSelectWithCell:(ComplaintsContentCell *)cell
{
    [self.view endEditing:YES];
    _contentCell = cell;
    if(_complaintSubjectItems)
    {
        ComplaintItemsView * view = [[ComplaintItemsView alloc] initWithTitles:[_complaintSubjectItems valueForKeyPath:@"title"]];
        view.delegate = cell;
        [view displayToWindow];
    }else
    {
        [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
        [NetWork PostNetWorkWithUrl:@"/buyer/complaint_title" with:@{@"currentPage":@(1),@"type":_buyer?@(0):@(1)} successBlock:^(NSDictionary *dic) {
            _complaintSubjectItems = [ComplaintSubjectItemModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"result"]];
            ComplaintItemsView * view = [[ComplaintItemsView alloc] initWithTitles:[_complaintSubjectItems valueForKeyPath:@"title"]];
            view.delegate = cell;
            [view displayToWindow];
        } FailureBlock:^(NSString *msg) {
            [HUDManager showWarningWithText:msg];
        } errorBlock:^(id error) {
            [HUDManager showWarningWithError:error];
        }];
    }

}
- (void)complaintDescribeWithDescribe:(NSString *)describe
{
    _complaintsDescribe = describe;
}
- (void)complaintContentWithContent:(NSString *)content
{
    _complaintsContent = content;
}
- (void)shootPhoto:(ShootingPhotoCell *)cell tag:(NSInteger)tag residual:(NSInteger)residual
{
    _photoCell = cell;
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:/*[NSString stringWithFormat:@"您可以上传%ld张图片",(long)residual]*/nil delegate:self cancelButtonTitle:LaguageControl(@"取消") destructiveButtonTitle:LaguageControl(@"拍照") otherButtonTitles:LaguageControl(@"相册"), nil];
    [sheet showInView:self.view];
    [_photoCell resignFirstResponder];

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    if(!buttonIndex)
    {// 相机
    [self localCamera];
    }else
    {// 相册

        [[CameraTakeMamanger sharedInstance] imageWithPhotoInController:self handler:^(UIImage *image, NSString *imagePath) {
            [_photoCell setPhotoImage:image];

        } cancelHandler:^{
            
        }];
    }
}


- (void)localCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [HUDManager showWarningWithText:@"相机不可用"];
        return;
    }
    [[CameraTakeMamanger sharedInstance]imageWithCameraInController:self handler:^(UIImage *image, NSString *imagePath) {
        [_photoCell setPhotoImage:image];
    } cancelHandler:^{
        
    }];
}
#pragma mark - setter and getter
- (UITableView *)complaintsTabelView
{
    if(!_complaintsTabelView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        [tableview registerClass:[ComplaintGoodsCell class] forCellReuseIdentifier:ComplaintGoodsCellId];
        [tableview registerClass:[ComplaintsContentCell class] forCellReuseIdentifier:ComplaintsContentCellId];
        [tableview registerClass:[ShootingPhotoCell class] forCellReuseIdentifier:ShootingPhotoCellId];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.estimatedRowHeight = 100;
        [self.view addSubview:tableview];
        _complaintsTabelView = tableview;
        [_complaintsTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    return _complaintsTabelView;
}
- (UIBarButtonItem *)commit
{
    if(!_commit)
    {
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:[LaguageControl languageWithString:@"提交"] style:UIBarButtonItemStylePlain target:self action:@selector(clickCommot)];
        self.navigationItem.rightBarButtonItem = item;
        _commit = item;
    }
    return _commit;
    
}
@end


@implementation ComplaintSubjectItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"itemId":@"id"};
}

@end
