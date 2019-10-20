//
//  PopInformationView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopInformationView.h"
#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>

@interface PopInformationView ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *logisticstableView;
@property(strong,nonatomic) NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentCenter;
@end

@implementation PopInformationView
+(id)loadView{
    
    PopInformationView * view = [super loadView];
    view.dataArray = [NSMutableArray array];
    view.logisticstableView.dataSource = view;
    view.logisticstableView.delegate = view;
    
    view.sendGoodButton.layer.masksToBounds = YES;
    view.sendGoodButton.layer.cornerRadius=3;
    view.sendGoodButton.backgroundColor = KAppRootNaVigationColor;
    
    view.logisticsbackView.layer.masksToBounds = YES;
    view.logisticsbackView.layer.cornerRadius=3;
    view.logisticsbackView.layer.borderWidth=0.5;
    view.logisticsbackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    
    view.OrdernumberbackView.layer.masksToBounds = YES;
    view.OrdernumberbackView.layer.borderWidth=0.5;
    view.OrdernumberbackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    view.contentView.layer.masksToBounds = YES;
    view.contentView.layer.borderWidth=1;
    view.contentView.layer.cornerRadius=10;
    view.contentView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    view.confirmLabel.text = LaguageControl(@"准备发货");
    view.LogisticsCompany.text = LaguageControlAppend(@"物流公司");
    view.LogisticsNumberLabel.text = LaguageControlAppend(@"物流单号");
    if (KScreenBoundWidth>320) {
        view.confirmLabel.font =KSystemFont(11);
        view.LogisticsCompany.font =KSystemFont(11);
        view.LogisticsNumberLabel.font =KSystemFont(11);
        view.logisticsTextField.font =KSystemFont(11);
        view.LogisticsCompanyLabel.font =KSystemFont(11);
    }
    else{
        view.confirmLabel.font =KSystemFont(11);
        view.LogisticsCompany.font =KSystemFont(11);
        view.LogisticsNumberLabel.font =KSystemFont(11);
        view.logisticsTextField.font =KSystemFont(11);
        view.LogisticsCompanyLabel.font =KSystemFont(11);        
    }
    view.logisticsTextField.keyboardType = UIKeyboardTypeNumberPad;
    return view;
}

-(void)showViewWithModel:(NSString *)orderId
{
    if (self.ISChange) {
        self.confirmLabel.text = LaguageControl(@"修改物流");
        [self TheNetWorkwith:orderId];
        
    }
    self.orderID=orderId;
    [self showView];
    [self.dataArray removeAllObjects];

}

-(void)TheNetWorkwith:(NSString*)string;
{
    NSDictionary * dic =@{@"of_id":string};
    [NetWork PostNetWorkWithUrl:@"/getShipInfo" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue]) {
             self.logisticsTextField.text = dic[@"data"][@"orderNum"];
             self.LogisticsCompanyLabel.text =dic[@"data"][@"company"];
             self.company = dic[@"data"][@"id"];
             
         }

     } errorBlock:^(NSString *error) {
         
     }];
}
/** 获取物流公司 */
-(void)NetWork
{
    NSDictionary * dic =@{@"":@""};
    [NetWork PostNetWorkWithUrl:@"/express_company_list" with:dic successBlock:^(NSDictionary *dic)
    {
    } errorBlock:^(NSString *error) {
        
    }];
}

