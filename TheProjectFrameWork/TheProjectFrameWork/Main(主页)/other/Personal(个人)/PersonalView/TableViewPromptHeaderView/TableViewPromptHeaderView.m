//
//  TableViewPromptHeaderView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "TableViewPromptHeaderView.h"
@interface TableViewPromptHeaderView ()
{
    UILabel * _headerLabel;
}
@end

@implementation TableViewPromptHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _headerLabel = [[UILabel alloc] initWithText:nil];
        _headerLabel.textColor = [UIColor colorWithString:@"#a3a3a3200"];
        _headerLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_headerLabel];
        __weak typeof(self) weakSelf = self;
        _headerLabel.numberOfLines = 0;
        [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10)).priority(990);
        }];
    }
    return self;
}
- (void)setText:(NSString *)text{
    _headerLabel.text = [LaguageControl languageWithString:text];
    _text = _headerLabel.text;
}
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _headerLabel.attributedText = attributedText;
    _attributedText = attributedText;
}
- (CGFloat)height
{
    NSDictionary *attribute = @{NSFontAttributeName: _headerLabel.font};
    CGSize retSize = CGSizeZero;
    retSize = [_text boundingRectWithSize:CGSizeMake(KScreenBoundWidth  - kScaleWidth(20), 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return retSize.height;
}

@end
