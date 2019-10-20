//
//  RechargeFinishViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RechargeFinishViewController.h"
#import "LoginButton.h"
@interface RechargeFinishViewController ()
{
    RechargeFinishView * _prompt;
    LoginButton * _finish;
}
@end
@implementation RechargeFinishViewController
#pragma mark - life cycle 
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSubViews];
    
}
- (void)loadSubViews
{
    _prompt = [[RechargeFinishView alloc] init];
    _prompt.type = 1;
    _prompt.numberValue = self.money;
    __weak typeof(self) weakSelf = self;
    _finish = [[LoginButton alloc] initWithActionBlock:^(id sender) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf finish];
    } title:@"完成"];
    [_finish settingButtonSelectWithSelected:YES];
    [self.view addSubview:_prompt];
    [self.view addSubview:_finish];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    __weak typeof(self) weakSelf = self;

    [_prompt mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).mas_offset(kTopSpace);
        make.height.mas_equalTo(kScaleHeight(160));
    }];
    [_finish mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).mas_offset(kScaleWidth(12));
        make.right.equalTo(weakSelf.view.mas_right).mas_offset(-kScaleWidth(12));
        make.height.mas_equalTo(kScaleHeight(40));
        make.top.equalTo(_prompt.mas_bottom).mas_offset(kScaleHeight(35));
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"支付成功");
    [self.navigationItem setHidesBackButton:YES];
}

- (void)finish
{
//    if([_delegate respondsToSelector:@selector(rechargeFinish)])
//    {
//        [_delegate rechargeFinish];
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToViewController:self.FatherVC animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end



@interface RechargeFinishView ()
{
    UILabel * promptTypeLabel;
    UILabel * promptValueLabel;
    UILabel * typeLabel;
    UILabel * valueLabel;
}
@end
@implementation RechargeFinishView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dahonggou"]];
        promptTypeLabel = [[UILabel alloc] initWithText:@"支付方式"];
        promptValueLabel = [[UILabel alloc] initWithText:@"充值金额"];
        typeLabel = [[UILabel alloc] initWithText:nil];
        valueLabel = [[UILabel alloc] initWithText:nil];
        [self addSubview:image];
        [self addSubview:promptValueLabel];
        [self addSubview:promptTypeLabel];
        [self addSubview:typeLabel];
        [self addSubview:valueLabel];
        promptTypeLabel.textColor = [UIColor colorWithString:@"#666666"];
        promptValueLabel.textColor = promptTypeLabel.textColor;
        typeLabel.textColor = [UIColor colorWithString:@"#C90C1E"];
        valueLabel.textColor = typeLabel.textColor;
        __weak typeof(self) weakSelf = self;
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(20));
        }];
        [promptTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(image.mas_bottom).mas_offset(kScaleHeight(20));
        }];
        [promptValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(promptTypeLabel.mas_bottom).mas_offset(kScaleHeight(8));

        }];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(promptTypeLabel);
            make.left.equalTo(promptTypeLabel.mas_right).mas_offset(kScaleWidth(5));
        }];
        [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(promptValueLabel);
            make.left.equalTo(promptValueLabel.mas_right).mas_offset(kScaleWidth(5));
        }];
    }
    return self;
}
- (void)setNumberValue:(CGFloat)numberValue
{
    _numberValue = numberValue;
    valueLabel.text = [NSString stringWithFormat:@"%.2f",numberValue];
}
- (void)setType:(NSInteger)type
{
    _type = type;
    typeLabel.text = type?LaguageControl(@"支付宝"): LaguageControl(@"微信");
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc"]setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
}
@end
