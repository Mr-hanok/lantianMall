//
//  BuyAndSendDetialViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyAndSendDetialViewController.h"
#import "BuyAndSendAddressTableViewCell.h"
#import "BuyAndSendGoodsTableViewCell.h"
#import "BuyAndSendSizeTableViewCell.h"
#import "BuyAndSendCostTableViewCell.h"
#import "ShoppingCostDetialsView.h"
#import "MywalletViewController.h"
#import "BuyAndSendTouristsTableViewCell.h"

static NSString * AddressCellIdentifier = @"BuyAndSendAddressTableViewCell";
static NSString * TouristsAddressCellIdentifier = @"BuyAndSendTouristsTableViewCell";
static NSString * GoodsCellIdentifier = @"BuyAndSendGoodsTableViewCell";
static NSString * ConstCellIdentifier = @"BuyAndSendCostTableViewCell";
static NSString * SizeCellIdentifier = @"BuyAndSendSizeTableViewCell";


@interface BuyAndSendDetialViewController ()<UITableViewDelegate,UITableViewDataSource,BuyAndSendCostTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *buyAndSendConfirmTableView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *placeOrderButton;


@end

@implementation BuyAndSendDetialViewController
{
    ShoppingCostDetialsView * shoppingCostDetialsView;
    BOOL isShow ;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    isShow = YES;
    self.placeOrderButton.backgroundColor = KAppRootNaVigationColor;
    self.title = [LaguageControl languageWithString:@"Determine order"];
    self.buyAndSendConfirmTableView.delegate = self;
    self.buyAndSendConfirmTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)placeOrderButtonClicked:(UIButton *)sender
{
    MywalletViewController * view = [[MywalletViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}


#pragma mark--UITableViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 2;
    }
    else{
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0){
        if (isShow) {
            BuyAndSendTouristsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TouristsAddressCellIdentifier];
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:TouristsAddressCellIdentifier bundle:nil] forCellReuseIdentifier:TouristsAddressCellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:TouristsAddressCellIdentifier];
            }
            return cell;
        }
        else{
            BuyAndSendAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:AddressCellIdentifier bundle:nil] forCellReuseIdentifier:AddressCellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
            }
            return cell;
        }

    }
    else if (indexPath.section==1)
    {
        BuyAndSendGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsCellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:GoodsCellIdentifier bundle:nil] forCellReuseIdentifier:GoodsCellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:GoodsCellIdentifier];
        }
        cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.contentView.layer.borderWidth = 1;
        return cell;
        
    }
    else if (indexPath.section==2)
    {
        BuyAndSendSizeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SizeCellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:SizeCellIdentifier bundle:nil] forCellReuseIdentifier:SizeCellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:SizeCellIdentifier];
        }
        cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.contentView.layer.borderWidth = 1;
        return cell;
        
    }
    else
    {
        BuyAndSendCostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ConstCellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:ConstCellIdentifier bundle:nil] forCellReuseIdentifier:ConstCellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:ConstCellIdentifier];
        }
        cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.contentView.layer.borderWidth = 1;
        cell.delegate = self;
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (isShow) {
            return 60;
        }
        else{
            return 180;
        }
    }
    else if (indexPath.section==1)
    {
        return 150;
    }
    else if (indexPath.section==2){
        return 50;
    }
    else{
        return 130;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

#pragma mark -- BuyAndSendCostTableViewCellDelegate
-(void)BuyAndSendCostTableShowCostButtonClicked:(TaxTypes)type{
    //    if (!shoppingCostDetialsView) {
    //        shoppingCostDetialsView = [ShoppingCostDetialsView loadView];
    //    }
    //    if (shoppingCostDetialsView.isShow) {
    //        [shoppingCostDetialsView viewDissMissFromWindow];
    //    }
    //    else{
    //        [shoppingCostDetialsView showView];
    //    }
    //
}




@end
