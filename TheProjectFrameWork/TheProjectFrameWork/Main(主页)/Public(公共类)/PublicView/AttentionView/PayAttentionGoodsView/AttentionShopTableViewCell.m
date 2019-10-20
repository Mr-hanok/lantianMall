//
//  AttentionShopTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AttentionShopTableViewCell.h"
#import "StarView.h"
#import "AttentGoodsModel.h"

@implementation AttentionShopTableViewCell
{
    StarView * dectStarView;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    if (!dectStarView) {
        dectStarView = [StarView new];
        dectStarView.frame = self.shopLevelView.bounds;
        dectStarView.backgroundColor = [UIColor clearColor];
        dectStarView.fullImage = [UIImage imageNamed:@"level"];
        dectStarView.backImage = [UIImage imageNamed:@""];
        dectStarView.show_star = 3;
        [self.shopLevelView addSubview:dectStarView];
    }
    // Initialization code
}
-(void)loadDateWith:(id)model andindex:(NSIndexPath*)indexPath
{
    AttentGoodsModel * models= model;
    if (kIsChiHuoApp) {
        self.shareButton.hidden = YES;
    }
    self.shopNameLabel.text = models.attentstore_name;
    [dectStarView Setwidtt:15 minWidth:5 showStar:[models.attentstore_credit floatValue]];
    [self.shopIogoImageView sd_setImageWithURL:[NSURL URLWithString:models.attentstore_logo] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    self.indexPath = indexPath;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

/** 删除按钮 */
- (IBAction)delegateButtonClicked:(UIButton *)sender
{
    if ([self.deleagate respondsToSelector:@selector(AttentionView:withIndexPath:)]) {
        [self.deleagate AttentionView:self withIndexPath:self.indexPath];
    }
}
/** 分享按钮 */
- (IBAction)shareButtonClicked:(UIButton *)sender
{
    if ([self.deleagate respondsToSelector:@selector(AttentionViewShareButton:withIndexPath:)]) {
        [self.deleagate AttentionViewShareButton:self withIndexPath:self.indexPath];
    }
}

@end

@implementation NewAttentionShopTableViewCell
{
    UIImageView * _storeIcon;
    UILabel * _storeName;
    StarView * _storelevel;
    UIButton * _shareButton;
    UIButton * _deleteButton;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setep];
    }
    return self;
}

- (void)setep
{
    _storeIcon = [[UIImageView alloc] init];
    _storeName = [[UILabel alloc] init];
    _storelevel = [[StarView alloc] init];
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_storeIcon];
    [self.contentView addSubview:_storeName];
    [self.contentView addSubview:_storelevel];
    [self.contentView addSubview:_shareButton];
    [self.contentView addSubview:_deleteButton];
    
    _storelevel.backgroundColor = [UIColor clearColor];
    _storelevel.fullImage = [UIImage imageNamed:@"level_1"];
    _storelevel.backImage = [UIImage imageNamed:@""];
    _storelevel.show_star = 3;
    _storeName.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    _storeName.textColor = [UIColor colorWithString:@"#333333"];
    _storeName.numberOfLines = 1;
    [_shareButton setBackgroundImage:[UIImage imageNamed:@"shareBig"] forState:UIControlStateNormal];
    [_deleteButton setBackgroundImage:[UIImage imageNamed:@"ic_delete_shopcar"] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    _storeIcon.layer.borderWidth = 1;
    _storeIcon.layer.borderColor = [UIColor colorWithString:@"#cccccc120"].CGColor;
    __weak typeof(self.contentView) weakSelf = self.contentView;
    [_storeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(18));
        make.width.mas_equalTo(kScaleHeight(50));
        make.height.mas_equalTo(kScaleHeight(50));
    }];
    [_storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(18));
        make.left.equalTo(_storeIcon.mas_right).mas_offset(kScaleWidth(10));
        make.right.lessThanOrEqualTo(_shareButton.mas_left).mas_offset(-kScaleWidth(20));
    }];
    [_storelevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(18));
        make.height.mas_equalTo(kScaleHeight(15));
        make.width.mas_equalTo(kScaleWidth(120));
        make.top.equalTo(_storeName.mas_bottom).mas_offset(kScaleHeight(5));
        make.left.equalTo(_storeName.mas_left);
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(_deleteButton.mas_left).mas_offset(-kScaleWidth(12));
        make.size.mas_equalTo((CGSize){18,18});
    }];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(14));
        make.size.mas_equalTo((CGSize){18,18});
    }];
    if (kIsChiHuoApp) {
        _shareButton.hidden = YES;
    }
}
- (void)share
{
    if([_delegate respondsToSelector:@selector(attentionShopTableViewCellShare:)])
    {
        [_delegate attentionShopTableViewCellShare:self];
    }
}
- (void)delete
{
    if([_delegate respondsToSelector:@selector(attentionShopTableViewCellDelete:)])
    {
        [_delegate attentionShopTableViewCellDelete:self];
    }
}

- (void)setModel:(AttentGoodsModel *)model
{
    _model = model;
    _storeName.text = model.attentstore_name;
//    [_storelevel Setwidtt:kScaleHeight(15) minWidth:3 showStar:[model.attentstore_credit floatValue]];
    [_storelevel Setwidtt:kScaleHeight(15) minWidth:3 with:model.attentstore_credit];

    [_storeIcon sd_setImageWithURL:[NSURL URLWithString:model.attentstore_logo] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(ref,kCGLineCapSquare);
    CGContextSetLineWidth(ref, 1.0);
    [[UIColor colorWithString:@"#f0f0f0"] setStroke];
    CGContextBeginPath(ref);
    CGContextMoveToPoint(ref, 0, rect.size.height-1);
    CGContextAddLineToPoint(ref, rect.size.width, rect.size.height-1);
    CGContextStrokePath(ref);
}
@end
