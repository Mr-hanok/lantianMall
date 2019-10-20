//
//  ComplaintDetailedViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ComplaintDetailedViewController.h"
#import "ComplaintGoodsCell.h"
#import "PublishMessageView.h"
#import "CameraTakeMamanger.h"
#import "IQKeyboardManager.h"
#import "ComplaintDetailedViewModel.h"
#import "UIImage+Compression.h"
#import "ComplaintModel.h"
#import "GoodsDetialViewController.h"
static NSString * ComplaintGoodsCellId = @"ComplaintGoodsCell";
static NSString * ComplaintDescribeCellId = @"ComplaintDescribeCell";
static NSString * ComplaintStateCellId = @"ComplaintStateCell";
static NSString * FillComplaintInfoCellId = @"FillComplaintInfoCell";
static NSString * AppealInfoCellId = @"AppealInfoCell";
static NSString * DialogueDetailsCellId = @"DialogueDetailsCell";
static NSString * ArbitrationInfoCellId = @"ArbitrationInfoCell";

@interface ComplaintDetailedViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,FillComplaintInfoCellDelegate,DialogueDetailsCellDelegate,PublishMessageViewDelegate,ComplaintGoodsCellDelegate>


@property (nonatomic , weak) UIView * cancelComplaint;
@property (nonatomic , weak) UITableView * detailedTableView;
@property (nonatomic , weak) PublishMessageView * publishTextView;

@property (nonatomic , strong) UIBarButtonItem * submit;
@property (nonatomic , strong) ComplaintDetailedViewModel * viewModel;

@end
@implementation ComplaintDetailedViewController
{
    FillComplaintInfoCell * _photoCell;
    NSString * appealContent;
}
#pragma mark - life cycle
- (void)viewDidLoad
{
    _complaintModel.status = ComplaintManagerUnknown;
    [super viewDidLoad];
    [self updataHeader:self.detailedTableView];
    [self.header beginRefreshing];
}
- (void)updateHeadView
{
    [self.viewModel getComplaintDetailedWithID:_complaintId CompleteHandle:^(id error) {
        [self.header endRefreshing];
        if(!error)
        {
            _complaintModel.status = _viewModel.model.status;
            if(_complaintModel.status == ComplaintManagerWaitComplaint && [self userIsEqualFromUser])
            {
                self.submit.tintColor = [UIColor whiteColor];
            }
            if(![self userIsEqualFromUser])
            {
                self.cancelComplaint.backgroundColor = [UIColor colorWithString:@"#ECECEC"];
            }
        }
        [HUDManager showWarningWithError:error];
        [self.detailedTableView reloadData];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"投诉详情");
}
#pragma mark - tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.complaintModel.status == ComplaintManagerUnknown)
    {
        return 0;
    }
    switch (_complaintModel.status) {
            /**
             *  新投诉
             */
        case ComplaintManagerNew:
            return 3;
            break;
            /**
             *  已完成
             */
        case ComplaintManagerFinish:
            return 6;
            break;
            /**
             *  对话中
             */
        case ComplaintManagerDialogue:
            /**
             *  待仲裁
             */
        case ComplaintManagerWaitArbitrate:

            return 5;
            break;
            /**
             *  待申诉
             */
        case ComplaintManagerWaitComplaint:
        {
            if(![self userIsEqualFromUser])
            {
                return 3;
            }else
            {
                return 4;
            }
        }
            break;
        default:
            break;
    }
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        ComplaintGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintGoodsCellId];
        cell.model = self.viewModel.model;
        cell.delegate = self;
        return cell;
    }if(indexPath.row == 1)
    {
        ComplaintDescribeCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintDescribeCellId];
        cell.model = self.viewModel.model;
        return cell;
    }
    /*****************************************/
    switch (_complaintModel.status) {
            /**
             *  新投诉
             */
        case ComplaintManagerNew:
        {
            ComplaintStateCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintStateCellId];
            cell.model = self.viewModel.model;
            return cell;
        }
            break;
            /**
             *  已完成
             */
        case ComplaintManagerFinish:
        {
            if(indexPath.row == 2)
            {
                ComplaintStateCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintStateCellId];
                cell.model = self.viewModel.model;
                return cell;
            }
            if(indexPath.row == 3)
            {
                AppealInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:AppealInfoCellId];
                cell.model = self.viewModel.model;
                return cell;
            }
            if(indexPath.row == 4)
            {
                DialogueDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:DialogueDetailsCellId];
                cell.delegate = self;
                cell.isFinish = YES;
                cell.model = self.viewModel.model;
                return cell;
            }
            if(indexPath.row == 5)
            {
                ArbitrationInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:ArbitrationInfoCellId];
                cell.model = self.viewModel.model;
                return cell;
            }
        }
            break;
            /**
             *  对话中
             */
        case ComplaintManagerDialogue:
            if(indexPath.row == 4)
            {
                DialogueDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:DialogueDetailsCellId];
                cell.delegate = self;
                cell.isFinish = NO;
                cell.model = self.viewModel.model;
                return cell;
            }
            /**
             *  待仲裁
             */
        case ComplaintManagerWaitArbitrate:
        {
            if(indexPath.row == 2)
            {
                ComplaintStateCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintStateCellId];
                cell.model = self.viewModel.model;
                return cell;
            }
            if(indexPath.row == 3)
            {
                AppealInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:AppealInfoCellId];
                cell.model = self.viewModel.model;
                return cell;
            }
            if(indexPath.row == 4)
            {
                DialogueDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:DialogueDetailsCellId];
                cell.delegate = self;
                cell.model = self.viewModel.model;
                cell.isFinish = NO;
                return cell;
            }
        }
            break;
            /**
             *  待申诉
             */
        case ComplaintManagerWaitComplaint:
        {
            if(indexPath.row == 2)
            {
                ComplaintStateCell * cell = [tableView dequeueReusableCellWithIdentifier:ComplaintStateCellId];
                cell.model = self.viewModel.model;
                return cell;
            }
            if(indexPath.row == 3)
            {
                FillComplaintInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:FillComplaintInfoCellId];
                cell.delegate = self;
                _photoCell = cell;
                return cell;
            }
        }
            break;
        default:
            return nil;
            break;
    }
  return nil;
   
}

