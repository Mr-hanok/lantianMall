//
//  ClassficationMenuTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassficationMenuTableViewCell : UITableViewCell
/** 菜单栏内容 */
@property (weak, nonatomic) IBOutlet UILabel *menuContentLabel;
@property (weak, nonatomic) IBOutlet UIView *markView;

@end
