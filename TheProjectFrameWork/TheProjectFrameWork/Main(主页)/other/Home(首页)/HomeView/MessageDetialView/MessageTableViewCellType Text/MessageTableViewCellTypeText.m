//
//  MessageTableViewCellTypeText.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MessageTableViewCellTypeText.h"

@implementation MessageTableViewCellTypeText

- (void)awakeFromNib {
    UIImage * image =[UIImage imageNamed:@"chatfrom_bg_normal"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.8];
    self.contentButton .titleLabel.numberOfLines   = 0;
    [self.contentButton setBackgroundImage:image forState:UIControlStateNormal];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadString:(NSString*)text
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
    if (size.width>self.frame.size.width-100) {
        self.contentButtonwidth.constant = self.frame.size.width-80;
    }
    else{
        self.contentButtonwidth.constant = size.width+60;
    }
    [self.contentButton setTitle:text forState:UIControlStateNormal];

    
}

@end
