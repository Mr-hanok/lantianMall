//
//  MyWalletPayTypeTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWalletPayTypeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@property (weak, nonatomic) IBOutlet UILabel *payTypeNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageview;

@end