/**
 *  待申诉提交
 */
- (void)appealSubmit
{
    if(!appealContent || appealContent.length == 0)
    {
        [HUDManager showWarningWithError:@"请完善信息"];
        return;
    }
    [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
    [self.viewModel appealSubmitWithImages:[_photoCell allImages] content:appealContent completeHandle:^(id error) {
        [HUDManager hideHUDView];
        if(!error)
        {
            [HUDManager showWarningWithText:@"提交成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [HUDManager showWarningWithError:error];

        }
    }];
 
}

- (void)cancelComplaintEvent
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:LaguageControl(@"提示") message:LaguageControl(@"是否取消投诉") delegate:self cancelButtonTitle:LaguageControl(@"取消") otherButtonTitles:LaguageControl(@"确定"), nil];
    alert.tag = 100;
    [alert show];
}
#pragma cells Delegate Method
- (void)fillComplaintWithCell:(FillComplaintInfoCell *)cell tag:(NSInteger)tag residual:(NSInteger)residual
{
    _photoCell = cell;
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:LaguageControl(@"您可以上传图片") delegate:self cancelButtonTitle:LaguageControl(@"取消") destructiveButtonTitle:LaguageControl(@"相机") otherButtonTitles:LaguageControl(@"相册"), nil];
    [sheet showInView:self.view];
}
- (void)fillComplaintWithCell:(FillComplaintInfoCell *)cell appealContent:(NSString *)content
{
    _photoCell = cell;
    appealContent = content;
}
/**
 *  发布对话
 *
 *  @param cell <#cell description#>
 */
- (void)dialogueDetailsPublishWithCell:(DialogueDetailsCell *)cell
{
    [self.publishTextView.textField becomeFirstResponder];
}
/**
 *  刷新对话
 *
 *  @param cell <#cell description#>
 */
