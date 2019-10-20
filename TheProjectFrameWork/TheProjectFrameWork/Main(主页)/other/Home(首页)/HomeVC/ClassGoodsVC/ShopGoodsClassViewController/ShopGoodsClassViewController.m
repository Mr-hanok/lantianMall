//
//  ShopGoodsClassViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShopGoodsClassViewController.h"

static NSString * BaseSpaceTableViewCellID = @"BaseSpaceTableViewCell";
static NSString * ShopGoodsClassCellID = @"ShopGoodsClassCell";

@interface ShopGoodsClassViewController ()<UITableViewDelegate,UITableViewDataSource,ShopGoodsClassCellDelegate>

@property (nonatomic , weak) UITableView * shopGoodsClassTableView;
@property (nonatomic , strong) ShopGoodsClassViewModel * model;

@end

@implementation ShopGoodsClassViewController

#pragma mark - life cycle 
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updataHeader:self.shopGoodsClassTableView];
    [self.header beginRefreshing];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"商品分类");
}
- (void)updateHeadView
{
    [self.model getShopGoodsClassInfoWithStoreId:_store_id completed:^(id error) {
        [HUDManager showWarningWithError:error];
        [self.shopGoodsClassTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self endRefresh];
    }];
}

#pragma mark - tableviewDelegate Method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row)
    {
        ShopGoodsClassCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopGoodsClassCellID];
        cell.delegate = self;
        cell.classArray = self.model.items;
        return cell;
    }else
    {
        ShopGoodsClassAllCell * cell = [tableView dequeueReusableCellWithIdentifier:BaseSpaceTableViewCellID];
        cell.cellTitle = @"全部商品";
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!indexPath.row)
    {
        return kScaleHeight(60);
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  点击全部商品
     */
    if(!indexPath.row)
    {
        if(_clickBack)
        {
            _clickBack(@"0" , LaguageControl(@"全部商品"));
        }
    }
}


#pragma mark - cells Delegate Method
/**
 *  点击商品分类item
 *
 *  @param info <#info description#>
 */
- (void)shopGoodsClassClickEvent:(ShopGoodsClassItem *)item
{
    if(_clickBack)
    {
        _clickBack(item.model.classId,item.model.categoryName);
    }
}


#pragma mark - init
- (instancetype)initWithClickClass:(clickClassBlock)block
{
    self = [super init];
    if(self)
    {
        _clickBack = block;
    }
    return self;
}

#pragma mark - setter and getter 
- (UITableView *)shopGoodsClassTableView
{
    if(!_shopGoodsClassTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.delegate = self;
        tableview.dataSource = self;
        [tableview registerClass:[ShopGoodsClassAllCell class] forCellReuseIdentifier:BaseSpaceTableViewCellID];
        [tableview registerClass:[ShopGoodsClassCell class] forCellReuseIdentifier:ShopGoodsClassCellID];
        tableview.backgroundColor = [UIColor colorWithString:@"#f7f7f7"];
        tableview.separatorColor = [UIColor clearColor];
        tableview.tableFooterView = [UIView new];
        [self.view addSubview:tableview];
        __weak typeof(self) weakSelf = self;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.mas_topLayoutGuideTop);
        }];
        _shopGoodsClassTableView = tableview;
    }
    return _shopGoodsClassTableView;
}
- (ShopGoodsClassViewModel *)model
{
    if(!_model)
    {
        _model = [[ShopGoodsClassViewModel alloc] init];
    }
    return _model;
}
@end


@implementation ShopGoodsClassAllCell
{
    UILabel * titleLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(17)];
        titleLabel.textColor = [UIColor colorWithString:@"#666666"];
        UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
        [self.backView addSubview:titleLabel];
        [self.backView addSubview:image];
        __weak typeof(self) weakSelf = self;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.backView);
            make.left.equalTo(weakSelf.backView.mas_left).mas_offset(kScaleWidth(10));
        }];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.backView);
            make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(10));
        }];
        
    }
    return self;
}
- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    titleLabel.text = LaguageControl(cellTitle);
}
@end


@interface ShopGoodsClassCell ()<ShopGoodsClassItemDelegate>

@end
@implementation ShopGoodsClassCell
- (void)setClassArray:(NSArray<ShopClassItemModel *> *)classArray
{
    if([classArray isKindOfClass:[NSNull class]] || classArray.count == 0 || !classArray)
    {
        return;
    }
    _classArray = classArray;
    __block UIView * lastView = nil;
    __weak typeof(self.backView) weakSelf = self.backView;
    [classArray enumerateObjectsUsingBlock:^(ShopClassItemModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ShopGoodsClassItem * item = [[ShopGoodsClassItem alloc] init];
        item.delegate = self;
        [self.backView addSubview:item];
        item.model = obj;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kScaleHeight(50));
            make.width.equalTo(weakSelf.mas_width).multipliedBy(0.485f);
            if(lastView)
            {
                if((idx+1) % 2 == 0)
                {
                    make.right.equalTo(weakSelf.mas_right);
                    make.top.equalTo(lastView.mas_top);
                }else
                {
                    make.left.equalTo(weakSelf.mas_left);
                    make.top.equalTo(lastView.mas_bottom).mas_offset(kScaleHeight(10));
                }
            }else
            {
                make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(10));
                make.left.equalTo(weakSelf.mas_left);
            }
        }];
        lastView = item;
    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(10));
    }];
}
- (void)shopGoodsClassClick:(ShopGoodsClassItem *)item
{
    if([_delegate respondsToSelector:@selector(shopGoodsClassClickEvent:)])
    {
        [_delegate shopGoodsClassClickEvent:item];
    }
}
- (void)drawRect:(CGRect)rect
{

}
@end

@implementation ShopGoodsClassItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.contentEdgeInsets = UIEdgeInsetsMake(0,kScaleWidth(12), 0, 0);
        [self addTarget:self action:@selector(itemClickEvent) forControlEvents:UIControlEventTouchUpInside];
        self.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        [self setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor colorWithString:@"#f3f3f3"];
    }
    return self;
}
- (void)itemClickEvent
{
    if([_delegate respondsToSelector:@selector(shopGoodsClassClick:)])
    {
        [_delegate shopGoodsClassClick:self];
    }
}

- (void)setModel:(ShopClassItemModel *)model
{
    _model = model;
    [self setTitle:model.categoryName forState:UIControlStateNormal];
}
@end


@implementation ShopGoodsClassViewModel

- (void)getShopGoodsClassInfoWithStoreId:(NSString *)storeid completed:(netWorkComplete)complete
{
    [NetWork PostNetWorkWithUrl:@"/store_class/store_classify" with:@{@"store_id":storeid} successBlock:^(NSDictionary *dic) {
        if(complete)
        {
            NSArray * array = [ShopClassItemModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            _items = array;
            complete(nil);
        }
    } FailureBlock:^(NSString *msg) {
        if(complete)
        {
            complete(msg);
        }
    } errorBlock:^(id error) {
        if(complete)
        {
            complete(error);
        }
    }];
}

@end


@implementation ShopClassItemModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"classId":@"id"};
}

@end