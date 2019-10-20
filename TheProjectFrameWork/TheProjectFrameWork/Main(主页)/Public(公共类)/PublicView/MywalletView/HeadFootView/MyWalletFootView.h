//
//  MyWalletFootView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MyWalletFootView : UITableViewHeaderFooterView


@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *rebatebalanceLabel;


-(void)loadData:(id)model with:(BOOL)isSelected;

@end
