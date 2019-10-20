//
//  OrderTableFootView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderTableFootView.h"
#import "BuyerOrderModel.h"

@implementation OrderTableFootView

-(void)load:(UIButton*)button with:(UIColor*)color
{
    button.layer.borderColor = color.CGColor;
    [button setTitleColor:color forState:UIControlStateNormal];
}
-(void)loaddata:(id)model with:(OrderTypes)type withSection:(NSInteger) section
{
    self.contentView.backgroundColor = KSepLineColor;
    BuyerOrderModel * modes = model;
    self.evaluate = modes.evaluate;
    NSString * price = [NSString stringWithFormat:@"￥ %@",[modes.totalPrice caculateFloatValue]];
    self.totalcountLabel.text =[NSString stringWithFormat:@"%@%@%@",@"共: ",modes.totalcount, @"件"];
    self.totalLabel.text =LaguageControlAppendStrings(@"总价",price);
    [self.moreButton setTitle:LaguageControl(@"更多") forState:UIControlStateNormal];
    self.leftButton.layer.masksToBounds = YES;
    self.leftButton.layer.cornerRadius = 5;
    self.leftButton.layer.borderWidth = 0.5;
    self.leftButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.left2Buttom.layer.masksToBounds = YES;
    self.left2Buttom.layer.cornerRadius = 5;
    self.left2Buttom.layer.borderWidth = 0.5;
    self.left2Buttom.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.middleButton.layer.masksToBounds = YES;
    self.middleButton.layer.cornerRadius = 5;
    self.middleButton.layer.borderWidth = 0.5;
    self.middleButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.rightButton.layer.masksToBounds = YES;
    self.rightButton.layer.cornerRadius = 5;
    self.rightButton.layer.borderWidth = 0.5;
    self.rightButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.moreButton.layer.masksToBounds = YES;
    self.moreButton.layer.cornerRadius = 5;
    self.moreButton.layer.borderWidth = 0.5;
    self.moreButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.leftButton.alpha = 1;
    self.middleButton.alpha = 1;
    self.rightButton.alpha = 1;
    self.left2Buttom.alpha = 0;
    self.moreButton.alpha = 0;
    self.celltype = type;
    self.section = section;
    if (KScreenBoundWidth>320)
    {
        self.totalcountLabel.font =KSystemFont(14);
        self.inclDeliveryLabel.font =KSystemFont(13);
        self.totalLabel.font = KSystemFont(14);
        self.leftButton.titleLabel.font = KSystemFont(13);
        self.middleButton.titleLabel.font = KSystemFont(13);
        self.rightButton.titleLabel.font = KSystemFont(13);
        self.moreButton.titleLabel.font = KSystemFont(13);
        self.left2Buttom.titleLabel.font = KSystemFont(13);

    }
    else
    {
        self.totalcountLabel.font =KSystemFont(12);
        self.inclDeliveryLabel.font =KSystemFont(10);
        self.totalLabel.font = KSystemFont(12);
        self.leftButton.titleLabel.font = KSystemFont(11);
        self.middleButton.titleLabel.font = KSystemFont(11);
        self.rightButton.titleLabel.font = KSystemFont(11);
        self.moreButton.titleLabel.font = KSystemFont(11);
        self.left2Buttom.titleLabel.font = KSystemFont(11);

    }
    [self load:self.leftButton with:[UIColor darkGrayColor]];
    [self load:self.middleButton with:[UIColor darkGrayColor]];
    [self load:self.rightButton with:[UIColor darkGrayColor]];
    [self load:self.left2Buttom with:[UIColor darkGrayColor]];
    [self load:self.moreButton with:[UIColor darkGrayColor]];
    [self load:self.rightButton with:kNavigationColor];


    switch (type)
    {
        case OrderTypesScuccess:
            /**
             *  已完成
             */
            [self setcomplainBtn:nil];
            self.moreButton.alpha = 0;
            [self load:self.rightButton with:kNavigationColor];
            [self.rightButton setTitle:LaguageControl11(@"查看评价") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];

            self.leftButton.alpha = 1;
            self.middleButton.alpha = 1;
            break;
        case OrderTypesApplyRefunding:

            [self.rightButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];

            [self setcomplainBtn:self.middleButton];
//            [self.middleButton setTitle:LaguageControl11(@"投诉" )forState:UIControlStateNormal];
            /**判读订单之前状态 是否有物流*/
            if ([modes.before_refund_status integerValue]<30) {
                self.leftButton.alpha = 0;

            }else{
                self.leftButton.alpha = 1;
                [self.leftButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            }
            break;
        case OrderTypesRefundFailure:
            [self.rightButton setTitle:LaguageControl11(@"我要评价") forState:UIControlStateNormal];
            [self load:self.rightButton with:kNavigationColor];
            [self setcomplainBtn:self.middleButton];
            //            [self.middleButton setTitle:LaguageControl11(@"投诉" )forState:UIControlStateNormal];
            [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];

            break;
        case OrderTypesRefundSuccess:
            
            [self setcomplainBtn:self.rightButton];

//            [self.rightButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
            /**判读订单之前状态 是否有物流*/
            if ([modes.before_refund_status integerValue]<30) {
                self.leftButton.alpha = 0;
                
            }else{
                self.leftButton.alpha = 1;
                [self.leftButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            }
            break;
        case OrderTypesCanCel:
            [self setcomplainBtn:nil];
            [self.rightButton setTitle:LaguageControl11(@"查看订单") forState:UIControlStateNormal];
//            [self.rightButton setTitle:LaguageControl(@"删除订单") forState:UIControlStateNormal];
            self.leftButton.alpha = 0;
            self.middleButton.alpha = 0;
            break;
        case OrderTypesToPayment:
            /**
             *  待付款
             */
            [self setcomplainBtn:nil];
            [self.rightButton setTitle:LaguageControl11(@"付款") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"取消订单") forState:UIControlStateNormal];
            [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
            break;
        case OrderTypesToPayUnderLine:
            /**
             *  线下付款
             */
            [self setcomplainBtn:nil];
            [self.rightButton setTitle:LaguageControl11(@"付款") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"取消订单") forState:UIControlStateNormal];
            [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
            break;
        case OrderTypesPingTuan:
        case OrderTypesToSend:
            /**
             *  待发货
             */
//            [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            [self.rightButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
            [self setcomplainBtn:self.middleButton];
            [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
            break;
        case OrderTypesToSendING:
            /**
             *  卖家点完准备发货状态
             */
//            [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            [self.rightButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
            [self setcomplainBtn:self.middleButton];
            [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
            break;
        case OrderTypesToAccePt:
            /**
             *  待收货
             */
            
            [self.rightButton setTitle:LaguageControl11(@"确定收货") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
            [self setcomplainBtn:self.leftButton];
//            [self.leftButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            self.left2Buttom.alpha = 1;
            [self.left2Buttom setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            self.moreButton.alpha = 1.f;
            [self.moreButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
            break;
        case OrderTypesToEvaluation:
            /**已收货 待评价？？？？*/
            if (self.evaluate)
            {
                self.moreButton.alpha = 1;
                [self setcomplainBtn:self.middleButton];
//                [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
                [self.rightButton setTitle:LaguageControl11(@"查看评价") forState:UIControlStateNormal];
                [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
                self.left2Buttom.alpha =1 ;
                [self.left2Buttom setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
                [self.moreButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
            }
            else
            {
                self.moreButton.alpha = 1;
                [self setcomplainBtn:self.middleButton];
//                [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
                [self.rightButton setTitle:LaguageControl11(@"评价") forState:UIControlStateNormal];
                [self.leftButton setTitle:LaguageControl11(@"联系卖家") forState:UIControlStateNormal];
                self.left2Buttom.alpha =1 ;
                [self.left2Buttom setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
                [self.moreButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
            }
            break;

        case OrderTypesAllTypes:
            
            break;
        default:
            break;
    }
    
    
}

/**
 *
 *
 *  @param sender <#sender description#>
 */
- (IBAction)ButtonClicked:(UIButton *)sender
{
    switch (self.celltype)
    {
        case OrderTypesScuccess:
            if (sender.tag==102)
            {/**查看评价*/
                if ([self.delegate respondsToSelector:@selector(LookEvaluationButtonClickedWithSection:)]) {
                    [self.delegate LookEvaluationButtonClickedWithSection:self.section];
                }
            }
            if (sender.tag==101)
            {/**查看物流*/
                if ([self.delegate respondsToSelector:@selector(CheckTheLogisticsButtonClickedWithSection:)]) {
                    [self.delegate CheckTheLogisticsButtonClickedWithSection:self.section];
                }
            }
            if (sender.tag==100)
            {/**联系卖家*/
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }
            }
            break;
        case OrderTypesApplyRefunding:
             if (sender.tag==102)
            {
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }
            }
             else if (sender.tag==101)
             {
                 if ([self.delegate respondsToSelector:@selector(complaintsButtonClickedWithSection:)]) {
                     [self.delegate complaintsButtonClickedWithSection:self.section];
                 }
             }else{
                 if ([self.delegate respondsToSelector:@selector(CheckTheLogisticsButtonClickedWithSection:)]) {
                     [self.delegate CheckTheLogisticsButtonClickedWithSection:self.section];
                 }
             }
            break;
        case OrderTypesRefundFailure:
            if (sender.tag==100)
            {
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }

            }
            else if (sender.tag==101)
            {
                if ([self.delegate respondsToSelector:@selector(complaintsButtonClickedWithSection:)]) {
                    [self.delegate complaintsButtonClickedWithSection:self.section];
                }
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(ToevaluationButtonClickedWithSection:)]) {
                    [self.delegate ToevaluationButtonClickedWithSection:self.section];
                }
            }
            break;
            //已退款
        case OrderTypesRefundSuccess:
            
            if (sender.tag==102)
            {
                if ([self.delegate respondsToSelector:@selector(complaintsButtonClickedWithSection:)]) {
                    [self.delegate complaintsButtonClickedWithSection:self.section];
                }
            }
            else if (sender.tag==101)
            {
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }
            }else{
                if ([self.delegate respondsToSelector:@selector(CheckTheLogisticsButtonClickedWithSection:)]) {
                    [self.delegate CheckTheLogisticsButtonClickedWithSection:self.section];
                }

            }
            break;
        case OrderTypesCanCel:
            if (sender.tag==102)
            {
            if ([self.delegate respondsToSelector:@selector(DelegateOrderButtonClickedWithSection:)]) {
                [self.delegate DelegateOrderButtonClickedWithSection:self.section];
            }
            }
            break;
        case OrderTypesToPayment:
            if (sender.tag==100) {
                
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }
            }
            else if (sender.tag==101)
            {
                if ([self.delegate respondsToSelector:@selector(CanCelOrderButtonClickedWithSection:)]) {
                    [self.delegate CanCelOrderButtonClickedWithSection:self.section];
                }
                
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(PayMoneyButtonClickedWithSection:)]) {
                    [self.delegate PayMoneyButtonClickedWithSection:self.section];
                }
            }
            break;
        case OrderTypesToPayUnderLine:
            if (sender.tag==100) {
                
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }
            }
            else if (sender.tag==101)
            {
                if ([self.delegate respondsToSelector:@selector(CanCelOrderButtonClickedWithSection:)]) {
                    [self.delegate CanCelOrderButtonClickedWithSection:self.section];
                }
                
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(PayMoneyButtonClickedWithSection:)]) {
                    [self.delegate PayMoneyButtonClickedWithSection:self.section];
                }
            }
            break;
        case OrderTypesToSendING:
            if (sender.tag==100) {
                
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }
            }
            else if (sender.tag==101)
            {
                if ([self.delegate respondsToSelector:@selector(complaintsButtonClickedWithSection:)]) {
                    [self.delegate complaintsButtonClickedWithSection:self.section];
                }
                
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(refundButtonClickedWithSection:)]) {
                    [self.delegate refundButtonClickedWithSection:self.section];
                }
            }
            break;
        case OrderTypesPingTuan:
        case OrderTypesToSend:
            if (sender.tag==100) {
                
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }
            }
            else if (sender.tag==101)
            {
                if ([self.delegate respondsToSelector:@selector(complaintsButtonClickedWithSection:)]) {
                    [self.delegate complaintsButtonClickedWithSection:self.section];
                }
                
            }
            else
            {
                if ([self.delegate respondsToSelector:@selector(refundButtonClickedWithSection:)]) {
                    [self.delegate refundButtonClickedWithSection:self.section];
                }
            }
            break;
        case OrderTypesToAccePt:
            /**
             *  待收货
             */
            if (sender.tag==100) {
                
                if ([self.delegate respondsToSelector:@selector(complaintsButtonClickedWithSection:)]) {
                    [self.delegate complaintsButtonClickedWithSection:self.section];
                }
            }
            else if (sender.tag==101)
            {
                if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                    [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                }
                
            }
            else if (sender.tag==102){
                if ([self.delegate respondsToSelector:@selector(ConfimAceptButtonClickedWithSection:)]) {
                    [self.delegate ConfimAceptButtonClickedWithSection:self.section];
                }
            }else if (sender.tag == 99){
                if ([self.delegate respondsToSelector:@selector(CheckTheLogisticsButtonClickedWithSection:)]) {
                    [self.delegate CheckTheLogisticsButtonClickedWithSection:self.section];
                }
            }
            break;
        case OrderTypesToEvaluation:
            /**
             *  已收货待评价
             */
            if (!self.evaluate)
            {
                if (sender.tag==100) {
                    
                    if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                        [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                    }
                }
                else if (sender.tag==101)
                {
                    if ([self.delegate respondsToSelector:@selector(complaintsButtonClickedWithSection:)]) {
                        [self.delegate complaintsButtonClickedWithSection:self.section];
                    }
                    
                }else  if (sender.tag==102)
                {/**<#注释信息#>*/
                    if ([self.delegate respondsToSelector:@selector(ToevaluationButtonClickedWithSection:)]) {
                        [self.delegate ToevaluationButtonClickedWithSection:self.section];
                    }
                }else if (sender.tag == 99){
                    /**查看物流*/
                    if ([self.delegate respondsToSelector:@selector(CheckTheLogisticsButtonClickedWithSection:)]) {
                        [self.delegate CheckTheLogisticsButtonClickedWithSection:self.section];
                    }
                }
                
            }
            else
            {
                if (sender.tag==100) {
                    
                    if ([self.delegate respondsToSelector:@selector(ConnectSellerButtonClickedWithSection:)]) {
                        [self.delegate ConnectSellerButtonClickedWithSection:self.section];
                    }
                }
                else if (sender.tag==102)
                {
                    if ([self.delegate respondsToSelector:@selector(LookEvaluationButtonClickedWithSection:)]) {
                        [self.delegate LookEvaluationButtonClickedWithSection:self.section];
                    }
                    
                } else if(sender.tag == 101){
                    if ([self.delegate respondsToSelector:@selector(complaintsButtonClickedWithSection:)]) {
                        [self.delegate complaintsButtonClickedWithSection:self.section];
                    }
                }else if (sender.tag == 99){
                    /**查看物流*/
                    if ([self.delegate respondsToSelector:@selector(CheckTheLogisticsButtonClickedWithSection:)]) {
                        [self.delegate CheckTheLogisticsButtonClickedWithSection:self.section];
                    }
                }
                
            }
        break;
        default:
            break;
    }

}

