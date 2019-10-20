//
//  ComplaintGoodsCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ComplaintGoodsCell.h"
#import "ComplaintsContentCell.h"
#import "PlaceholderTextView.h"
#import "ShootPhotoViewController.h"
#import "GoodsBriefInfoView.h"
#import "DialogueRecordView.h"
#import "ComplaintDetailedModel.h"
#import "NSString+ComplaintsStatus.h"
#import "BuyerOrderModel.h"
#import "ShowImagesView.h"
@interface ComplaintGoodsCell ()<GoodsBriefInfoViewDelegate>
{
    UILabel * _orderLabel;
    UILabel * _dateLabel;
    UILabel * _amountLabel;
    UILabel * _statusLabel;
    UIView * _goods;
}
@end
@implementation ComplaintGoodsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _orderLabel = [[UILabel alloc] initWithText:nil];
        _dateLabel = [[UILabel alloc] initWithText:nil];
        _goods = [[UIView alloc] init];
        _amountLabel = [[UILabel alloc] initWithText:nil];
        _statusLabel = [[UILabel alloc] init];
        [self.backView addSubview:_orderLabel];
        [self.backView addSubview:_statusLabel];
        [self.backView addSubview:_dateLabel];
        [self.backView addSubview:_goods];
        [self.backView addSubview:_amountLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    _orderLabel.textColor = [UIColor colorWithString:@"#333333"];
    _dateLabel.textColor = [UIColor colorWithString:@"#666666"];
    _amountLabel.textColor = [UIColor colorWithString:@"#808080"];
    _statusLabel.textColor = [UIColor colorWithString:@"#C90C1E"];
    _statusLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    __weak typeof(self) weakSelf = self;
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.backView).mas_offset(kScaleWidth(10));
    }];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backView).mas_offset(kScaleWidth(10));
        make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(10));
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderLabel.mas_left);
        make.top.equalTo(_orderLabel.mas_bottom).mas_offset(kScaleHeight(8));
    }];
    [_goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderLabel.mas_left);
        make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(10));
        make.top.equalTo(_dateLabel.mas_bottom).mas_offset(kScaleHeight(5));
    }];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderLabel.mas_left);
        make.top.equalTo(_goods.mas_bottom).mas_offset(kScaleHeight(8));
        make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(13));
    }];
}
- (void)goodsBriefInfoClick:(GoodsBriefInfoView *)view good_id:(NSString *)goodid
{
    if(_delegate && [_delegate respondsToSelector:@selector(complaintGoodsCellClick:good_id:)])
    {
        [_delegate complaintGoodsCellClick:self good_id:goodid];
    }
}

- (void)setModel:(ComplaintDetailedModel *)model
{
    _model = model;
    _orderLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"订单号"],model.of_sn];
    _dateLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"下单时间"],model.addTime];
    _amountLabel.text = [NSString stringWithFormat:@"%@: ￥ %.2f",[LaguageControl languageWithString:@"订单总额"],[model.totalMoney floatValue]];
    
    __block UIView * lastView = nil;
    __weak typeof(_goods) weakSelf = _goods;
    [model.goodsList enumerateObjectsUsingBlock:^(ComplaintGoods * _Nonnull goodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        GoodsBriefInfoView * goods = [[GoodsBriefInfoView alloc] init];
        goods.complaint = goodsModel;
        goods.delegate = self;
        goods.edit = NO;
        [_goods addSubview:goods];
        [goods mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(weakSelf);
            make.height.mas_equalTo(kScaleHeight(120));
            if(lastView)
            {
                make.top.equalTo(lastView.mas_bottom);
            }else
            {
                make.top.equalTo(weakSelf.mas_top);
            }
            lastView = goods;
        }];
    }];
    [lastView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}
