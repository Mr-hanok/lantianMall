//
//  AllOrdersViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AllOrdersViewController.h"
#import "AllOrderDetialViewController.h"
#import "TosendGoodsViewController.h"
#import "ToPaymentViewController.h"
#import "ToAcceptViewController.h"
#import "ToEvaluationViewController.h"
#import "WalletDetailsTitleView.h"
#import "LookDetialViewController.h"
#import "ArefundOrderViewController.h"

@interface AllOrdersViewController ()<UIScrollViewDelegate,WalletDetailsUnfoldViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView * clickedView;

@property (weak, nonatomic) IBOutlet UIButton *Allbutton;

@property (weak, nonatomic) IBOutlet UIButton *TosendGoodsButton;

@property (weak, nonatomic) IBOutlet UIButton *TopaymentButton;

@property (weak, nonatomic) IBOutlet UIButton *ToEvaluationButton;

@property (weak, nonatomic) IBOutlet UIButton *ToAcceptButton;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property(strong,nonatomic) AllOrderDetialViewController * allOrderview;

@property(strong,nonatomic) TosendGoodsViewController * sendView;

@property(strong,nonatomic) ToPaymentViewController * payView;

@property(strong,nonatomic) ToAcceptViewController *accept;

@property(strong,nonatomic) ToEvaluationViewController * evaluation;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;


@property (nonatomic , strong) WalletDetailsTitleView * titleView;

@property (nonatomic , weak) WalletDetailsUnfoldView * unfoldView;

@property(strong,nonatomic) UIViewController * ShowView;

@property(assign,nonatomic) NSInteger reloadBegin;


@end

@implementation AllOrdersViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clickedView.backgroundColor = kNavigationColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:kIsChiHuoApp? @"wareInfo_more_search" : @"sousuo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchBarSelected)];
    
    [self.Allbutton setTitle:LaguageControl(@"全部") forState:UIControlStateNormal];
     [self.TopaymentButton setTitle:LaguageControl(@"待付款") forState:UIControlStateNormal];
    [self.TosendGoodsButton setTitle:LaguageControl(@"待发货") forState:UIControlStateNormal];
    [self.ToAcceptButton setTitle:LaguageControl(@"待收货") forState:UIControlStateNormal];
    [self.ToEvaluationButton setTitle:LaguageControl(@"已收货") forState:UIControlStateNormal];
    [self.titleView addTarget:self action:@selector(clickTitleWithButton:) forControlEvents:UIControlEventTouchUpInside];
    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.Allbutton.titleLabel.font = KSystemFont(11);
        self.ToAcceptButton.titleLabel.font = KSystemFont(11);
        self.TopaymentButton.titleLabel.font = KSystemFont(11);
        self.TosendGoodsButton.titleLabel.font = KSystemFont(11);
        self.ToEvaluationButton.titleLabel.font = KSystemFont(11);
    }    
    self.allOrderview = [[AllOrderDetialViewController alloc] init];
//    self.allOrderview.isSearch = YES;
    self.allOrderview.FatherVC = self;

    self.allOrderview.view.frame =CGRectMake(0, 0, self.scrollerView.frame.size.width, self.scrollerView.frame.size.height);
    
    self.payView = [[ToPaymentViewController alloc] init];
    self.payView.FatherVC = self;
    self.payView.view.frame = CGRectMake(KScreenBoundWidth*1, 0, self.scrollerView.frame.size.width, self.scrollerView.frame.size.height);

    self.sendView = [[TosendGoodsViewController alloc] init];
    self.sendView.FatherVC = self;
    self.sendView.view.frame= CGRectMake(KScreenBoundWidth*2, 0, self.scrollerView.frame.size.width, self.scrollerView.frame.size.height);

    self.accept = [[ToAcceptViewController alloc] init];
    self.accept.FatherVC = self;

    self.accept.view.frame =CGRectMake(KScreenBoundWidth*3, 0, self.scrollerView.frame.size.width, self.scrollerView.frame.size.height);

    self.evaluation = [[ToEvaluationViewController alloc] init];
    self.evaluation.FatherVC = self;
    self.evaluation.view.frame = CGRectMake(KScreenBoundWidth*4, 0, self.scrollerView.frame.size.width, self.scrollerView.frame.size.height);
    
    [self.scrollerView addSubview:self.allOrderview.view];
    [self.scrollerView addSubview:self.sendView.view];
    [self.scrollerView addSubview:self.payView.view];
    [self.scrollerView addSubview:self.accept.view];
    [self.scrollerView addSubview:self.evaluation.view];
    
    self.scrollerView.scrollEnabled = NO;
    //设置在拖拽的时候是否显示滚动条
    self.scrollerView.contentSize = CGSizeMake(KScreenBoundWidth*5, 1);
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.delegate = self;
    self.reloadBegin = 100;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
   
    self.tabBarController.tabBar.hidden =YES;
