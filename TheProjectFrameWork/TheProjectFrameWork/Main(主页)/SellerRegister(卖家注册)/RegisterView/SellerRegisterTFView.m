//
//  SellerRegisterTFView.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SellerRegisterTFView.h"
@interface SellerRegisterTFView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tfTrailing;


@end

@implementation SellerRegisterTFView


+ (instancetype)initWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
                       frame:(CGRect)frame{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SellerRegisterTFView" owner:self options:nil];
    SellerRegisterTFView *tfview =[nibView objectAtIndex:0];
    tfview.titleLabel.text = text;
//    [tfview setFrame:frame];
    tfview.fm = frame;
    tfview.contentTF.placeholder = placeholder;
    return tfview;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect fr = self.fm;
    fr.size.width = KScreenBoundWidth;
    [self setFrame:fr];

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _titleLabel = [UILabel new];
//        _contentTF = [UITextField new];
//        _contentTF.delegate = self;
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        _contentTF.backgroundColor = [UIColor clearColor];
//        _titleLabel.textAlignment = NSTextAlignmentLeft;
//        _titleLabel.font = [UIFont systemFontOfSize:16];
//        _contentTF.font = _titleLabel.font;
//        [self addSubview:_titleLabel];
//        [self addSubview:_contentTF];
//        
//        _line = [UIView new];
//        _line.backgroundColor = [UIColor colorWithString:@"#d9d9d9"];
//        [self addSubview:_line];
//        
//        __weak typeof(self) weakSelf = self;
//
    }
    return self;
}

@end
