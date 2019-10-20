//
//  AdressTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *AddressNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dingweiIV;

@end
