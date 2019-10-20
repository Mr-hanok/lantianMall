//
//  BuyAndSendAddressTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyAndSendAddressTableViewCell.h"
#import "ConfirmOrderModel.h"
#import "AddressModel.h"

@implementation BuyAndSendAddressTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Initialization code
}
- (void)configCellWithAdressModel:(id)model
{
    ConfirmOrderModel * themodel = model;

    self.defaultLabel.hidden = YES;
    if ([themodel.addStatus isEqualToString:@"1"])
    {
        self.defaultaddressBtn.hidden = NO;
        self.defaultLabel.text = LaguageControl(@"默认");
    }else{
        self.defaultaddressBtn.hidden = YES;
    }
}
- (void)configWithAdressModel:(AddressModel *)model{
    

    self.addreslabel.text = LaguageControl(@"收货地址");
    self.postNumberLabel.hidden = YES;
    self.postNumberLabel.text = model.zip;
    
    self.addressnameLabel.text = model.name;
    self.addressPhoneNumber.text = model.telePhone?:model.phone;
    self.addresDetailLabel.text = model.address;
    self.defaultLabel.hidden = YES;

    if (model.defaultAddress) {
         self.defaultaddressBtn.hidden =NO;
        self.defaultLabel.text = LaguageControl(@"默认");
    }else{
        self.defaultaddressBtn.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
