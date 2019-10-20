//
//  SellerOrderFootDefaultView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SellerOrderFootDefaultView.h"
#import "BuyerOrderModel.h"

@implementation SellerOrderFootDefaultView
{
    BuyerOrderModel * themodes;
}
-(void)loadDataModel:(id)model With:(SellerOrderTypes)types  senction:(NSInteger)section
{
    BuyerOrderModel * modes = model;
    themodes = modes;
    self.evaluate = modes.evaluate;
    NSString * price = [NSString stringWithFormat:@"￥ %@",[modes.totalPrice caculateFloatValue]];
    self.totalcoutLabel.text =LaguageControlAppendStrings(@"共(订单)", modes.totalcount);
    self.totalLabel.text =LaguageControlAppendStrings(@"总价(订单)",price);
    [self.moreButton setTitle:LaguageControl(@"更多") forState:UIControlStateNormal];
    self.types = types;
    self.section = section;
    self.leftButton.alpha = 1;
    self.leftButton.layer.masksToBounds = YES;
    self.leftButton.layer.cornerRadius = 5;
    self.leftButton.layer.borderWidth = 0.5;
    self.leftButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.middleButton.alpha = 1;
    self.middleButton.layer.masksToBounds = YES;
    self.middleButton.layer.cornerRadius = 5;
    self.middleButton.layer.borderWidth = 0.5;
    self.middleButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.rightButton.alpha = 1;
    self.rightButton.layer.masksToBounds = YES;
    self.rightButton.layer.cornerRadius = 5;
    self.rightButton.layer.borderWidth = 0.5;
    self.rightButton.layer.borderColor = kNavigationCGColor;
    [self.rightButton setTitleColor:kNavigationColor forState:UIControlStateNormal];
    
    self.moreButton.alpha = 0;
    self.moreButton.layer.masksToBounds = YES;
    self.moreButton.layer.cornerRadius = 5;
    self.moreButton.layer.borderWidth = 0.5;
    self.moreButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [self.moreButton setTitle:LaguageControl11(@"更多") forState:UIControlStateNormal];

    if (KScreenBoundWidth>320)
    {
        self.totalcoutLabel.font =KSystemFont(14);
        self.invLabel.font =KSystemFont(13);
        self.totalLabel.font = KSystemFont(14);
        self.totalLabel.font =KSystemFont(12);
        self.leftButton.titleLabel.font = KSystemFont(12);
        self.middleButton.titleLabel.font = KSystemFont(12);
        self.rightButton.titleLabel.font = KSystemFont(12);
        self.moreButton.titleLabel.font = KSystemFont(12);
    }
    else
    {
        self.totalcoutLabel.font =KSystemFont(12);
        self.invLabel.font =KSystemFont(10);
        self.totalLabel.font = KSystemFont(12);

        self.totalLabel.font =KSystemFont(11);
        self.leftButton.titleLabel.font = KSystemFont(11);
        self.middleButton.titleLabel.font = KSystemFont(11);
        self.rightButton.titleLabel.font = KSystemFont(11);
        self.moreButton.titleLabel.font = KSystemFont(11);
    }
    switch (types)
    {
        case SellerOrderTypesSuccess:
            [self.rightButton setTitle:LaguageControl11(@"查看评价") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            self.middleButton.alpha = 1;
            self.leftButton.alpha = 0;
            
            break;
        case SellerOrderTypesToPay:
            [self.rightButton setTitle:LaguageControl11(@"取消订单") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"修改价格") forState:UIControlStateNormal];

            self.middleButton.alpha = 1;
            self.leftButton.alpha = 0;
            break;
            
        case SellerOrderTypesSendIng:
            [self.rightButton setTitle: LaguageControl11(@"投诉") forState:UIControlStateNormal];
            self.middleButton.alpha = 0;
            self.leftButton.alpha = 0;
/*
            [self.rightButton setTitle:LaguageControl(@"发货") forState:UIControlStateNormal];
            [self.middleButton setTitle: LaguageControl(@"投诉") forState:UIControlStateNormal];
            self.leftButton.alpha = 0;
 */
            break;
            
        case SellerOrderTypesToSend:
            [self.rightButton setTitle: LaguageControl11(@"投诉") forState:UIControlStateNormal];
            self.middleButton.alpha = 1;
            [self.middleButton setTitle:LaguageControl11(@"发货") forState:UIControlStateNormal];
            self.leftButton.alpha = 1;
            [self.leftButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];

            /*
            if (modes.type)
            {
                [self.rightButton setTitle:LaguageControl(@"线下发货") forState:UIControlStateNormal];
                [self.middleButton setTitle: LaguageControl(@"投诉") forState:UIControlStateNormal];
                self.leftButton.alpha = 0;

            }
            else
            {
                [self.rightButton setTitle:LaguageControl(@"线下发货") forState:UIControlStateNormal];
                [self.middleButton setTitle:LaguageControl(@"准备发货") forState:UIControlStateNormal];
                [self.leftButton setTitle: LaguageControl(@"投诉") forState:UIControlStateNormal];
            }
             */
            break;
        case SellerOrderTypesToAccept:
            self.middleButton.alpha = 1;
            self.leftButton.alpha = 1;
            self.moreButton.alpha = 1;
            [self.rightButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
            [self.middleButton setTitle: LaguageControl11(@"投诉") forState:UIControlStateNormal];
            [self.leftButton setTitle:LaguageControl11(@"修改物流") forState:UIControlStateNormal];
            [self.moreButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            break;
            
        case SellerOrderTypesToEvaluation:
            if (self.evaluate)
            {
                [self.rightButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
                [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
                [self.leftButton setTitle:LaguageControl11(@"查看评价") forState:UIControlStateNormal];
                self.leftButton.alpha = 1;
                self.moreButton.alpha = 1;
                [self.moreButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            }
            else
            {
                [self.rightButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
                [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
                self.leftButton.alpha = 1;
                [self.leftButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];

            }
            break;
        case SellerOrderTypesCanCeled:
            self.leftButton.alpha = 0;
            self.middleButton.alpha = 0;
            self.rightButton.alpha = 0;
            break;
        case SellerOrderTypesRefundSuccess:
            [self.rightButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            /**卖家判断退款前 订单状态 是否有物流信息 */
            if ([modes.before_refund_status integerValue]<30) {
                self.leftButton.alpha = 0;
                self.middleButton.alpha = 0;
            }else{
                
                self.leftButton.alpha = 0;
                self.middleButton.alpha = 1;
                [self.middleButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            }
            
            break;
        case SellerOrderTypesRefund:
            [self.rightButton setTitle:LaguageControl11(@"退款") forState:UIControlStateNormal];
            [self.middleButton setTitle:LaguageControl11(@"投诉") forState:UIControlStateNormal];
            
            /**卖家判断退款前 订单状态 是否有物流信息 */
            if ([modes.before_refund_status integerValue]<30) {
                self.leftButton.alpha = 0;
            }else{
                
                self.leftButton.alpha = 1;
                [self.leftButton setTitle:LaguageControl11(@"查看物流") forState:UIControlStateNormal];
            }

            break;
        case SellerOrderTypesToPayUnderLine:
            [self.rightButton setTitle:LaguageControl11(@"取消订单") forState:UIControlStateNormal];
            self.middleButton.alpha = 0;
            self.leftButton.alpha = 0;
            break;
        default:
            break;
    }
}

- (IBAction)moreButtonClicked:(UIButton *)sender
{
    
    switch (self.types) {
        case SellerOrderTypesToEvaluation :case  SellerOrderTypesToAccept :
          //  if (self.evaluate)
          //{
                if ([self.delegate respondsToSelector:@selector(SellerCheckTheLogisticsButtonClickedWithSection:)]) {
                    [self.delegate SellerCheckTheLogisticsButtonClickedWithSection:self.section];
                }
          //  }
        
            break;
            
        default:
            if ([self.delegate respondsToSelector:@selector(SellerOrderMoreButtonClicked:withOrderType:andSection:andView:)]) {
                [self.delegate SellerOrderMoreButtonClicked:sender withOrderType:self.types andSection:self.section andView:self];
            }
            break;
    }
    
}
- (IBAction)ButtonClicked:(UIButton *)sender
{
    switch (self.types) {
        case SellerOrderTypesSuccess:
            if (sender.tag == 1001) {
                //查看物流
                if ([self.delegate respondsToSelector:@selector(SellerCheckTheLogisticsButtonClickedWithSection:)])
                {
                    [self.delegate SellerCheckTheLogisticsButtonClickedWithSection:self.section];
                }
            }else{
                if ([self.delegate respondsToSelector:@selector(SellerLookevaluationButtonClickedWithSection:)])
                {
                    [self.delegate SellerLookevaluationButtonClickedWithSection:self.section];
                }
            }
            
            break;
        case SellerOrderTypesToPay:
            if (sender.tag == 1002) {
                if ([self.delegate respondsToSelector:@selector(SellerCanCelOrderButtonClickedWithSection:)])
                {
                    [self.delegate SellerCanCelOrderButtonClickedWithSection:self.section];
                }
            }else{
                if ([self.delegate respondsToSelector:@selector(SellerChangeMoneyButtonClickedWithSection:)])
                {
                    [self.delegate SellerChangeMoneyButtonClickedWithSection:self.section];
                }
            }
            
            
            break;
        case SellerOrderTypesToPayUnderLine:
            if ([self.delegate respondsToSelector:@selector(SellerCanCelOrderButtonClickedWithSection:)])
            {
                [self.delegate SellerCanCelOrderButtonClickedWithSection:self.section];
            }
            break;
        case SellerOrderTypesSendIng:
            /** 投诉 */
            if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
            {
                [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
            }
//            if (sender.tag==1002) {
//                if ([self.delegate respondsToSelector:@selector(SellerSendGoodsButtonClickedWithSection:)])
//                {
//                    [self.delegate SellerSendGoodsButtonClickedWithSection:self.section];
//                }
//            }
//            else if (sender.tag ==1001)
//            {
//                if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
//                {
//                    [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
//                }
//            }
            break;
            
        case SellerOrderTypesToSend:
            /** 投诉 */
            if (sender.tag == 1002) {
                if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
                {
                    [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
                }
            }else if(sender.tag == 1001){/**发货*/
                if ([self.delegate respondsToSelector:@selector(SellerSendGoodsButtonClickedWithSection:)])
                {
                    [self.delegate SellerSendGoodsButtonClickedWithSection:self.section];
                }
            }else{/**退款*/
                if ([self.delegate respondsToSelector:@selector(SellerrefundButtonClickedWithSection:)])
                {
                    [self.delegate SellerrefundButtonClickedWithSection:self.section];
                }

            }
            
//                       if (themodes.type)
//            {
//                if (sender.tag==1002)
//                {
//                    /** 线下发货 */
//                    if ([self.delegate respondsToSelector:@selector(SellerSendINGSGoodsUndelineButtonClickedWithSection:)])
//                    {
//                        [self.delegate SellerSendINGSGoodsUndelineButtonClickedWithSection:self.section];
//                    }
//                }
//                
//                else if (sender.tag ==1001)
//                {
//                    /** 投诉 */
//                    if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
//                    {
//                        [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
//                    }
//                }
//                
//            }
//            else
//            {
//                if (sender.tag==1002)
//                {
//                    /** 线下发货 */
//                    if ([self.delegate respondsToSelector:@selector(SellerSendINGSGoodsUndelineButtonClickedWithSection:)])
//                    {
//                        [self.delegate SellerSendINGSGoodsUndelineButtonClickedWithSection:self.section];
//                    }
//
//                }
//                /** 平台发货 */
//                else if (sender.tag ==1001)
//                {
//                    if ([self.delegate respondsToSelector:@selector(SellerSendINGSGoodsButtonClickedWithSection:)])
//                    {
//                        [self.delegate SellerSendINGSGoodsButtonClickedWithSection:self.section];
//                    }
//                 
//                }
//                else
//                {
//                    if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
//                    {
//                        [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
//                    }
//                }
//                
//            }

            break;
        case SellerOrderTypesToAccept:
            if (sender.tag==1000)
            {
                
                if ([self.delegate respondsToSelector:@selector(SellerChangeMoneyButtonClickedWithSection:)])
                {
                    [self.delegate SellerChangeMoneyButtonClickedWithSection:self.section];
                }
            }
            else if (sender.tag ==1001)
            {
                if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
                {
                    [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
                }
  
            }
            else if (sender.tag ==1002)
            {
                if ([self.delegate respondsToSelector:@selector(SellerrefundButtonClickedWithSection:)])
                {
                [self.delegate SellerrefundButtonClickedWithSection:self.section];
                }
                
            }
            break;
            
        case SellerOrderTypesToEvaluation:
            
            if (self.evaluate) {
                if (sender.tag==1000) {
                    if ([self.delegate respondsToSelector:@selector(SellerLookevaluationButtonClickedWithSection:)])
                    {
                        [self.delegate SellerLookevaluationButtonClickedWithSection:self.section];
                    }
                }
                else if (sender.tag ==1001)
                {
                    if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
                    {
                        [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
                    }
                    
                }
                else
                {
                    if ([self.delegate respondsToSelector:@selector(SellerrefundButtonClickedWithSection:)])
                    {
                        [self.delegate SellerrefundButtonClickedWithSection:self.section];
                    }
                    
                }
            }
            else{if (sender.tag ==1001)
            {
                if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
                {
                    [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
                }
                
            }
            else if(sender.tag == 1002)
            
            {
                if ([self.delegate respondsToSelector:@selector(SellerrefundButtonClickedWithSection:)])
                {
                    [self.delegate SellerrefundButtonClickedWithSection:self.section];
                }
            }else if (sender.tag == 1000){
                if ([self.delegate respondsToSelector:@selector(SellerCheckTheLogisticsButtonClickedWithSection:)]) {
                    [self.delegate SellerCheckTheLogisticsButtonClickedWithSection:self.section];
                }
            }
                
        }
            
            break;
        case SellerOrderTypesCanCeled:
            break;

        case SellerOrderTypesRefundSuccess:
            if (sender.tag == 1002) {
                if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
                {
                    [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
                }
            }else if (sender.tag == 1001){
                if ([self.delegate respondsToSelector:@selector(SellerCheckTheLogisticsButtonClickedWithSection:)]) {
                    [self.delegate SellerCheckTheLogisticsButtonClickedWithSection:self.section];
                }
            }
            break;
        case SellerOrderTypesRefund:
            if (sender.tag==1002) {
                if ([self.delegate respondsToSelector:@selector(SellerrefundButtonClickedWithSection:)])
                {
                    [self.delegate SellerrefundButtonClickedWithSection:self.section];
                }
            }
            else if (sender.tag ==1001)
            {
                if ([self.delegate respondsToSelector:@selector(SellercomplaintsButtonClickedWithSection:)])
                {
                    [self.delegate SellercomplaintsButtonClickedWithSection:self.section];
                }
            }else if (sender.tag == 1000){
                if ([self.delegate respondsToSelector:@selector(SellerCheckTheLogisticsButtonClickedWithSection:)]) {
                    [self.delegate SellerCheckTheLogisticsButtonClickedWithSection:self.section];
                }
            }
            break;

        default:

            break;
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
