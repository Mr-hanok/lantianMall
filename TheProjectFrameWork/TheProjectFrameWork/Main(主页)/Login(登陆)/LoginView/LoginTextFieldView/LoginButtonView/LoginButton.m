//
//  LoginButton.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LoginButton.h"

@implementation LoginButton

- (instancetype)initWithActionBlock:(clickAction)block
                              title:(NSString *)title
{
    self = [super init];
    if(self)
    {
        
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = 5;
        [self setTitle:[LaguageControl languageWithString:title] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(17)];
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self settingButtonSelectWithSelected:NO];
        self.clickBlcok = block;
    }
    return self;
}
- (instancetype)initWithActionBlock:(clickAction)block
                              title:(NSString *)title
                              image:(UIImage *)image
{
    self = [self initWithActionBlock:block title:title];
    [self setImage:image forState:UIControlStateNormal];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -kScaleWidth(15), 0, 0);
    return self;
}
- (void)clickAction:(UIButton *)sender
{
    if(self.clickBlcok) self.clickBlcok(sender);
}
- (void)settingButtonSelectWithSelected:(BOOL)selected
{
    self.selected = selected;
    self.userInteractionEnabled = selected;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    if(!selected) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.alpha = 0.2f;
        
    }else{
        self.backgroundColor = kNavigationColor;
        self.alpha = 1;

    }
    
}
@end