- (void)setBuyerOrder:(BuyerOrderModel *)buyerOrder{
    _buyerOrder = buyerOrder;
    _orderLabel.text = [NSString stringWithFormat:@"%@:%@",[LaguageControl languageWithString:@"订单号"],buyerOrder.order_id];
    _dateLabel.text = [NSString stringWithFormat:@"%@:%@",[LaguageControl languageWithString:@"下单时间"],buyerOrder.addTime];
     _amountLabel.text = [NSString stringWithFormat:@"%@:￥ %@",[LaguageControl languageWithString:@"订单总额"],buyerOrder.totalPrice];
}
- (void)setGoodsModel:(NSArray<OrderGoodsModel *> *)goodsModel
{
    _goodsModel = goodsModel;
    [_contentArray removeAllObjects];
    __block UIView * lastView = nil;
    __weak typeof(_goods) weakSelf = _goods;
    [goodsModel enumerateObjectsUsingBlock:^(OrderGoodsModel * _Nonnull goodsModel, NSUInteger idx, BOOL * _Nonnull stop) {
        GoodsBriefInfoView * goods = [[GoodsBriefInfoView alloc] init];
        goods.model = goodsModel;
        goods.delegate = self;
        goods.edit = YES;
        [_goods addSubview:goods];
        [goods mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(weakSelf);
            make.height.mas_equalTo(kScaleHeight(120));
            if(lastView)
            {
                make.top.equalTo(lastView.mas_bottom);
            }else
            {
                make.top.equalTo(weakSelf.mas_top);
            }
            lastView = goods;
        }];
        [self.contentArray addObject:goods];
    }];
    [lastView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
   
}
- (NSMutableArray *)contentArray
{
    if(!_contentArray)
    {
        _contentArray = [@[] mutableCopy];
    }
    return _contentArray;
}
@end


@interface ComplaintDescribeCell ()
{
    UILabel * _titleLabel;
    UILabel * _contextLabel;
}
@end
@implementation ComplaintDescribeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _titleLabel = [[UILabel alloc] init];
        _contextLabel = [[UILabel alloc] init];
        [self.backView addSubview:_titleLabel];
        [self.backView addSubview:_contextLabel];
        _contextLabel.numberOfLines = 0;
        [self setup];
    }
    return self;
}
- (void)setup
{
    __weak typeof(self) weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(5));
        make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleHeight(15));
    }];
    [_contextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).mas_offset(kScaleHeight(5));
        make.right.equalTo(weakSelf.backView.mas_right);
        make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(15));
    }];


}
- (void)setModel:(ComplaintDetailedModel *)model
{
    _model = model;
    NSString * title = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉主题"],model.title];
    NSString * string = [NSString stringWithFormat:@"%@: ",[LaguageControl languageWithString:@"投诉主题"]];
    NSMutableAttributedString * mutalbieTitle = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange range = [title rangeOfString:string];
    [mutalbieTitle addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kAppAsiaFontSize(12)],NSForegroundColorAttributeName:[UIColor colorWithString:@"#333333"]} range:NSMakeRange(0, title.length)];
    [mutalbieTitle addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#666666"]} range:range];
    _titleLabel.attributedText = mutalbieTitle;
    NSString * context = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉内容"],model.fromContent];
    NSString * contentStr = [NSString stringWithFormat:@"%@: ",[LaguageControl languageWithString:@"投诉内容"]];
    NSMutableAttributedString * mutalbieContext = [[NSMutableAttributedString alloc] initWithString:context];
    range = [context rangeOfString:contentStr];
    [mutalbieContext addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kAppAsiaFontSize(12)],NSForegroundColorAttributeName:[UIColor colorWithString:@"#333333"]} range:NSMakeRange(0, context.length)];
    [mutalbieContext addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#666666"]} range:range];
    _contextLabel.attributedText = mutalbieContext;
}
@end


