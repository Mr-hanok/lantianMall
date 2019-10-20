//
//  MyWalletSettleMentButtonTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyWalletSettleMentButtonTableViewCellDelegate <NSObject>

-(void)MyWalletSettleMentButtonTableViewCellButtonClicked:(UIButton*)button;

@end

@interface MyWalletSettleMentButtonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *confirmPayButton;
@property(assign,nonatomic)id <MyWalletSettleMentButtonTableViewCellDelegate> delegate;
@end
