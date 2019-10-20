//
//  ShopDetialViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShopDetialViewController.h"
#import "NSString+StoreType.h"
#import "HeadTableViewCell.h"
#import "StoreDeitalTableViewCell.h"
#import "PayAttentNetWork.h"
#import "FootTableViewCell.h"
#import "AttentShopModel.h"
#import "StationMessageChatViewController.h"
#import "LoginViewController.h"

@interface ShopDetialViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 店铺详情 */
@property (weak, nonatomic) IBOutlet UITableView *shopDetialTabelView;
/** 店铺 */
@property(strong,nonatomic) NSArray * dataArray;
/**  */
@end

@implementation ShopDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LaguageControl(@"店铺详情");
    self.dataArray = @[@"店铺名称"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        HeadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HeadTableViewCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"HeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"HeadTableViewCell"];
            cell =[tableView dequeueReusableCellWithIdentifier:@"HeadTableViewCell"];
        }
        cell.shopTitleLabel.text = self.storeModel.store_name;
        [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:self.storeModel.store_logo] placeholderImage:[UIImage imageNamed:@"defaultImgbanner"]];
        cell.attmentNumberLabel.text = self.storeModel.favorite_count;
        cell.attentButton.selected = [self.storeModel.favorite boolValue];
        [cell.attentButton addTarget:self action:@selector(attenButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (indexPath.section==1)
    {
        StoreDeitalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoreDeitalTableViewCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"StoreDeitalTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoreDeitalTableViewCell"];
            cell =[tableView dequeueReusableCellWithIdentifier:@"StoreDeitalTableViewCell"];
        }
        cell.nameLabel.text = LaguageControlAppend(self.dataArray[indexPath.row]);
        switch (indexPath.row)
        {
                

            case 0:
                cell.detialLabel.text =self.storeModel.store_name;
                break;
            case 1:
                cell.detialLabel.text =self.storeModel.gradeName;

                break;
            case 2:
                cell.detialLabel.text =[NSString StoreType:[self.storeModel.storeType integerValue]];
                break;
            default:
                break;
        }
        return cell;
    }
    else
    {
        FootTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FootTableViewCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"FootTableViewCell" bundle:nil] forCellReuseIdentifier:@"FootTableViewCell"];
            cell =[tableView dequeueReusableCellWithIdentifier:@"FootTableViewCell"];
        }
        [cell LoadModel:self.storeModel];
        [cell.connectSeverButton addTarget:self action:@selector(connectServers) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

}
-(void)connectServers
{
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        if ([self.storeModel.store_userId isEqualToString:kUserId])
        {
            [HUDManager showWarningWithText:@"你不能和自己聊天"];
            return;
        }
        {
            StationMessageChatViewController * view = [StationMessageChatViewController new];
            view.type = @"0";
            view.toUserID = self.storeModel.store_userId;
            view.title =self.storeModel.store_userName;
            [self.navigationController pushViewController:view animated:YES];
        }
    }
    else
    {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *nav = loginStoryBoard.instantiateInitialViewController;
        LoginViewController * view = (LoginViewController*)nav.topViewController;
        [view getisToturBuy:^(BOOL isBuy) {
            
        }];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;
    }
    else if (indexPath.section==1)
    {
        return 40;
    }
    else
    {
        return 200;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section)
    {
        return 0.1;
    }
    else{
        return 10;
    }
}
-(void)attenButtonClicked:(UIButton*)button
{
    if ([self.storeModel.store_userId isEqualToString:kUserId])
    {
        [HUDManager showWarningWithText:@"不能关注自己的店铺"];
        return;
    }
    if (button.selected) {
        [PayAttentNetWork CancelPayAttentNetWorkisGoods:NO withtypeid:self.storeModel.attentshopID Success:^(BOOL success) {
            button.selected = NO;
            self.storeModel.favorite_count = [[NSNumber numberWithInteger:[self.storeModel.favorite_count integerValue]-1] stringValue];
            self.storeModel.favorite = @"0";
            [self.shopDetialTabelView reloadData];

        }] ;
    }
    else
    {
        [PayAttentNetWork PayAttentNetWorkisGoods:NO withtypeid:self.storeModel.attentshopID Success:^(BOOL success) {
            button.selected = YES;
            self.storeModel.favorite_count = [[NSNumber numberWithInteger:[self.storeModel.favorite_count integerValue]+1] stringValue];
            self.storeModel.favorite = @"1";
            [self.shopDetialTabelView reloadData];
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation
 before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
