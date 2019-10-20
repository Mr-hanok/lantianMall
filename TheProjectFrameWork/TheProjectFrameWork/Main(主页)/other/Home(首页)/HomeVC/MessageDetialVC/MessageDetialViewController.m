//
//  MessageDetialViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MessageDetialViewController.h"
#import "MessageTableViewCellTypeText.h"
#import "MessageModel.h"

static NSString * cellTextIdentifier =@"MessageTableViewCellTypeText";

@interface MessageDetialViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTitleHeight;

@end

@implementation MessageDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeLabel.text = self.model.messageTime;
    self.messageTitle.text = self.model.messageTitle?:@"";
    self.messageTitleHeight.constant = self.model.messageTitle.length ? 30 :0;
    self.contentTextView.text = self.model.messageContent;
    if (([self.model.messageTitle isEqualToString:@""] || self.model.messageTitle == nil )) {
        self.title = @"系统消息";

    }else{
        self.title = self.model.messageTitle?:@"系统消息";

    }

       // Do any additional setup after loading the view from its nib.
}
-(void)BaseLoadView{
    [self beginRefresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
