//
//  ShootPhotoViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShootPhotoViewController.h"
#import "TableViewPromptHeaderView.h"
@interface ShootPhotoViewController ()<IDPhotosViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    TableViewPromptHeaderView * _prompt ;
    IDPhotosView * _photos;
    UIButton * _commitButton;
    IdentityPhotoTypes currentSelectType;
}
@end
@implementation ShootPhotoViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadViews];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"拍摄照片";
}
- (void)loadViews
{
    _prompt = [[TableViewPromptHeaderView alloc] init];
    _prompt.text = @"请上传身份证正反面照片、手持证件照";
    _photos = [[IDPhotosView alloc] init];
    _photos.delegate = self;
    _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
    _commitButton.backgroundColor = [UIColor colorWithString:@"#C90C1E"];
    [_commitButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_prompt];
    [self.view addSubview:_photos];
    [self.view addSubview:_commitButton];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;
    [_prompt mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kScaleHeight(10) + kTopSpace);
        make.height.mas_equalTo(kScaleHeight(30));
    }];

    [_photos mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_prompt.mas_bottom).mas_offset(kScaleHeight(10));
         make.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(weakSelf.view.mas_height);
    }];
    [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(kScaleHeight(40));
    }];
}
/**
 *  提交
 */
- (void)commit
{

}
#pragma mark - IDPhotosViewDelegate
/**
 *   返回点击的图片的枚举值
 */
-(void)photoWithType:(IdentityPhotoTypes)type
{
    currentSelectType = type;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_photos photoWithType:currentSelectType image:image];
}
@end




/**********************************/
@interface IDPhotosView ()<PhotosViewDelegate>
{
    PhotosView * _hand;
    PhotosView * _front;
    PhotosView * _back;
}
@end
@implementation IDPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        _hand = [[PhotosView alloc] initWithType:IdentityPhotoTypeHand];
        _front = [[PhotosView alloc] initWithType:IdentityPhotoTypeFront];
        _back = [[PhotosView alloc] initWithType:IdentityPhotoTypeBack];
        _hand.delegate = self;
        _front.delegate = self;
        _back.delegate = self;
        [self addSubview:_hand];
        [self addSubview:_front];
        [self addSubview:_back];
        [self setup];
    }
    return self;
}
- (void)setup
{
    UILabel * hand = [[UILabel alloc] initWithText:@"手持证件照"];
    UILabel * front = [[UILabel alloc] initWithText:@"身份证正面"];
    UILabel * back = [[UILabel alloc] initWithText:@"身份证背面"];
    hand.textColor = [UIColor colorWithString:@"#333333"];
    front.textColor = hand.textColor;
    back.textColor = hand.textColor;
    [self addSubview:hand];
    [self addSubview:front];
    [self addSubview:back];
    __weak typeof(self) weakSelf = self;
    [_hand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
        make.height.equalTo(_hand.mas_width);
    }];
    [_front mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hand.mas_top);
        make.left.equalTo(_hand.mas_right).mas_offset(kScaleWidth(10));
        make.size.equalTo(_hand);
    }];
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hand.mas_top);
        make.left.equalTo(_front.mas_right).mas_offset(kScaleWidth(10));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
        make.size.equalTo(_hand);
    }];
    [hand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_hand);
        make.top.equalTo(_hand.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [front mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_front);
        make.top.equalTo(_front.mas_bottom).mas_offset(kScaleHeight(10));
    }];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_back);
        make.top.equalTo(_back.mas_bottom).mas_offset(kScaleHeight(10));
    }];
}
- (void)photoWithType:(IdentityPhotoTypes)type
                image:(UIImage *)image
{
    switch (type) {
        case IdentityPhotoTypeHand:
            _hand.image = image;
            _hand.photoImage = image;
            break;
        case IdentityPhotoTypeFront:
            _front.image = image;
            _front.image = image;
            break;
        case IdentityPhotoTypeBack:
            _back.image = image;
            _back.image = image;
            break;
        default:
            break;
    }
}
#pragma mark - PhotosViewDelegate
- (void)photos:(PhotosView *)photo
{
    if([_delegate respondsToSelector:@selector(photoWithType:)])
    {
        [_delegate photoWithType:photo.type];
    }
}
@end
/**********************************/
@implementation PhotosView
- (instancetype)initWithType:(IdentityPhotoTypes)type
{
    self = [super init];
    if(self)
    {
        self.type = type;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)setType:(IdentityPhotoTypes)type
{
    _type = type;
    switch (type) {
        case IdentityPhotoTypeBack:
            self.image = [UIImage imageNamed:@"fanmianzheng"];
            break;
        case IdentityPhotoTypeFront:
            self.image = [UIImage imageNamed:@"zhengmianzheng"];
            break;
        case IdentityPhotoTypeHand:
            self.image = [UIImage imageNamed:@"shouchi"];
            break;
        default:
            break;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(photos:)])
    {
        [_delegate photos:self];
    }
}
@end