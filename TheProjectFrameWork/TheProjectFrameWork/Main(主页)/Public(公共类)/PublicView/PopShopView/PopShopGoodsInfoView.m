//
//  PopShopGoodsInfoView.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/10.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import "PopShopGoodsInfoView.h"

@implementation PopShopGoodsInfoView
+(id)loadView
{
    PopShopGoodsInfoView * view = [super loadView];
    view.isShow = NO;
    view.tableheadview.frame = CGRectMake(0, 0, KScreenBoundWidth, 44);
    view.tablefootview.frame =CGRectMake(0, 0, KScreenBoundWidth, 49);
    view.tableview.rowHeight = 33;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapTheView)];
    [view.tapView addGestureRecognizer:tap];
    [view.tableview reloadData];
    [view.sureBtn setBackgroundColor:kNavigationColor];
    view.dataArray = [NSMutableArray array];
    return view;
    
}
-(void)tapTheView{
    
    [self viewDissMissFromWindow];
}
-(void)showView{
    self.isShow = YES;
    [KeyWindow addSubview:self];
    [self.tableview reloadData];
    self.frame = CGRectMake(0, KScreenBoundHeight, KScreenBoundWidth, KScreenBoundHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight);
    } completion:^(BOOL finished) {
    }];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, KScreenBoundHeight, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}
- (IBAction)sureBtnAction:(UIButton *)sender {
    [self viewDissMissFromWindow];
}

-(void)loadViewWithShopModel:(GoodsDetialModel*)model
{
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.dataArray removeAllObjects];
    self.tableviewHeight.constant = model.gsf1.count*33 +49+44;
    for (GoodsParameterModel * models in model.gsf1) {
        [self.dataArray addObject:models];
    }
    [self.tableview reloadData];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"goodindforidenfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.textColor = kTextDeepDarkColor;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    }
    GoodsParameterModel * model = self.dataArray[indexPath.row];
    ParameterDetialModel *demodel = [model.parameterDataArray firstObject];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",model.parameterName,demodel.parameterDetialValues?:@""];
    return cell;
}

#pragma mark - UITableViewDelegate
/**设置cell高度*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 33;
}
@end
