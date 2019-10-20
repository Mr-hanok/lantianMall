//
//  MineIconView.m
//  test
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "MineIconView.h"
#import "IconLayer.h"

static NSString * unLoginStr = @"登录/注册";
@interface MineIconView ()
{
    IconLayer * _iconLayer;
    BOOL _loginState;
}
@end
@implementation MineIconView

- (instancetype)init
{
    self = [super init];
    if(self)

    {   self.backgroundColor = [UIColor clearColor];
        _iconLayer = [[IconLayer alloc] init];
        [self.layer addSublayer:_iconLayer];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([self.delegate respondsToSelector:@selector(iconClickIconEvent)])
    {
        [self.delegate iconClickIconEvent];
    }
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    _iconLayer.image = image;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    _iconLayer.image = _image;
    NSDictionary * attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:kAppAsiaFontSize(11)],NSForegroundColorAttributeName:[UIColor whiteColor]};
    // imageRect
    // 图片宽度
    CGFloat imageWidth = rect.size.height * 0.7f;
    // 图片左上间距
    CGFloat imageSpace = (rect.size.height - imageWidth) / 2;
    CGRect imageRect = CGRectMake(5, imageSpace, imageWidth , imageWidth);
    // userNameRect
    // 文字起点
    CGFloat wordsStartX = CGRectGetMaxX(imageRect) + rect.size.width * 0.03;
    _iconLayer.bounds = imageRect;
    if(![UserAccountManager shareUserAccountManager].loginStatus)
    {
        CGSize unLoginS = [[LaguageControl languageWithString:[LaguageControl languageWithString:unLoginStr]] sizeWithAttributes:attributes];
        CGRect unLoginRect = CGRectMake(wordsStartX, (rect.size.height-unLoginS.height)/2, unLoginS.width, unLoginS.height);
        [[LaguageControl languageWithString:unLoginStr] drawInRect:unLoginRect withAttributes:attributes];
        return;
    }
    
    UserModel * user = [UserAccountManager shareUserAccountManager].userModel;
    CGSize nameSize ;

    nameSize = [user.username sizeWithAttributes:attributes];

    CGSize rankSize = [user.userRank sizeWithAttributes:attributes];
    
    // 文字距上距离
    CGFloat wordsTop = rect.size.height * 0.27f;
    // 文字距下距离
    CGFloat wordsDown = rect.size.height - wordsTop - nameSize.height;
    CGRect userNameRect = CGRectMake(wordsStartX, wordsTop, nameSize.width, nameSize.height);
    // userRankRect
    CGRect userRankRect = CGRectMake(wordsStartX, wordsDown, rankSize.width, rankSize.height);
    
    [user.username drawInRect:userNameRect withAttributes:attributes];

    [user.userRank drawInRect:userRankRect withAttributes:attributes];
    
}
@end