-(void)showView
{
    self.logisticstableView.alpha = 0;
    self.isShow = YES;
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].toolbarTintColor = [UIColor colorWithString:@"#C90C1E"];
    [KeyWindow addSubview:self];
    self.frame =kScreenFreameBound;
    self.contentView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);

    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight/2);
    } completion:^(BOOL finished) {
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)tapTheView
{
    
    [self viewDissMissFromWindow];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [UIView animateWithDuration:0.3 animations:^{
     self.contentView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}
- (void)keyboardWillShow:(NSNotification *)notification {
    
   //   self.contentView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2-keyboardRect.size.height/2);
//    self.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2-50);
    
    self.contentCenter.constant = -88;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
//    self.contentView.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);

//    self.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight*2);
    self.contentCenter.constant = 0;
}
- (IBAction)sendGoods:(UIButton *)sender
{
    [self tapTheView];
}
- (IBAction)selectedButton:(UIButton *)sender
{
    [self endEditing:YES];
    if (self.logisticstableView.alpha==1)
    {
        self.logisticstableView.alpha = 0;
    }
    else
    {
        self.logisticstableView.alpha = 1;
        if (!self.dataArray.count)
        {
            [self NetWork];
        }
    }
}

#pragma mark --UITableViewDelegate  && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [UITableViewCell new];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (KScreenBoundWidth>320) {
        self.LogisticsCompanyLabel.font =KSystemFont(12);

    }
    else{
        self.LogisticsCompanyLabel.font =KSystemFont(11);
    }

}

#pragma mark --UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(self.center.x, self.center.y-textView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(KScreenBoundWidth/2, KScreenBoundHeight/2);
    } completion:^(BOOL finished) {
        
    }];
}
/** 确定 */
- (IBAction)confirmSendGoods:(UIButton *)sender
{
    if (self.logisticsTextField.text.length == 0) {
        [HUDManager showWarningWithText:@"请输入物流编号"];
        return;
    }
    if (self.LogisticsCompanyLabel.text.length == 0) {
        [HUDManager showWarningWithText:@"请选择物流公司"];
        return;
    }
     if (self.company&&self.orderID)
     {
         if (self.ISChange)
         {
             
             [self ConfirmChangeButtonClicked];
         }
         else
         {
             [self ConfirmButtonClicked];
         }

     }
     else
     {
         [self viewDissMissFromWindow];
     }
}
/** 取消 */
- (IBAction)cancelButtonClicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];

   
}
-(void)GetBlocksWith:(PopSellerSendBlcok)block
{
    self.block = block;
}

-(void)ConfirmButtonClicked
{
    /**发货接口*/
    [HUDManager showLoadingHUDView:self];
    __weak PopInformationView *weakself = self;
    NSDictionary * dic =@{@"of_id":self.orderID,
                          @"user_id":kUserId,
                          @"ecId":self.company,
                          @"shipCode":self.logisticsTextField.text,
                          @"order_seller_intro":@"",
                          @"state_info":@"",};
    [NetWork PostNetWorkWithUrl:@"/seller/order_shipping_save" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue]) {
             if (weakself.block)
             {
                 weakself.block (YES);
             }
         }
         else{
             if (weakself.block)
             {
                 weakself.block (NO);
             }
         }
         [weakself viewDissMissFromWindow];
    } errorBlock:^(NSString *error) {
        weakself.block (NO);
        [weakself viewDissMissFromWindow];
    }];
    
}
-(void)ConfirmChangeButtonClicked
{
    /**修改物流接口*/
    [HUDManager showLoadingHUDView:self];
    __weak PopInformationView *weakself = self;
    NSDictionary * dic =@{@"of_id":self.orderID,
                          @"ecId":self.company,
                          @"shipCode":self.logisticsTextField.text,
                          @"user_id":kUserId};
    [NetWork PostNetWorkWithUrl:@"/change_order_ship_save" with:dic successBlock:^(NSDictionary *dic)
     {
         if ([dic[@"status"] boolValue]) {
             [HUDManager showWarningWithText:@"修改成功"];
             if (weakself.block)
             {
                 weakself.block (YES);
             }
         }
         else{
             if (weakself.block)
             {
                 weakself.block (NO);
             }
         }
         [weakself viewDissMissFromWindow];
         
     } errorBlock:^(NSString *error) {
         weakself.block (NO);
         [weakself viewDissMissFromWindow];
     }];
    
}


@end
