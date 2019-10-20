//
//  OrderValuationDetailsCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderValuationDetailsCell.h"
#import "ComplaintsContentCell.h"
#import "OrdereValuationDetailsViewController.h"
#import "ShowImagesView.h"

@implementation OrderValuationDetailsCell
{
    UIImageView * _iconImage;
    UILabel * _buyerLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _iconImage = [[UIImageView alloc] init];
        _buyerLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_iconImage];
        [self.contentView addSubview:_buyerLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    _buyerLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    _buyerLabel.textColor = [UIColor colorWithString:@"#333333"];
    __weak typeof(self) weakSelf = self;
    _iconImage.layer.borderWidth = 1;
    _iconImage.layer.cornerRadius = kScaleWidth(15);
    _iconImage.layer.masksToBounds = YES;
    _iconImage.layer.borderColor = [UIColor colorWithString:@"#cccccc120"].CGColor;
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(30), kScaleWidth(30)));
        make.left.top.equalTo(weakSelf.contentView).mas_offset(kScaleWidth(10));
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleWidth(10));
    }];
    [_buyerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconImage);
        make.left.equalTo(_iconImage.mas_right).mas_offset(kScaleWidth(10));
    }];
  
}
- (void)setModel:(OrdereValuationDetailsModel *)model
{
    _buyerLabel.text = model.userName;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.userIcon] placeholderImage:[UIImage imageNamed:@"touxiang"]];
}
@end

@interface OrderValuationInfoCell ()<PhotoViewsDelegate>

@end
@implementation OrderValuationInfoCell
{
    PhotoView * _goodsImage;
    UILabel * _goodsNameLabel;
    UILabel * _evaluate;
    UILabel * _evaluateInfo;
    PhotoViews * _evaluateImages;
    UILabel * _dateLabel;
    MASConstraint * _imagesHeight;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _goodsImage = [[PhotoView alloc] init];
        _goodsNameLabel = [[UILabel alloc] init];
        _evaluate = [[UILabel alloc] init];
        _evaluateInfo = [[UILabel alloc] init];
        _evaluateImages = [[PhotoViews alloc] init];
        _dateLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_goodsNameLabel];
        [self.contentView addSubview:_goodsImage];
        [self.contentView addSubview:_evaluateImages];
        [self.contentView addSubview:_evaluateInfo];
        [self.contentView addSubview:_evaluate];
        [self.contentView addSubview:_dateLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    _evaluateImages.show = YES;
    _evaluateImages.delegate = self;
    _evaluateInfo.numberOfLines = 2;
    _goodsNameLabel.textColor = [UIColor colorWithString:@"#051B28"];
    _goodsNameLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    _evaluate.textColor = [UIColor colorWithString:@"#C90C1E"];
    _evaluate.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    _evaluateInfo.textColor = [UIColor colorWithString:@"#333333"];
    _evaluateInfo.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    _dateLabel.textColor = [UIColor colorWithString:@"#999999"];
    _dateLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(11)];
    __weak typeof(self) weakSelf = self;
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScaleWidth(40), kScaleWidth(40)));
        make.top.left.equalTo(weakSelf.contentView).mas_offset(kScaleWidth(10));
    }];
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_goodsImage);
        make.left.equalTo(_goodsImage.mas_right).mas_offset(kScaleWidth(10));
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(10));
    }];
    [_evaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsImage.mas_left);
        make.top.equalTo(_goodsImage.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_evaluateInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsImage.mas_left);
        make.top.equalTo(_evaluate.mas_bottom).mas_offset(kScaleHeight(15));
        make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(5));
    }];
    [_evaluateImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.contentView);
        _imagesHeight = make.height.mas_equalTo(kScaleHeight(85));
        make.top.equalTo(_evaluateInfo.mas_bottom).mas_offset(kScaleHeight(15));
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodsImage.mas_left);
        make.top.equalTo(_evaluateImages.mas_bottom).mas_offset(kScaleHeight(8));
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(20));
    }];
}

- (void)photoViews:(PhotoViews *)view showRect:(CGRect)rect index:(NSInteger)index photo:(UIView *)photo
{
    ShowImagesView * showImage = [[ShowImagesView alloc] init];
    showImage.currentIndex = index;
    showImage.imagesPath = view.imagePaths;
    showImage.selectView = photo;
    [showImage present];
}

- (void)setModel:(OrdereValuationGoodsModel *)model
{
    NSArray * temp = @[model.imag1,model.imag2,model.imag3];
    NSMutableArray * images = [@[] mutableCopy];
    for (NSString * imageStr in temp) {
        if(imageStr.length != 0 && ![imageStr isKindOfClass:[NSNull class]])
        {
            [images addObject:imageStr];
        }
    }
    if(images.count == 0)
    {
        _evaluateImages.hidden = YES;
        _imagesHeight.mas_equalTo(1);
    }else
    {
        _evaluateImages.hidden = NO;
        _imagesHeight.mas_equalTo(kScaleHeight(85));
    }
    NSString * evaluateText = nil;
    // 好评 = 1  中评 = 0  -1 = 差评
    switch (model.evaluateBuyerVal) {
        case 1:
            evaluateText = LaguageControl(@"好评");
            break;
        case -1:
            evaluateText = LaguageControl(@"差评");
            break;
        default:
            evaluateText = LaguageControl(@"中评");
            break;
    }
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:model.goodsIcon] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    _dateLabel.text = model.addTime;
    _evaluateImages.imagePaths = images;
    _evaluateInfo.text = ([model.evaluateInfo isKindOfClass:[NSNull class]] || model.evaluateInfo.length == 0 || model.evaluateInfo == nil)?LaguageControl(@"没有填写评价!"):model.evaluateInfo;
    _goodsNameLabel.text = model.goodsName;
    _evaluate.text = evaluateText;
}
@end
