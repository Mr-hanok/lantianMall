//
//  BuyAndSendAddressTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
@class AddressModel;
#import <UIKit/UIKit.h>
@interface BuyAndSendAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *defaultaddressBtn;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addresDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *addreslabel;
@property (weak, nonatomic) IBOutlet UILabel *postNumberLabel;

- (void)configCellWithAdressModel:(id)model;
- (void)configWithAdressModel:(AddressModel *)model;
@end
