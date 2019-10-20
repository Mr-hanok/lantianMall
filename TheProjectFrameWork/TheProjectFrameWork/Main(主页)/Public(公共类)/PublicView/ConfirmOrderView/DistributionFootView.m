//
//  DistributionFootView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "DistributionFootView.h"
#import "StoreOrderModel.h"

@interface DistributionFootView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *selVipPriceBtn;
@property (weak, nonatomic) IBOutlet UILabel *selVipPriceLabel;

@end

@implementation DistributionFootView
- (IBAction)selVipPriceAction:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(DistributionFootViewDidSelectedWithSection:andDistrbutionView:selbtn:)]) {
        [_delegate DistributionFootViewDidSelectedWithSection:self.section andDistrbutionView:self selbtn:self.selVipPriceBtn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    if (!kIsHaveCoupon) {
        self.topIView.hidden = self.vippriceView.hidden = YES;
        self.vipPriceViewHeigth.constant = 0.f;
    }
    [self.selVipPriceBtn setTitleColor:kNavigationColor forState:UIControlStateNormal];
    self.selVipPriceLabel.textColor = kNavigationColor;
}
-(void)LoadDataWith:(id)model andSection:(NSInteger)section
{
    StoreOrderModel * models = model;
    if (models.vipshopmodel) {
        [self.selVipPriceBtn setTitle:models.vipshopmodel.tempstr forState:UIControlStateNormal];
    }else{
        [self.selVipPriceBtn setTitle:@"" forState:UIControlStateNormal];
    }
    if ([models.sendtype isEqualToString:@"2"])
    {
        self.deliveryTypeLabel.text = [LaguageControl languageWithString:@"急速快递"];
        self.deliveryTimeLabel.alpha =1;
        self.timeImageView.alpha=1;
    }
    else
    {
        self.deliveryTypeLabel.text = [LaguageControl languageWithString:@"普通快递"];
        self.deliveryTimeLabel.alpha =1;
        self.deliveryTimeLabel.text = LaguageControl(@"Delivery Time: 3 to 5 working days");
        self.timeImageView.alpha=0;
    }
    
    self.messagecontentTextField.placeholder = LaguageControl(@"给商家留言");
    self.messagecontentTextField.text = models.leaveMessage;
    self.section = section;
    self.sendWaysLabel.text = [LaguageControl languageWithString:@"配送方式"];
    self.sellerLeaveLabel.text =[LaguageControl languageWithString:@"买家留言:"];
    CGSize sellerSize =[NSString sizeWithString:LaguageControl(@"买家留言：") font:[UIFont systemFontOfSize:15] maxHeight:20 maxWeight:KScreenBoundWidth];
    self.sellerleaveLabelWidth.constant = sellerSize.width+10;
    self.messagecontentTextField.delegate = self;
    self.deliveryTimeLabel.text = models.sendtime;
    
}
- (IBAction)selectedButtonclicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(DistributionFootViewDidSelectedWithSection:andDistrbutionView:)]) {
        [self.delegate DistributionFootViewDidSelectedWithSection:self.section andDistrbutionView:self];
    }
}
#pragma makr -UITextFieldDelegate --关于表情的部分处理！！！

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.textInputMode.primaryLanguage == NULL ||[textField.textInputMode.primaryLanguage isEqualToString:@"emoji"])
    {
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if (theTextField == self.messagecontentTextField)
    {
        
        [theTextField resignFirstResponder];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(TextFieldEndinputSelectedWithSection:andTextField:)])
    {
        [self.delegate TextFieldEndinputSelectedWithSection:self.section andTextField:textField];
    }
}

@end
