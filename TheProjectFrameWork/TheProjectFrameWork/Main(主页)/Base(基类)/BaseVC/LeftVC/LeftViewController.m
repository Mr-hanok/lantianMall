//
//  LeftViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNavBarButton];
    [self loadLeftnavigabarTouchEvent];
}
- (void)loadRrightItemWithTitle:(NSString *)title 
{
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithString:@"#000000100"];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btn.layer.cornerRadius = 5.f;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(rightNaviButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = item;
}
- (void)loadRrightItemWithImage:(NSString *)title{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightNaviButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)rightNaviButtonClick{
    
}
- (void)pushWithVCClass:(Class)vcClass properties:(NSDictionary*)properties {
    id obj = [vcClass new];
    if(properties)
        [obj mj_setKeyValues:properties];
    [self.navigationController pushViewController:obj animated:YES];
}
- (void)pushWithVCClassName:(NSString*)className properties:(NSDictionary*)properties {
    id obj = [NSClassFromString(className) new];
    if(properties)
        [obj mj_setKeyValues:properties];
    [self.navigationController pushViewController:obj animated:YES];
}


@end
