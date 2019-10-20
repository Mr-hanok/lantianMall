//
//  MessageDetialViewController.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

@class MessageModel;
#import "LeftViewController.h"

@interface MessageDetialViewController : LeftViewController

@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property(strong,nonatomic) MessageModel * model;
@end
