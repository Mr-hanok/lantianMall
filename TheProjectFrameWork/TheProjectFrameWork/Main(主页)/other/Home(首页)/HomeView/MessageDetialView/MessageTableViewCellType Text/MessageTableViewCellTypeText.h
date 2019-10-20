//
//  MessageTableViewCellTypeText.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCellTypeText : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *contentButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentButtonwidth;
-(void)loadString:(NSString*)text;
@end
