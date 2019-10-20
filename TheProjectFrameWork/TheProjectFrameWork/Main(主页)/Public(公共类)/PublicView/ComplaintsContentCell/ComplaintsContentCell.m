//
//  ComplaintsContentCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ComplaintsContentCell.h"
#import "ComplaintItemsView.h"
@interface ComplaintsContentCell ()<UITextViewDelegate,UITextFieldDelegate>
{
    UILabel * _subjectLabel;
    UITextView * _contentTextView;
}
@end

@implementation ComplaintsContentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self setup];
    }
    return self;
}
- (void)setup
{
    UILabel * subject = [[UILabel alloc] initWithText:LaguageControlAppend(@"投诉主题")];
    UILabel * content = [[UILabel alloc] initWithText:LaguageControlAppend(@"投诉内容")];
    UIView * line1 = [UIView new];
    UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
    _subjectLabel = [[UILabel alloc] initWithText:nil];
    _contentTextView = [[UITextView alloc] init];
    _contentTextView.font = content.font;
    _contentTextView.delegate = self;
    [_contentTextView setContentInset:UIEdgeInsetsMake(-10, 0, 0, 0)];
    line1.backgroundColor = [UIColor colorWithString:@"#cccccc"];
    subject.textColor = [UIColor colorWithString:@"#808080"];
    content.textColor = subject.textColor;
    _subjectLabel.textColor = [UIColor colorWithString:@"#333333"];
    _subjectLabel.textAlignment = NSTextAlignmentLeft;
    _contentTextView.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:subject];
    [self.backView addSubview:content];
    [self.backView addSubview:line1];
    [self.backView addSubview:image];
    [self.backView addSubview:_subjectLabel];
    [self.backView addSubview:_contentTextView];
    __weak typeof(self) weakSelf = self;
    [subject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(5));
        make.top.equalTo(weakSelf.backView.mas_top).mas_offset(kScaleHeight(10));
        make.width.mas_equalTo(80);
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.backView);
        make.height.mas_equalTo(0.6f);
        make.top.equalTo(subject.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subject.mas_left);
        make.top.equalTo(line1.mas_bottom).mas_offset(kScaleHeight(10));
        make.width.equalTo(subject.mas_width);
    }];
    [_subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subject.mas_right).mas_offset(kScaleWidth(5));
        make.right.equalTo(image.mas_right).mas_offset(-kScaleWidth(10));
        make.centerY.equalTo(subject);
        make.top.bottom.equalTo(subject);
    }];

    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(content.mas_top);
        make.bottom.equalTo(weakSelf.backView.mas_bottom);
        make.left.equalTo(content.mas_right).mas_offset(kScaleWidth(5));
        make.right.equalTo(weakSelf.backView.mas_right);
        make.height.mas_equalTo(kScaleHeight(80));
        make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(5)).priority(750);
    }];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subject);
        make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(10));
    }];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectComplaintsSubject)];
    _subjectLabel.userInteractionEnabled = YES;
    [_subjectLabel addGestureRecognizer:tap];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChangeText) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textViewChangeText
{
    if([_delegate respondsToSelector:@selector(complaintContentWithContent:)])
    {
        [_delegate complaintContentWithContent:_contentTextView.text];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangText) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)textFieldChangText
{
    if([_delegate respondsToSelector:@selector(complaintDescribeWithDescribe:)])
    {
//        [_delegate complaintDescribeWithDescribe:_describeTextField.text];
    }
}
- (void)selectComplaintsSubject
{
    if([_delegate respondsToSelector:@selector(complaintsSubjectSelectWithCell:)])
    {
        [_delegate complaintsSubjectSelectWithCell:self];
    }
}

- (void)complaintItemWithTitle:(NSString *)title row:(NSInteger)row
{
    [_subjectLabel setText:title];
    _subjectTitle = title;
    _subjectRow = row - 1;
}

@end