- (void)dialogueDetailsReloadWithCell:(DialogueDetailsCell *)cell
{
    [HUDManager  showLoadingHUDView:self.view withText:@"请稍候"];
    [self.viewModel updateDialogueCompleteHandle:^(NSArray *array, id error) {
        if(error)
        {
            [HUDManager hideHUDView];
 
            [HUDManager showWarningWithError:error];
            
        }else
        {
            [cell reloadChatRecordWithArr:array];
        }
    }];
}
/**
 *  提交仲裁
 *
 *  @param cell <#cell description#>
 */
- (void)dialogueDetailsSubmitWithCell:(DialogueDetailsCell *)cell
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:LaguageControl(@"提示") message:LaguageControl(@"是否提交仲裁") delegate:self cancelButtonTitle:LaguageControl(@"取消") otherButtonTitles:LaguageControl(@"确定"), nil];
    alert.tag = 101;
    [alert show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.cancelButtonIndex == buttonIndex)
    {
        return;
    }
    if(alertView.tag == 100)
    {
        [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];

        [self.viewModel cancelComplaintWithCompleted:^(id error) {
            [HUDManager hideHUDView];
            if(error)
            {
                [HUDManager showWarningWithError:error];

            }else
            {
                [HUDManager showWarningWithText:@"取消投诉成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }else
    {
        [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
        [self.viewModel submitArbitrationCompleteHandle:^(id error) {
            [HUDManager hideHUDView];
            if(!error)
            {
                [HUDManager showWarningWithText:@"提交仲裁成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else
            {
                [HUDManager showWarningWithError:error];
            }
        }];
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == actionSheet.cancelButtonIndex) return;
    if(!buttonIndex)
    {// 相机
        [self complaintCamera];
    }else
    {// 相册
        
        [[CameraTakeMamanger sharedInstance] imageWithPhotoInController:self handler:^(UIImage *image, NSString *imagePath) {
            [_photoCell setPhotoImage:image];
        } cancelHandler:^{
            
        }];
       
    }
}

- (void)complaintCamera
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

#pragma mark - 对话相关
- (void)networkPublish
{
    if(_publishTextView.textField.text.length == 0)
    {
        return;
    }
    [self.viewModel publishDialogueWithContent:_publishTextView.textField.text CompleteHandle:^(id error) {
      [HUDManager hideHUDView];
      if(error)
      {
          [HUDManager showWarningWithError:error];

      }else
      {
          [HUDManager showWarningWithText:@"发布对话成功"];
      }
    }];
}


#pragma mark - NSNotificationCenter Method
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyBoardHeight = keyboardRect.size.height;
    __weak typeof(self) weakSelf = self;
    [_publishTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.height.mas_greaterThanOrEqualTo(kScaleHeight(48));
        make.height.mas_lessThanOrEqualTo(kScaleHeight(120));
        make.bottom.equalTo(weakSelf.view.mas_bottom).mas_offset(-keyBoardHeight);
    }];
    [UIView animateWithDuration:0.1f animations:^{
        [self.view layoutIfNeeded];
        _publishTextView.alpha = 1;
    }];
    
}
-(void)pulishMessageComplete:(NSString *)text
{
    [self networkPublish];
    [_publishTextView removeFromSuperview];
}

/**
 *
 *  点击商品
 */
- (void)complaintGoodsCellClick:(ComplaintGoodsCell *)cell good_id:(NSString *)good_id
{
    GoodsDetialViewController * controller = [[GoodsDetialViewController alloc] init];
    controller.goodsModelID = good_id;
    [self.navigationController pushViewController:controller animated:YES];
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    [_publishTextView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyBoardWillChangFrame:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyBoardHeight = keyboardRect.size.height;
    __weak typeof(self) weakSelf = self;
    [_publishTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.height.mas_greaterThanOrEqualTo(kScaleHeight(48));
        make.height.mas_lessThanOrEqualTo(kScaleHeight(120));
        make.bottom.equalTo(weakSelf.view.mas_bottom).mas_offset(-keyBoardHeight);
    }];
    [UIView animateWithDuration:0.1f animations:^{
        [self.view layoutIfNeeded];
        _publishTextView.alpha = 1;
    }];
}
#pragma mark - 
/**
 *  比较是否是被投诉人
 *
 *  @return <#return value description#>
 */
- (BOOL)userIsEqualFromUser
{
    return [kUserId isEqualToString:_complaintModel.toUserId];
}
#pragma mark - setter and getter
- (UITableView *)detailedTableView
{
    if(!_detailedTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        tableview.backgroundColor = [UIColor clearColor];
        [tableview registerClass:[ComplaintGoodsCell class] forCellReuseIdentifier:ComplaintGoodsCellId];
        [tableview registerClass:[ComplaintDescribeCell class] forCellReuseIdentifier:ComplaintDescribeCellId];
        [tableview registerClass:[ComplaintStateCell class] forCellReuseIdentifier:ComplaintStateCellId];
        [tableview registerClass:[FillComplaintInfoCell class] forCellReuseIdentifier:FillComplaintInfoCellId];
        [tableview registerClass:[AppealInfoCell class] forCellReuseIdentifier:AppealInfoCellId];
        [tableview registerClass:[DialogueDetailsCell class] forCellReuseIdentifier:DialogueDetailsCellId];
        [tableview registerClass:[ArbitrationInfoCell class] forCellReuseIdentifier:ArbitrationInfoCellId];
        tableview.estimatedRowHeight = 100;
        tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:tableview];
        _detailedTableView = tableview;
        [_detailedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    return _detailedTableView;
}
- (ComplaintDetailedViewModel *)viewModel
{
    if(!_viewModel)
    {
        _viewModel = [[ComplaintDetailedViewModel alloc] init];
    }
    return _viewModel;
}
- (PublishMessageView *)publishTextView
{
    if(!_publishTextView)
    {
        PublishMessageView * view = [[PublishMessageView alloc] init];
        [self.view addSubview:view];
        view.delegate = self;
        __weak typeof(self) weakSelf = self;
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(0);
            make.top.equalTo(weakSelf.view.mas_bottom);
        }];
        view.alpha = 0;
        [self.view layoutIfNeeded];
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        _publishTextView = view;
    }
    return _publishTextView;
}
- (UIBarButtonItem *)submit
{
    if(!_submit)
    {
        _submit = [[UIBarButtonItem alloc] initWithTitle:LaguageControl(@"提交") style:UIBarButtonItemStylePlain target:self action:@selector(appealSubmit)];
        self.navigationItem.rightBarButtonItem = _submit;
    }
    return _submit;
}
- (UIView *)cancelComplaint
{
    if(!_cancelComplaint)
    {
        UIView * view = [[UIView alloc] init];
        [self.view addSubview:view];
        __weak typeof(self) weakSelf = self;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(kScaleHeight(44));
        }];
        [self.detailedTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(weakSelf.view);
            make.bottom.equalTo(view.mas_top);
        }];
        UIButton * sender = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView * line = [UIView new];
        [view addSubview:line];
        [view addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(view.mas_height).multipliedBy(0.7f);
            make.width.mas_equalTo(kScaleWidth(80));
            make.right.equalTo(view.mas_right).mas_offset(-kScaleWidth(20));
            make.centerY.equalTo(view);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.mas_equalTo(0.8f);
        }];
        line.backgroundColor = [UIColor colorWithString:@"#cccccc"];
        sender.backgroundColor = [UIColor whiteColor];
        sender.layer.cornerRadius = 3;
        sender.layer.borderWidth = 0.5f;
        sender.layer.borderColor = [UIColor colorWithString:@"#666666"].CGColor;
        [sender setTitle:LaguageControl(@"取消投诉") forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor colorWithString:@"#666666"] forState:UIControlStateNormal];
        sender.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        [sender addTarget:self action:@selector(cancelComplaintEvent) forControlEvents:UIControlEventTouchUpInside];
        _cancelComplaint = view;
    }
    return _cancelComplaint;
}
@end
