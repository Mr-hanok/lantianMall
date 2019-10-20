//
//  AddressHandleView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AddressHandleView.h"
#import "ImageButton.h"


@interface AddressHandleView ()<ImageButtonDelegate>
{
    ImageButton * _defaulfButton;
    ImageButton * _editButton;
    ImageButton * _deleteButton;
}
@end
@implementation AddressHandleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        _defaulfButton = [[ImageButton alloc] init];
        _editButton = [[ImageButton alloc] init];
        _deleteButton = [[ImageButton alloc] init];
        
        [self setup];
    }
    return self;
}
- (void)setup
{
   
    [self addSubview:_defaulfButton];
    [self addSubview:_editButton];
    [self addSubview:_deleteButton];
    __weak typeof(self) weakSelf = self;
    void (^layoutBlock)(MASConstraintMaker *make) = ^(MASConstraintMaker *make){
        make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(10));
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(10));
    };
    [_defaulfButton mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.left.equalTo(weakSelf.mas_left);
        
    }];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.right.equalTo(_deleteButton.mas_left).mas_offset(-kScaleWidth(10));
    }];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        layoutBlock(make);
        make.right.equalTo(weakSelf.mas_right);
    }];

    [_defaulfButton setImage:[UIImage imageNamed:@"weixuanzhong"] selectImage:[UIImage imageNamed:@"xuanzhong"] title:@"默认地址"];
    [_editButton setImage:[UIImage imageNamed:@"binji"] selectImage:nil title:@"编辑"];
    [_deleteButton setImage:[UIImage imageNamed:@"shanchu"] selectImage:nil title:@"删除"];
    _defaulfButton.delegate = self;
    _editButton.delegate = self;
    _deleteButton.delegate = self;
    _defaulfButton.tag = AddressHandleDefault;
    _editButton.tag = AddressHandleEdit;
    _deleteButton.tag = AddressHandleDelete;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#a3a3a3122"] setStroke];
    CGContextSetLineWidth(ctx, 0.5f);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    CGContextStrokePath(ctx);
}

#pragma mark - event respond
/**
 *  点击设置默认地址
 *
 *  @param sender <#sender description#>
 */
- (void)isDefaulfAddressWithButton:(ImageButton *)sender
{
    if([_delegate respondsToSelector:@selector(addressHandleClickDefaulfAddress)])
    {
        [_delegate addressHandleClickDefaulfAddress];
    }
}
/**
 *  点击编辑
 */
- (void)edit
{
    if([_delegate respondsToSelector:@selector(addressHandleClickEdit)])
    {
        [_delegate addressHandleClickEdit];
    }
}
/**
 *  点击删除
 */
- (void)delete
{
    if([_delegate respondsToSelector:@selector(addressHandleClickDelete)])
    {
        [_delegate addressHandleClickDelete];
    }
}
#pragma mark - delegate Method
- (void)imageButton:(ImageButton *)button
{
    switch (button.tag) {
        case AddressHandleDefault:
            [self isDefaulfAddressWithButton:button];
            break;
        case AddressHandleEdit:
            [self edit];
            break;
        case AddressHandleDelete:
            [self delete];
            break;
        default:
            break;
    }
}
#pragma mark - setter and getter 
- (void)setIsDefault:(BOOL)isDefault
{
    _isDefault = isDefault;
    _defaulfButton.select = isDefault;
}

@end