@interface ShootingPhotoCell ()<PhotoViewsDelegate>
{
    UILabel * promptLabel;
    PhotoViews * photos;
}
@end
@implementation ShootingPhotoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        NSString * prompt =LaguageControlAppend(@"取证图片");
        promptLabel = [[UILabel alloc] initWithText:prompt];
        promptLabel.textColor = [UIColor colorWithString:@"#808080"];
        photos = [[PhotoViews alloc] init];
        photos.delegate = self;
        [self.backView addSubview:promptLabel];
        [self.backView addSubview:photos];
        CGSize labelSize = [prompt sizeWithAttributes:@{NSFontAttributeName:promptLabel.font}];
        __weak typeof(self) weakSelf = self;
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(labelSize.width+ kScaleWidth(5));
            make.top.left.equalTo(weakSelf.backView).mas_offset(kScaleHeight(8));
        }];
        [photos mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(promptLabel.mas_top);
            make.left.equalTo(promptLabel.mas_right);
            make.right.equalTo(weakSelf.backView.mas_right);
            make.height.mas_equalTo(kScaleHeight(70));
            make.bottom.equalTo(weakSelf.backView.mas_bottom).mas_offset(-kScaleHeight(10));
        }];
      
        
    }
    return self;
}
- (NSArray *)allImages
{
    return photos.allImage;
}
- (void)PhotoViews:(PhotoViews *)view tag:(NSInteger)tag residual:(NSInteger)residual
{
    if([_delegate respondsToSelector:@selector(shootPhoto:tag:residual:)])
    {
        [_delegate shootPhoto:self tag:tag residual:residual];
    }
}
- (void)setPhotoImage:(UIImage *)image
{
    [photos setSelectPhotoImage:image];
}

@end


@interface PhotoView ()
{
    UITapGestureRecognizer * _tap;
    UIImage * _defaultImage;
    UIImage * _loadImage;
}
@end
@implementation PhotoView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if(self)
    {
        self.userInteractionEnabled = YES;
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    }
    return self;
}

- (void)clickImage
{
    if([_delegate respondsToSelector:@selector(photoClickWithPhoto:)])
    {
        [_delegate photoClickWithPhoto:self];
    }
}
- (void)setImage:(UIImage *)image
{
    self.layer.borderWidth = 0.5f;
    if(!_defaultImage)
    {
        _defaultImage = [UIImage imageNamed:@"xiangji"];
    }
    if(!_loadImage)
    {
        _loadImage = [UIImage imageNamed:@"defaultImgForGoods"];
    }
    if(image)
    {
        self.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
        if(_tap)
        {
            [self addGestureRecognizer:_tap];
        }
        if(!([image isEqual:_defaultImage] || [image isEqual:_loadImage]))
        {
            _photo = image;
        }
    }else
    {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        [self removeGestureRecognizer:_tap];
    }
    [super setImage:image];
}
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    if(!userInteractionEnabled)
    {
        self.image = [UIImage imageNamed:@"defaultImgForGoods"];
    }else
    {
        self.image = [UIImage imageNamed:@"xiangji"];
    }
}
- (void)setEvaluate:(BOOL)evaluate
{
    _evaluate = evaluate;
    if(_evaluate)
    {
        self.image = nil;
    }
}
@end


