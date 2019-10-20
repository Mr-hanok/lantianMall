//
//  StationMessageChatTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "StationMessageChatTableViewCell.h"

@implementation StationMessageChatTableViewCell

- (void)awakeFromNib
{
    UIImage * image =[UIImage imageNamed:@"chatfrom_bg_normalme"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.8];
    self.chatContentButton .titleLabel.numberOfLines   = 0;
    [self.chatContentButton setBackgroundImage:image forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)loadString:(NSString*)text{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
    if (size.width>self.frame.size.width-100) {
        self.contentButtonWidth.constant = self.frame.size.width-40;
    }
    else{
        self.contentButtonWidth.constant = size.width+60;
    }
    [self.chatContentButton setTitle:text forState:UIControlStateNormal];
}

@end