//    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.buttonView.mas_bottom);
//        make.left.right.bottom.mas_equalTo(self.view);
//    }];

        switch (self.reloadBegin)
        {
            case 100:
                [self.allOrderview updateHeadView];
                break;
            case 101:
                [self.payView updateHeadView];
                
                break;
            case 102:
                [self.sendView updateHeadView];
                
                break;
            case 103:
                [self.accept updateHeadView];
                
                break;
            case 104:
                [self.evaluation updateHeadView];
                break;
            default:
                break;
        }
        
}
-(void)searchBarSelected
{
    AllOrderDetialViewController * view =  [AllOrderDetialViewController new];
    view.hidesBottomBarWhenPushed = YES;
    view.isSearch = YES;
    [self.navigationController pushViewController:view animated:YES];
    
}
-(void)backToPresentViewController
{
    if (self.isBuyer)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        [super backToPresentViewController];
    }
}
- (void)clickTitleWithButton:(WalletDetailsTitleView *)sender
{
    sender.selected = !sender.selected;
    if(_unfoldView)
    {
        [self.unfoldView fold];
        return;
    }
    [self.unfoldView unfold];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 */
- (IBAction)buttonClicked:(UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        self.clickedView.center = CGPointMake(sender.center.x, self.clickedView.center.y);
    } completion:^(BOOL finished) {

    }];
    
    [self.scrollerView scrollRectToVisible:CGRectMake((sender.tag-100)*KScreenBoundWidth, 0, KScreenBoundWidth, self.scrollerView.frame.size.height) animated:YES];
    self.reloadBegin = sender.tag;
    switch (sender.tag)
    {
        case 100:
            [self.allOrderview updateHeadView];
            break;
        case 101:
            [self.payView updateHeadView];

            break;
        case 102:
            [self.sendView updateHeadView];

            break;
        case 103:
            [self.accept updateHeadView];

            break;
        case 104:
            [self.evaluation updateHeadView];
            break;
        default:
            break;
    }

    
}
#pragma mark - otherDelegate
/**
 *  头视图代理
 */
- (void)orderTypeView:(WalletDetailsUnfoldView *)view type:(NSInteger)type title:(NSString *)title
{
    if (type==24) {
        [view fold];
        ArefundOrderViewController * controller = [ArefundOrderViewController new];
        controller.isBuyer = YES;
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else{
        LookDetialViewController * detial = [LookDetialViewController new];
        switch (type) {
            case 0:
                detial.ordertype = OrderTypesAllTypes;
                break;
            case 1:
                detial.ordertype = OrderTypesCanCel;
                
                break;
            case 2:
                detial.ordertype = OrderTypesScuccess;
                
                break;
            case 3:
                detial.ordertype = OrderTypesRefundFailure;
                
                break;
            case 4:
                detial.ordertype = OrderTypesApplyRefunding;
                
                break;
            case 5:
                detial.ordertype = OrderTypesRefundSuccess;
                break;
            default:
                break;
        }
        detial.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detial animated:YES];
    }

}
#pragma mark - setter and getter
- (WalletDetailsTitleView *)titleView
{
    if(!_titleView)
    {
        WalletDetailsTitleView * titleView = [[WalletDetailsTitleView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
        [titleView setTitle:[LaguageControl languageWithString:@"全部订单"] forState:UIControlStateNormal];
        
        [titleView setImage:[UIImage imageNamed:@"sanjiao"] forState:UIControlStateNormal];
        self.navigationItem.titleView = titleView;
        _titleView = titleView;
    }
    return _titleView;
}
- (WalletDetailsUnfoldView *)unfoldView
{
    if(!_unfoldView)
    {
        WalletDetailsUnfoldView * view = [[WalletDetailsUnfoldView alloc] initWithItems:@[[LaguageControl languageWithString:@"全部订单"],[LaguageControl languageWithString:@"已完成订单"],[LaguageControl languageWithString:@"已取消订单"],[LaguageControl languageWithString:@"退款记录"]] defaultItemIndex:0];
        view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:view];
        view.delegate = self;
        _unfoldView = view;
    }
    [self.view layoutIfNeeded];
    return _unfoldView;
}
@end