@interface ComplaintStateCell ()<PhotoViewsDelegate>
{
    UILabel * _storeLabel;
    UILabel * _stateLabel;
    UILabel * _typeLabel;
    UILabel * _dateLabel;
    UILabel * _photoPrompt;
    PhotoViews * _image;
}
@end
@implementation ComplaintStateCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _storeLabel = [[UILabel alloc] initWithText:nil];
        _stateLabel = [[UILabel alloc] initWithText:nil];
        _typeLabel = [[UILabel alloc] initWithText:nil];
        _dateLabel = [[UILabel alloc] initWithText:nil];
        _photoPrompt = [[UILabel alloc] initWithText:nil];
        _image = [[PhotoViews alloc] initWithPhotos:nil];
        _image.show = YES;
        _image.delegate = self;
        [self.backView addSubview:_image];
        [self.backView addSubview:_storeLabel];
        [self.backView addSubview:_stateLabel];
        [self.backView addSubview:_typeLabel];
        [self.backView addSubview:_dateLabel];
        [self.backView addSubview:_photoPrompt];
        [self setup];
    }
    return self;
}
- (void)setup
{
    _photoPrompt.text = [NSString stringWithFormat:@"%@:",[LaguageControl languageWithString:@"投诉图片"]];
    CGSize labelSize = [_photoPrompt.text sizeWithAttributes:@{NSFontAttributeName:_photoPrompt.font}];
    _storeLabel.textColor = [UIColor colorWithString:@"#666666"];
    _stateLabel.textColor = _storeLabel.textColor;
    _typeLabel.textColor = _storeLabel.textColor;
    _dateLabel.textColor = _storeLabel.textColor;
    _photoPrompt.textColor = _storeLabel.textColor;
    _photoPrompt.textAlignment = NSTextAlignmentLeft;
 
    __weak __typeof__(self) weakSelf = self;
    [_storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleWidth(5));
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(8));
    }];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_storeLabel.mas_left);
        make.top.equalTo(_storeLabel.mas_bottom).mas_offset(kScaleHeight(8));
    }];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_stateLabel.mas_bottom).mas_offset(kScaleHeight(8));
        make.left.equalTo(_storeLabel.mas_left);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(_typeLabel.mas_bottom).mas_offset(kScaleHeight(8));
        make.left.equalTo(_storeLabel.mas_left);
    }];
    [_photoPrompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateLabel.mas_bottom).mas_offset(kScaleHeight(8));
        make.left.equalTo(_storeLabel.mas_left);
        make.width.mas_equalTo(labelSize.width + 5);
        make.height.mas_equalTo(labelSize.height);
    }];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photoPrompt.mas_top);
        make.right.equalTo(weakSelf.backView.mas_right);
        make.left.equalTo(_photoPrompt.mas_right);
        make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(10));
        make.height.mas_equalTo(kScaleHeight(70));
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
- (void)setModel:(ComplaintDetailedModel *)model
{
    _model = model;
    _storeLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"卖家店铺"],model.storeName];
    _stateLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉状态"],[NSString ComplaintStatus:model.status]];
    BOOL result = [model.type compare:@"SELLER"
                            options:NSCaseInsensitiveSearch |NSNumericSearch] == NSOrderedSame;
    _typeLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉类别"],result?LaguageControl(@"卖家投诉"):LaguageControl(@"买家投诉")];
    _dateLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉时间"],model.addTime];
    NSString * state = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"投诉状态"],[NSString ComplaintStatus:model.status]];
    NSMutableAttributedString * contentString = [[NSMutableAttributedString alloc] initWithString:state];
    [contentString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithString:@"#EC2426"] range:[[contentString string] rangeOfString:[NSString ComplaintStatus:model.status]]];
    _stateLabel.attributedText = contentString;
    _image.imagePaths = @[model.fromPath1?model.fromPath1:[NSNull null],model.fromPath2?model.fromPath2:[NSNull null],model.fromPath3?model.fromPath3:[NSNull null]];
    
}
@end
@interface FillComplaintInfoCell () <PhotoViewsDelegate,PlaceholderTextViewDelegate>