/**
 *  
 *
 *  @param sender <#sender description#>
 */
- (IBAction)moreButtonClicked:(UIButton *)sender
{
    switch (self.celltype) {
        case OrderTypesToEvaluation:
            /**
             *  已收货待评价
             */
            if ([self.delegate respondsToSelector:@selector(refundButtonClickedWithSection:)]) {
                [self.delegate refundButtonClickedWithSection:self.section];
            }

            break;
            
        case OrderTypesRefund:
            /**
             *  退款
             */
            if ([self.delegate respondsToSelector:@selector(refundButtonClickedWithSection:)]) {
                [self.delegate refundButtonClickedWithSection:self.section];
            }
            
            break;
            
        default:
            if ([self.delegate respondsToSelector:@selector(OrderMoreButtonClicked:withOrderType:andSection:andView:)]) {
                [self.delegate OrderMoreButtonClicked:sender withOrderType:self.celltype andSection:self.section andView:self];
            }
            break;
    }
    
}

- (void)setcomplainBtn:(UIButton *)btn{
    if (!btn) {
        self.rightBtnLeadingConstraint.constant = 20;
        self.midBtnLeadingConstraint.constant = 10;
        self.leftbtnLeadingConstraint.constant = 10;
        self.left2BtnLeadIngConstraint.constant = 10;
        return;
    }
    if (kIsHaveComplaint) {
        [btn setTitle:LaguageControl11(@"投诉" )forState:UIControlStateNormal];
        btn.alpha = 1;
        self.rightBtnLeadingConstraint.constant = 20;
        self.midBtnLeadingConstraint.constant = 10;
        self.leftbtnLeadingConstraint.constant = 10;
        self.left2BtnLeadIngConstraint.constant = 10;
        
    }else{
        [btn setTitle:@"" forState:UIControlStateNormal];
        btn.alpha = 0;
        if (btn == self.rightButton) {
            self.rightBtnLeadingConstraint.constant = -20;
            self.midBtnLeadingConstraint.constant = 10;
            self.leftbtnLeadingConstraint.constant = 10;
            self.left2BtnLeadIngConstraint.constant = 10;
        }else if (btn == self.middleButton){
            self.rightBtnLeadingConstraint.constant = 20;
            self.midBtnLeadingConstraint.constant = -30;
            self.leftbtnLeadingConstraint.constant = 10;
            self.left2BtnLeadIngConstraint.constant = 10;
        }else if (btn == self.leftButton){
            self.rightBtnLeadingConstraint.constant = 20;
            self.midBtnLeadingConstraint.constant = 10;
            self.leftbtnLeadingConstraint.constant = -30;
            self.left2BtnLeadIngConstraint.constant = 10;

        }else if(btn == self.left2Buttom){
            self.rightBtnLeadingConstraint.constant = 20;
            self.midBtnLeadingConstraint.constant = 10;
            self.leftbtnLeadingConstraint.constant = 10;
            self.left2BtnLeadIngConstraint.constant = -30;
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
