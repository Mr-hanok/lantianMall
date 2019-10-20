//
//  ReferrerViewController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/12.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import "ReferrerViewController.h"
#import "ReferrerListCell.h"

@interface ReferrerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation ReferrerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我推荐的人";
    self.array = [NSMutableArray array];
    self.tableview.backgroundColor = kBGColor;
    self.tableview.delegate = self;
    self.tableview.dataSource= self;
    self.tableview.rowHeight = 88;
    [self updataNewData:self.tableview];
    [self beginRefresh];

}

#pragma mark - Refresh
-(void)updateHeadView{
    self.currentPage = 1;
    [self getdataFromServer];
}
-(void)updateFootView{
    [self getdataFromServer];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"ReferrerListCell";
    ReferrerListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ReferrerListCell" owner:nil options:0]lastObject];
    }
    ReferrerModel *model = self.array[indexPath.row];
    [cell.headIV sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:[UIImage imageNamed:@"DefaultAvatar"]];
    cell.timeLabel.text = model.time;
    if (model.name == nil || [model.name isEqualToString:@""]) {
        cell.nameLabel.text= model.mobile;
    }else{
        cell.nameLabel.text= model.name;
    }
    cell.typeLabel.text = model.type?:@"其他";
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - getdata
- (void)getdataFromServer{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kUserId forKey:@"user_id"];
    [params setObject:[[NSNumber numberWithInteger:self.currentPage]stringValue] forKey:@"page"];
    [params setObject:@"10" forKey:@"size"];
    
    WeakSelf(self)
    [NetWork PostNetWorkWithUrl:@"/my_rec_ratio" with:params successBlock:^(NSDictionary *dic) {
        [weakSelf endRefresh];
        NSArray *temarray = [ReferrerModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        __block NSMutableArray *tempresulet = [NSMutableArray array];
        
        [self digui:temarray cengCi:0 resultArray:tempresulet];
        
//        [temarray enumerateObjectsUsingBlock:^(ReferrerModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            obj.type = @"一级分销人";
//            [tempresulet addObject:obj];
//            if (obj.childs.count) {
//                [obj.childs enumerateObjectsUsingBlock:^(ReferrerModel *  _Nonnull obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
//                    obj2.type = @"二级分销人";
//                    [tempresulet addObject:obj2];
//                    if (obj2.childs) {
//                        [obj2.childs enumerateObjectsUsingBlock:^(ReferrerModel *  _Nonnull obj3, NSUInteger idx3, BOOL * _Nonnull stop3) {
//                            obj3.type = @"三级分销人";
//                            [tempresulet addObject:obj3];
//                        }];
//                    }
//                }];
//            }
//        }];
        if (self.currentPage == 1) {
            [self.array removeAllObjects];
        }
        if (temarray.count<10) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }else{
            self.currentPage++;
            [self.tableview.mj_footer resetNoMoreData];
        }
        [self.array addObjectsFromArray:tempresulet];
        [self.tableview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];
        [self.tableview reloadData];
        
        
    } FailureBlock:^(NSString *msg) {
        [weakSelf endRefresh];
        [self.tableview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];
        [HUDManager showWarningWithText:msg?:@""];
        
    } errorBlock:^(id error) {
        [weakSelf endRefresh];
        [self.tableview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];
        
    }];
}

- (void)digui:(NSArray *)temparray cengCi:(NSInteger)cengci resultArray:(NSMutableArray *)resultArray{

    [temparray enumerateObjectsUsingBlock:^(ReferrerModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (cengci == 0) {
            obj.type = @"一级分销人";
        }else if (cengci ==1){
            obj.type = @"二级分销人";
        }else{
            obj.type = @"三级分销人";
        }
        [resultArray addObject:obj];
        if (obj.childs.count) {
            if (cengci==0) {
                [self digui:obj.childs cengCi:1 resultArray:resultArray];
            }else{
                [self digui:obj.childs cengCi:2 resultArray:resultArray];
            }
        }
    }];
}

@end




@implementation  ReferrerModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"childs":@"ReferrerModel"};
}
@end