@end
@implementation FillComplaintInfoCell
{
    PlaceholderTextView * complaintContent;
    UILabel * promptLabel;
    PhotoViews * photos;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        UILabel * titleLabel = [[UILabel alloc] init];
        UILabel * contentPrompt = [[UILabel alloc] init];
        promptLabel = [[UILabel alloc] init];
        complaintContent = [[PlaceholderTextView alloc] init];
        titleLabel.textColor = [UIColor colorWithString:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(15)];
        contentPrompt.textColor = [UIColor colorWithString:@"#666666"];
        contentPrompt.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        NSString * prompt = [NSString stringWithFormat:@"%@:",[LaguageControl languageWithString:@"申诉图片"]];
        promptLabel = [[UILabel alloc] initWithText:prompt];
        photos = [[PhotoViews alloc] init];
        photos.delegate = self;
        promptLabel.textColor = [UIColor colorWithString:@"#808080"];
        complaintContent.font = promptLabel.font;
        complaintContent.placeholder = [LaguageControl languageWithString:@"填写您的申诉内容"];
        complaintContent.delegate = self;
        titleLabel.text = [NSString stringWithFormat:@"%@:",[LaguageControl languageWithString:@"填写申诉信息"]];
        contentPrompt.text = [NSString stringWithFormat:@"%@:",[LaguageControl languageWithString:@"申诉内容"]];
        [self.backView addSubview:titleLabel];
        [self.backView addSubview:contentPrompt];
        [self.backView addSubview:complaintContent];
        [self.backView addSubview:promptLabel];
        [self.backView addSubview:photos];
       
        CGSize labelSize = [prompt sizeWithAttributes:@{NSFontAttributeName:promptLabel.font}];
        __weak typeof(self) weakSelf = self;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleHeight(8));
            make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(10));
        }];
        [contentPrompt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).mas_offset(kScaleHeight(16));
            make.left.equalTo(titleLabel.mas_left);
            make.width.mas_equalTo(labelSize.width+ kScaleWidth(5));
        }];
        [complaintContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentPrompt.mas_top).mas_offset(0);
            make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(10));
            make.left.equalTo(contentPrompt.mas_right).mas_offset(kScaleWidth(9));
            make.bottom.equalTo(promptLabel.mas_top).mas_offset(-kScaleHeight(5));
        }];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(labelSize.width+ kScaleWidth(5));
            make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleHeight(8));
            make.top.equalTo(contentPrompt.mas_bottom).mas_offset(kScaleHeight(80));
        }];
        [photos mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(promptLabel.mas_top);
            make.height.mas_equalTo(kScaleHeight(70));
            make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(10));
            make.left.equalTo(promptLabel.mas_right);
            make.right.equalTo(weakSelf.backView.mas_right);
        }];
    }
    return self;
}
- (void)setPhotoImage:(UIImage *)image
{
    [photos setSelectPhotoImage:image];
}
-(void)PhotoViews:(PhotoViews *)view tag:(NSInteger)tag residual:(NSInteger)residual
{
    if([_delegate respondsToSelector:@selector(fillComplaintWithCell:tag:residual:)])
    {
        [_delegate fillComplaintWithCell:self tag:tag residual:residual];
    }
}

- (NSArray *)allImages
{
    return photos.allImage;
}
- (NSString *)appealContent
{
    return complaintContent.text;
}
- (void)placeholderTextViewContent:(NSString *)content
{
    if([_delegate respondsToSelector:@selector(fillComplaintWithCell:appealContent:)])
    {
        [_delegate fillComplaintWithCell:self appealContent:content];
    }
}
@end

@interface AppealInfoCell ()<PhotoViewsDelegate>

@end

