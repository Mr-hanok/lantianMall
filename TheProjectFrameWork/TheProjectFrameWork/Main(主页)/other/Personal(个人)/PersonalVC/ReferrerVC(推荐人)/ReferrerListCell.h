//
//  ReferrerListCell.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/12.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferrerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end
