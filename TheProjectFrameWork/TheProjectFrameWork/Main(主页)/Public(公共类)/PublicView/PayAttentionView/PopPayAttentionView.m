//
//  PopPayAttentionView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopPayAttentionView.h"

@interface PopPayAttentionView ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation PopPayAttentionView

+(id)loadView{
    PopPayAttentionView * view = [super loadView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapTheView)];
    [view.tapView addGestureRecognizer:tap];
//    view.dataArray =[@[@"全部",@"价格",@"人气",@"销量"] mutableCopy];
    view.dataArray =[@[@"全部",@"价格",@"销量"] mutableCopy];
    view.classTableView.delegate = view;
    view.classTableView.dataSource = view;
    
    return view;
}
-(void)showView
{
    self.isShow = YES;
    [KeyWindow addSubview:self];
    self.frame =kScreenFreameBound;    
    [UIView animateWithDuration:0.3 animations:^{
    } completion:^(BOOL finished) {
    }];
}
-(void)tapTheView
{
    
    [self viewDissMissFromWindow];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

#pragma mark --
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [UITableViewCell new];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (KScreenBoundWidth>320)
    {
        cell.textLabel.font = KSystemFont(13);
    }
    else
    {
        cell.textLabel.font = KSystemFont(11);
    }
    cell.textLabel.text = LaguageControl(self.dataArray[indexPath.row]);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(ClickedWithSection:)]) {
        [self.delegate ClickedWithSection:indexPath.row];
    }
    [self viewDissMissFromWindow];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