@implementation AppealInfoCell
{
    UILabel * appealName;
    UILabel * appealDate;
    UILabel * appealContent;
    PhotoViews * _photos;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        UILabel * title = [[UILabel alloc] init];
        appealName = [[UILabel alloc] init];
        appealDate = [[UILabel alloc] init];
        UILabel * photoPrompt = [[UILabel alloc] init];
        _photos = [[PhotoViews alloc] init];
        appealContent = [[UILabel alloc] init];
        [self.backView addSubview:title];
        [self.backView addSubview:appealName];
        [self.backView addSubview:appealDate];
        [self.backView addSubview:photoPrompt];
        [self.backView addSubview:_photos];
        [self.backView addSubview:appealContent];
        NSString * prompt = [NSString stringWithFormat:@"%@:",[LaguageControl languageWithString:@"申诉图片"]];
        
        title.font = [UIFont systemFontOfSize:(15)];
        title.textColor = [UIColor colorWithString:@"#333333"];
        appealName.textColor = [UIColor colorWithString:@"#666666"];
        appealDate.textColor = appealName.textColor;
        photoPrompt.textColor = appealName.textColor;
        appealContent.textColor = appealName.textColor;
        appealName.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        appealDate.font = appealName.font;
        photoPrompt.font = appealName.font;
        appealContent.font = appealName.font;
        _photos.delegate = self;
        _photos.show = YES;
        CGSize labelSize = [prompt sizeWithAttributes:@{NSFontAttributeName:photoPrompt.font}];
        
        __weak typeof(self) weakSelf = self;
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleHeight(8));
            make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(10));
        }];
        [appealName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_left);
            make.top.equalTo(title.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        [appealDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_left);
            make.top.equalTo(appealName.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        [photoPrompt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_left);
            make.width.mas_equalTo(labelSize.width + kScaleWidth(5));
            make.top.equalTo(appealDate.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        [_photos mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(photoPrompt.mas_top);
            make.right.equalTo(weakSelf.backView.mas_right);
            make.left.equalTo(photoPrompt.mas_right);
            make.height.mas_equalTo(kScaleHeight(70));
        }];
        [appealContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_left);
            make.top.equalTo(_photos.mas_bottom).mas_offset(kScaleHeight(5));
            make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(8));
        }];
        title.text = [LaguageControl languageWithString:@"申诉信息"];
        photoPrompt.text = [LaguageControl languageWithString:prompt];
    }
    return self;
}
- (void)photoViews:(PhotoViews *)view showRect:(CGRect)rect index:(NSInteger)index photo:(UIView *)photo
{
    ShowImagesView * showImage = [[ShowImagesView alloc] init];
    showImage.currentIndex = index;
    showImage.imagesPath = view.imagePaths;
    showImage.selectView = photo;
    [showImage present];
}
- (void)setModel:(ComplaintDetailedModel *)model
{
    _model = model;
    appealName.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"申诉人"],model.storeName];
    appealDate.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"申诉时间"],model.mAppeal.appeal_time];
    appealContent.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"申诉内容"],model.mAppeal.toContent];;
     _photos.imagePaths = @[model.mAppeal.toPath1?model.mAppeal.toPath1:[NSNull null],model.mAppeal.toPath2?model.mAppeal.toPath2:[NSNull null],model.mAppeal.toPath3?model.mAppeal.toPath3:[NSNull null]];
}
@end

@interface DialogueDetailsCell ()<UITableViewDelegate,UITableViewDataSource,DialogueHandleViewDelegate>

