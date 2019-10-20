//
//  BaseSearchViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface BaseSearchViewController ()<UISearchBarDelegate>

@end

@implementation BaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadRightnavigabarTouchEvent{
    
}
-(void)loadNavigabarTitleView{
        if (!self.navigationTitleview)
        {
            self.navigationTitleview = [NavigationBatTitleView loadView];
            self.navigationTitleview.frame = CGRectMake(0, 0, KScreenBoundWidth, 44);
            self.navigationTitleview.buttonWidth.constant = 0;
        }
        self.navigationItem.titleView = self.navigationTitleview;
        self.navigationTitleview.searchBar.layer.cornerRadius = 5;
        self.navigationTitleview.searchBar.layer.masksToBounds = YES;
        self.navigationTitleview.searchBar.backgroundImage = [UIImage new];
        self.navigationTitleview.searchBar.delegate = self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
