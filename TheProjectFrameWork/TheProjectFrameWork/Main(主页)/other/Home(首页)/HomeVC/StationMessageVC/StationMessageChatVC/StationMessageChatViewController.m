//
//  StationMessageChatViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "StationMessageChatViewController.h"
#import "MessageTableViewCellTypeText.h"
#import "StationMessageChatTableViewCell.h"
#import "StationChatModel.h"

static NSString * cellTextIdentifier = @"MessageTableViewCellTypeText";
static NSString * CellMeIdentifier = @"StationMessageChatTableViewCell";



@interface StationMessageChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *speackTextField;
@property (weak, nonatomic) IBOutlet UIButton *speackButton;
@property(assign,nonatomic) NSInteger  begin;
@property (weak, nonatomic) IBOutlet UITableView *stationtableView;

/** 数据源 */
@property(strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation StationMessageChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self.speackButton setTitle:LaguageControl(@"发言") forState:UIControlStateNormal];
    self.speackTextField.placeholder = LaguageControl(@"说句话吧");
    [self updataNewData:self.stationtableView];
    self.stationtableView.sectionHeaderHeight = CGFLOAT_MIN;
    self.stationtableView.sectionFooterHeight = CGFLOAT_MIN;

    self.speackButton.layer.masksToBounds = YES;
    self.speackTextField.delegate = self;
    self.speackButton.layer.cornerRadius = 5;
        [self NetWork];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)updateHeadView
{
    [self NetWork];
}
- (void)updateFootView{
    [self NetWork];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)speackButtonClicked:(UIButton *)sender
{
    if (self.speackTextField.text.length)
    {
        [self SpeackNetWork];
    }
    else
    {
        [HUDManager showWarningWithText:@"请输入内容"];
        
    }
    
}

/** 发言 */
-(void)SpeackNetWork
{
    NSString * type =@"";
    if (self.type)
    {
        type = self.type;
    }
    [HUDManager showLoadingHUDView:self.view];
    NSDictionary * dic = @{@"fromUser":kUserId,
                           @"toUser":self.toUserID,
                           @"content":self.speackTextField.text,};
    [NetWork PostNetWorkWithUrl:@"/system/NewSendMessage" with:dic successBlock:^(NSDictionary *dic)
    {
        if ([dic[@"status"] boolValue]) {
            self.speackTextField.text = nil;
            [self NetWork];
        }
        else
        {
            [HUDManager showWarningWithText:[NSString stringWithFormat:@"%@",dic[@"message"]]];
        }
    } errorBlock:^(NSString *error)
     {
         [HUDManager hideHUDView];
         [HUDManager showWarningWithText:error];
    }];
    
}
/** 获取列表 */
-(void)NetWork
{
    if (!self.toUserID)
    {
        return;
    }
    NSDictionary * dic =@{@"fromUserId":kUserId,
                              @"toUserId":self.toUserID,
                          @"user_id":kUserId
                             };
    [HUDManager showLoadingHUDView:self.view];
        [NetWork PostNetWorkWithUrl:@"/system/message_detail" with:dic successBlock:^(NSDictionary *dic)
         {
             [self.stationtableView.mj_header endRefreshing];
             [self.stationtableView.mj_footer endRefreshing];

             [HUDManager hideHUDView];
             [self.dataArray removeAllObjects];
             if ([dic[@"status"] boolValue])
             {
                 NSArray * array = [StationChatModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                 [self.dataArray addObjectsFromArray:array];
                [self.stationtableView reloadData];
                     if (self.dataArray.count)
                     {
                         [self.stationtableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                     }

             }
             
         } errorBlock:^(NSString *error) {
             [self.stationtableView.mj_header endRefreshing];
             [self.stationtableView.mj_footer endRefreshing];
             [HUDManager hideHUDView];
             [HUDManager showWarningWithText:error];
         }];
}
    


#pragma mark --UITableViewDelegate&&UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StationChatModel * model = self.dataArray[indexPath.row];
    BOOL isSend = YES;
    if ([kUserId isEqualToString:model.fromUserId])
    {
        isSend = NO;
    }
    if (isSend)
    {
        MessageTableViewCellTypeText * cell = [tableView dequeueReusableCellWithIdentifier:cellTextIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:cellTextIdentifier bundle:nil] forCellReuseIdentifier:cellTextIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextIdentifier];
        }
        cell.timeLabel.text = model.addTime;
        [cell loadString:model.content];
        return cell;
    }
    else
    {
        StationMessageChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellMeIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:CellMeIdentifier bundle:nil] forCellReuseIdentifier:CellMeIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellMeIdentifier];
        }
        cell.timeLabel.text = model.addTime;
        [cell loadString:model.content];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StationChatModel * model = self.dataArray[indexPath.row];
    CGSize size = [NSString sizeWithString:model.content font:KSystemFont(17) maxHeight:1000 maxWeight:KScreenBoundWidth-80];
    return size.height+80;
}

#pragma makr -UITextFieldDelegate --关于表情的部分处理！！！

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.textInputMode.primaryLanguage == NULL ||[textField.textInputMode.primaryLanguage isEqualToString:@"emoji"])
    {
        return NO;
    }
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
