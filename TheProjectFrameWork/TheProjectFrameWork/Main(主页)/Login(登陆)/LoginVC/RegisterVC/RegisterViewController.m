//
//  RegisterViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTableViewCell.h"
#import "AppAsiaShare.h"
static NSString * RegisterTableViewCellId = @"RegisterTableViewCell";
@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , weak) UITableView * registerWayTableView;

@property (nonatomic , strong) NSArray * dataArray;
@end

@implementation RegisterViewController
#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadLoginView];
}
- (void)loadLoginView
{
    [self.registerWayTableView reloadData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [LaguageControl languageWithString:@"注册方式"];
}
#pragma mark - tableviewDelegate && DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegisterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RegisterTableViewCellId];
    [cell setText:self.dataArray[indexPath.row][@"text"] detailText:self.dataArray[indexPath.row][@"detail"]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScaleHeight(80);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableClickRegisterWayWithIndex:indexPath.row];
}
#pragma mark - event
- (void)tableClickRegisterWayWithIndex:(NSInteger)index
{
    /**
     *  0. 邮箱注册
     *  1. 手机号注册
     *  2. facebook注册
     *  3. google注册
     */
    RegisterTypes type ;
    if(index == 0)
    {
        type = kRegisterTypeEmail;
        [self performSegueWithIdentifier:@"DetailedRegister" sender:@(type)];

    }
    if(index == 1)
    {
        type = kRegisterTypePhone;
        [self performSegueWithIdentifier:@"DetailedRegister" sender:@(type)];
    }
    if(index == 2)
    {
        if([AppAsiaShare isClientInstalledFaceBook])
        {
       
        }else
        {
            [HUDManager showWarningWithText:@"你没有安装facebook!"];
        }
    }
  
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DetailedRegister"])
    {
        id vc = segue.destinationViewController;
        [vc setValue:sender forKey:@"registerType"];
    }
}
#pragma mark - setter Method
- (UITableView *)registerWayTableView
{
    if(!_registerWayTableView)
    {
        UITableView * tableview = [[UITableView alloc] init];
        [self.view addSubview:tableview];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.separatorColor = [UIColor clearColor];
        [tableview registerClass:[RegisterTableViewCell class] forCellReuseIdentifier:RegisterTableViewCellId];
        __weak typeof(self) weakSelf = self;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
        tableview.tableFooterView = [UIView new];
        tableview.backgroundColor = [UIColor clearColor];
        _registerWayTableView = tableview;
    }
    return _registerWayTableView;
}
- (NSArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = @[@{@"text":[LaguageControl languageWithString:@"邮箱注册"],@"detail":[LaguageControl languageWithString:@"*通过您的邮箱账户注册"]},@{@"text":[LaguageControl languageWithString:@"手机号注册"],@"detail":[LaguageControl languageWithString:@"*通过您的手机号注册"]},/*@{@"text":[LaguageControl languageWithString:@"facebook注册"],@"detail":[LaguageControl languageWithString:@"*通过您的facebook账户注册"]},@{@"text":@"Google注册",@"detail":@"**通过您的Google账户注册"}*/];
    }
    return _dataArray;
}
@end