@end
static NSString * DialogueItemId = @"DialogueItem";
@implementation DialogueDetailsCell
{
    UILabel * titleLabel;
    UILabel * promptLabel;
    UITableView * tableview;
    NSArray * titlesArr;
    NSArray * contentArr;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        titleLabel = [[UILabel alloc] init];
        promptLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(15)];
        titleLabel.textColor = [UIColor colorWithString:@"#333333"];
        promptLabel.textColor = [UIColor colorWithString:@"#999999"];
        promptLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        titleLabel.numberOfLines = 0;
        tableview = [[UITableView alloc] init];
        tableview.tableFooterView = [UIView new];
        tableview.separatorColor = [UIColor clearColor];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview registerClass:[DialogueItem class] forCellReuseIdentifier:DialogueItemId];
        tableview.estimatedRowHeight = 100;
        [self.backView addSubview:titleLabel];
        [self.backView addSubview:promptLabel];
        [self.backView addSubview:tableview];
        __weak typeof(self) weakSelf = self;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleHeight(8));
            make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(10));
            make.right.lessThanOrEqualTo(weakSelf.backView.mas_right);
        }];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_left);
            make.top.equalTo(titleLabel.mas_bottom).mas_offset(kScaleHeight(25));
        }];
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_left);
            make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(8));
            make.top.equalTo(promptLabel.mas_bottom).mas_offset(kScaleHeight(8));
            make.height.mas_equalTo(kScaleHeight(130));
            make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(kScaleHeight(-30)).priority(750);
        }];
        titleLabel.text = [LaguageControl languageWithString:@"买卖双方对话详情"];
        promptLabel.text = [LaguageControl languageWithString:@"对话记录"];
    }
    return self;
}
#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DialogueItem * item = [tableview dequeueReusableCellWithIdentifier:DialogueItemId];
    item.title = titlesArr[indexPath.row];
    item.contentStr = contentArr[indexPath.row];
    [item setNeedsUpdateConstraints];
    [item updateConstraintsIfNeeded];
    return item;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.talkContent.count;
}
#pragma mark - DialogueHandleViewDelegate
- (void)DialogueHandlePublish
{
    if([_delegate respondsToSelector:@selector(dialogueDetailsPublishWithCell:)])
    {
        [_delegate dialogueDetailsPublishWithCell:self];
    }
}
- (void)DialogueHandleReload
{
    if([_delegate respondsToSelector:@selector(dialogueDetailsReloadWithCell:)])
    {
        [_delegate dialogueDetailsReloadWithCell:self];
    }
}
- (void)DialogueHandleSubmit
{
    if([_delegate respondsToSelector:@selector(dialogueDetailsSubmitWithCell:)])
    {
        [_delegate dialogueDetailsSubmitWithCell:self];
    }
}
#pragma mark - setter and getter
- (void)setIsFinish:(BOOL)isFinish
{
    _isFinish = isFinish;
    if(!isFinish)
    {
        DialogueHandleView * handle = [[DialogueHandleView alloc] init];
        handle.delegate = self;
        handle.waitingArbitration = _model.status == ComplaintManagerWaitArbitrate;
        [self.contentView addSubview:handle];
        __weak typeof(self) weakSelf = self;
        [handle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf.contentView);
            make.top.equalTo(tableview.mas_bottom).mas_offset(kScaleHeight(5));
        }];
        return;
    }
}
- (void)reloadChatRecordWithArr:(NSArray *)arr
{
    _model.talkContent = arr;
    
    [self loadData];
}
- (void)setModel:(ComplaintDetailedModel *)model
{
    _model = model;
    [self loadData];
}
- (void)loadData
{
    if(_model.talkContent == nil || [_model.talkContent isKindOfClass:[NSNull class]]) return;
    if([_model.talkContent isKindOfClass:[NSArray class]])
    {
        if(_model.talkContent.lastObject == nil)
        {
            return;
        }
    }
    NSMutableArray * titles = [@[] mutableCopy];
    NSMutableArray * contents = [@[] mutableCopy];
    [_model.talkContent enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:[obj allKeys][0]];
        [contents addObject:[obj allValues][0]];
    }];
    titlesArr = [titles copy];
    contentArr = [contents copy];
    [tableview reloadData];
}
@end

@implementation ArbitrationInfoCell
{
    UILabel * titleLabel;
    UILabel * adminLabel;
    UILabel * dateLabel;
    UILabel * contentLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
    if(self)
    {
        titleLabel = [[UILabel alloc] init];
        adminLabel = [[UILabel alloc] init];
        dateLabel = [[UILabel alloc] init];
        contentLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(15)];
        titleLabel.textColor = [UIColor colorWithString:@"#333333"];
        titleLabel.text = [LaguageControl languageWithString:@"仲裁信息"];
        [self.backView addSubview:titleLabel];
        [self settingLabel:adminLabel];
        [self settingLabel:dateLabel];
        [self settingLabel:contentLabel];
        __weak typeof(self) weakSelf = self;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleHeight(8));
            make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(10));
        }];
        [adminLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_left);
            make.top.equalTo(titleLabel.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_left);
            make.top.equalTo(adminLabel.mas_bottom).mas_offset(kScaleHeight(6));
        }];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_left);
            make.top.equalTo(dateLabel.mas_bottom).mas_offset(kScaleHeight(6));
            make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(8));
        }];
    }
    return self;
}
- (void)settingLabel:(UILabel *)label
{
    label.textColor = [UIColor colorWithString:@"#333333"];
    label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
    [self.backView addSubview:label];
}
- (void)setModel:(ComplaintDetailedModel *)model
{
    _model = model;
    adminLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"仲裁管理员"],model.mArbitration.handle_name];
    dateLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"仲裁时间"],model.mArbitration.handle_time];
    contentLabel.text = [NSString stringWithFormat:@"%@: %@",[LaguageControl languageWithString:@"仲裁意见"],model.mArbitration.handle_content];
}
@end
