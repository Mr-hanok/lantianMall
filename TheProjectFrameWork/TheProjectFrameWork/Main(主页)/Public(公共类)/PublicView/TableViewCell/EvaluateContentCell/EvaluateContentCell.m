//
//  EvaluateContentCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  评价内容cell

#import "EvaluateContentCell.h"
#import "PlaceholderTextView.h"
#import "ImageButton.h"
#import "ComplaintsContentCell.h"
#import "OrderGoodsModel.h"
#import "EvalutionDetialModel.h"
@interface EvaluateContentCell ()<PlaceholderTextViewDelegate,ImageButtonDelegate,PhotoViewDelegate>
{
    UIImageView * _goodsImage;
    PlaceholderTextView * _text;
    ImageButton * selectedButton;
    PhotoView * _photo1;
    PhotoView * _photo2;
    PhotoView * _photo3;
    PhotoView * selectPhoto;
    ImageButton * positive;
    ImageButton * moderate;
    ImageButton * negative;
}
@end
@implementation EvaluateContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _goodsImage = [[UIImageView alloc] initWithImage:nil];
        _text = [[PlaceholderTextView alloc] init];
        _text.delegate = self;
        _text.placeholder = @"请写下对宝贝的感觉，对他人的帮助很大哦！";
        _photo1 = [[PhotoView alloc] initWithImage:nil];
        _photo2 = [[PhotoView alloc] initWithImage:nil];
        _photo3 = [[PhotoView alloc] initWithImage:nil];
        _photo1.delegate = self;
        _photo2.delegate = self;
        _photo3.delegate = self;
        _photo1.tag = 101;
        _photo3.tag = 103;
        _photo2.tag = 102;
        _photo1.evaluate = YES;
        _photo2.evaluate = YES;
        _photo3.evaluate = YES;
        _photo1.image = [UIImage imageNamed:@"xiangji"];
        [self.contentView addSubview:_goodsImage];
        [self.contentView addSubview:_text];
        [self.contentView addSubview:_photo1];
        [self.contentView addSubview:_photo2];
        [self.contentView addSubview:_photo3];
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout
{
    positive = [[ImageButton alloc] init];
    moderate = [[ImageButton alloc] init];
    negative = [[ImageButton alloc] init];
    positive.delegate = self;
    moderate.delegate = self;
    negative.delegate = self;
    [positive setImage:[UIImage imageNamed:@"zhongping"] selectImage:[UIImage imageNamed:@"haoping"] title:@"好评"];
    [moderate setImage:[UIImage imageNamed:@"zhongping"] selectImage:[UIImage imageNamed:@"haoping"] title:@"中评"];
    [negative setImage:[UIImage imageNamed:@"huichanping"] selectImage:[UIImage imageNamed:@"chaping"] title:@"差评"];
    positive.selectTextColor = [UIColor colorWithString:@"#FD5401"];
    moderate.selectTextColor = positive.selectTextColor;
    negative.selectTextColor = positive.selectTextColor;
    UIView * line = [UIView new];
    line.backgroundColor = [UIColor colorWithString:@"#cccccc"];
    [self.contentView addSubview:positive];
    [self.contentView addSubview:moderate];
    [self.contentView addSubview:negative];
    [self.contentView addSubview:line];
    __weak typeof(self) weakSelf = self;
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.contentView).mas_offset(kScaleHeight(10));
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(75), kScaleWidth(75)));
    }];
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsImage.mas_top);
        make.left.equalTo(_goodsImage.mas_right).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(30));
        make.bottom.greaterThanOrEqualTo(_goodsImage.mas_bottom);
    }];
    [positive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(30));
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(10));
    }];
    [moderate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.bottom.equalTo(positive.mas_bottom);
    }];
    [negative mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(30));
        make.bottom.equalTo(positive.mas_bottom);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.5f);
        make.bottom.equalTo(positive.mas_top).mas_offset(-kScaleHeight(12));
    }];
    [_photo1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsImage.mas_left);
        make.bottom.equalTo(line.mas_top).mas_offset(-kScaleHeight(15));
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(65), kScaleWidth(65)));
    }];
    [_photo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_photo1);
        make.left.equalTo(_photo1.mas_right).mas_offset(kScaleWidth(15));
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(65), kScaleWidth(65)));
    }];
    [_photo3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_photo2.mas_right).mas_offset(kScaleWidth(15));
        make.top.bottom.equalTo(_photo1);
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(65), kScaleWidth(65)));
    }];
//    selectedButton = positive;
//    selectedButton.select = YES;
}
#pragma mark - textViewDelegate
- (void)placeholderTextViewContent:(NSString *)content
{
    if([_delegate respondsToSelector:@selector(evaluateCell:Text:)])
    {
        [_delegate evaluateCell:self Text:content];
    }
    _contentModel.evluateInfo = content;
}
#pragma mark - other Delegate
- (void)imageButton:(ImageButton *)sender
{

    if([sender isEqual:positive])
    {
        _contentModel.buyVal = 1;
    }
    if([sender isEqual:moderate])
    {
        _contentModel.buyVal = 0;
    }
    if([sender isEqual:negative])
    {
        _contentModel.buyVal = -1;
    }
    selectedButton.select = NO;
    sender.select = !sender.select;
    selectedButton = sender;
    if([_delegate respondsToSelector:@selector(evaluateTypeCell:WithType:)])
    {
        [_delegate evaluateTypeCell:self WithType:_contentModel.buyVal];
    }
}
- (void)photoClickWithPhoto:(PhotoView *)photo
{
    if([_delegate respondsToSelector:@selector(evaluateContent:photoIndex:)])
    {
        selectPhoto = photo;
        [_delegate evaluateContent:self photoIndex:photo.tag];
    }
}
- (void)setPhotoSelectImage:(UIImage *)image imagePath:(NSString *)imagePath tag:(NSInteger)tag
{
    selectPhoto.image = image;
    _contentModel.images = [self.allImage mutableCopy];
    if(selectPhoto.tag == 103) return;
    PhotoView * photo = [self viewWithTag:selectPhoto.tag+1];
    if(photo.photo) return;
    photo.image = [UIImage imageNamed:@"xiangji"];
}
- (NSArray *)allImage
{
    NSArray * arr = @[_photo1,_photo2,_photo3];
    NSMutableArray * images = [@[] mutableCopy];
    for (PhotoView * obj in arr) {
        if(obj.photo)
        {
            [images addObject:obj.photo];
        }
    }
    return images;
}
- (void)setModel:(OrderGoodsModel *)model
{
    _model = model;
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:model.goodsMainPhotos] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
}
- (void)setContentModel:(EvalutionDetialModel *)contentModel
{
    _contentModel = contentModel;
    _text.text = contentModel.evluateInfo;
    // 好评 ＝ 1  中评＝ 0  －1 ＝ 差评
    switch (contentModel.buyVal) {
        case 1:
        {
            selectedButton.select = NO;
            positive.select = !positive.select;
            selectedButton = positive;
        }
            break;
        case 0:
        {
            selectedButton.select = NO;
            moderate.select = !moderate.select;
            selectedButton = moderate;
        }
            break;
        case -1:
        {
            selectedButton.select = NO;
            negative.select = !negative.select;
            selectedButton = negative;
        }
            break;
        default:
            break;
    }
    
}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= kScaleHeight(10);
    [super setFrame:frame];
}
@end
