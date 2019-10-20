//
//  MineRebateViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  我的返利

#import "MineRebateViewController.h"
#import "PropertyView.h"
#import "PropertyDetailsScrollView.h"
#import "MineRebateViewModel.h"

@interface MineRebateViewController ()<PropertyDetailsScrollViewDelegate>
@property (nonatomic , weak) PropertyRebateView * headerView;
@property (nonatomic , weak) PropertyDetailsScrollView * contentView;
@property (nonatomic , strong) MineRebateViewModel * model;
@end
@implementation MineRebateViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.headerView.value = 0;
    self.contentView.backgroundColor = [UIColor whiteColor];
   [self.model getRebateInfoWithType:0 complete:^(id error) {
       if(error)
       {
           [HUDManager showWarningWithError:error];
       }else
       {
        self.headerView.value = [_model.rebate_total floatValue];
        [UserAccountManager shareUserAccountManager].userModel.rebateTotal = self.headerView.value;
        [[UserAccountManager shareUserAccountManager] saveAccountDefaults];
       }
       self.contentView.dataArray = _model.dataArray;
   }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"我的返利");
}
#pragma mark - delegate
- (void)propertyDetailsScrollClickWithType:(NSInteger)type
{
    [self.model getRebateInfoWithType:type complete:^(id error) {
        [HUDManager showWarningWithError:error];
        self.contentView.dataArray = _model.dataArray;
    }];
}
#pragma mark - setter and getter
- (PropertyRebateView *)headerView
{
    if(!_headerView)
    {
        PropertyRebateView * header = [[PropertyRebateView alloc] init];
        [self.view addSubview:header];
        __weak typeof(self) weakSelf = self;
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view.mas_top).mas_offset(kTopSpace);
            make.height.mas_equalTo(kScaleHeight(150));
        }];
        _headerView = header;
    }
    return _headerView;
}
- (PropertyDetailsScrollView *)contentView
{
    if(!_contentView)
    {
        PropertyDetailsScrollView * content = [[PropertyDetailsScrollView alloc] init];
        content.delegate = self;
        [self.view addSubview:content];
        __weak typeof(self) weakSelf = self;
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.left.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.headerView.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        _contentView = content;
    }
    return _contentView;
}
- (MineRebateViewModel *)model
{
    if(!_model)
    {
        _model = [[MineRebateViewModel alloc] init];
    }
    return _model;
}
@end