@interface PhotoViews ()<PhotoViewDelegate>
{
    PhotoView * one;
    PhotoView * two;
    PhotoView * three;
    PhotoView * selectPhoto;
}
@end
@implementation PhotoViews
- (instancetype)initWithPhotos:(NSArray *)array
{
    self = [super init];
    if(self)
    {
        self.userInteractionEnabled = NO;
        NSInteger tag = 101;
        [array enumerateObjectsUsingBlock:^(UIImage *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PhotoView * view = [self viewWithTag:tag+idx];
            view.image = obj;
        }];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        PhotoView * oneImage = [[PhotoView alloc] initWithImage:nil];
        PhotoView * twoImage = [[PhotoView alloc] initWithImage:nil];
        PhotoView * threeImage = [[PhotoView alloc] initWithImage:nil];
        [self addSubview:oneImage];
        [self addSubview:twoImage];
        [self addSubview:threeImage];
        __weak typeof(self) weakSelf = self;
        [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
            make.width.equalTo(oneImage.mas_height);
            make.top.equalTo(weakSelf.mas_top);
        }];
        [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.lessThanOrEqualTo(oneImage.mas_right).mas_offset(KScreenBoundWidth + 1);
            make.top.equalTo(weakSelf.mas_top);
            make.size.equalTo(oneImage);
            make.centerX.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_bottom);
        }];
        [threeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
            make.size.equalTo(oneImage);
            make.left.lessThanOrEqualTo(twoImage.mas_right).mas_offset(KScreenBoundWidth + 1);
        }];
        oneImage.image = [UIImage imageNamed:@"xiangji"];
        twoImage.image = nil;
        threeImage.image = nil;

        oneImage.tag = 101;
        twoImage.tag = 102;
        threeImage.tag = 103;
        oneImage.delegate = self;
        twoImage.delegate = self;
        threeImage.delegate = self;
        one = oneImage;
        two = twoImage;
        three = threeImage;
    }
    return self;
}
- (void)setSelectPhotoImage:(UIImage *)image;
{
    selectPhoto.image = image;
    if(selectPhoto.tag == 103) return;
    PhotoView * photo = [self viewWithTag:selectPhoto.tag+1];
    if(photo.photo) return;
    photo.image = [UIImage imageNamed:@"xiangji"];
}
- (void)setShow:(BOOL)show
{
    _show = show;
    self.userInteractionEnabled = show;
}
- (void)photoClickWithPhoto:(PhotoView *)photo
{
    selectPhoto = photo;
    if([_delegate respondsToSelector:@selector(PhotoViews:tag:residual:)] && !_show)
    {
        [_delegate PhotoViews:self tag:photo.tag residual:(103-photo.tag)+1];
    }
    if([_delegate respondsToSelector:@selector(photoViews:showRect:index:photo:)] && _show)
    {
        CGRect rect = [photo convertRect:photo.frame toView:self];
        [_delegate photoViews:self showRect:rect index:photo.tag-101 photo:photo];
    }
    
}
- (NSArray *)allImage
{
    NSMutableArray * mutable = [@[]mutableCopy];
    for (PhotoView * photo in self.subviews) {
        if(photo.photo)
        {
            [mutable addObject:photo.photo];
        }
    }
    return [mutable copy];
}
- (void)setNowImages:(NSArray *)nowImages
{
    _nowImages = nowImages;
    self.userInteractionEnabled = NO;
    NSInteger tag = 101;
    [nowImages enumerateObjectsUsingBlock:^(UIImage *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PhotoView * view = [self viewWithTag:tag+idx];
        view.image = obj;
    }];
}
- (void)setImagePaths:(NSArray *)imagePaths
{
    _imagePaths = imagePaths;
    one.image = nil;
    two.image = nil;
    three.image = nil;
    if(imagePaths.count == 0 || imagePaths==nil)
    {
        return;
    }
    if(imagePaths.count == 3)
    {
        [self networkWithUrl:imagePaths[0] PhotoView:one];
        [self networkWithUrl:imagePaths[1] PhotoView:two];
        [self networkWithUrl:imagePaths[2] PhotoView:three];
    }
    if(imagePaths.count == 2)
    {
        [self networkWithUrl:imagePaths[0] PhotoView:one];
        [self networkWithUrl:imagePaths[1] PhotoView:two];
    }
    if(imagePaths.count == 1)
    {
        [self networkWithUrl:imagePaths[0] PhotoView:one];
    }
}
- (void)networkWithUrl:(NSString *)url PhotoView:(PhotoView *)photo
{
    
    if([url isKindOfClass:[NSNull class]])
    {
        return;
    }
    [photo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
}
@end
