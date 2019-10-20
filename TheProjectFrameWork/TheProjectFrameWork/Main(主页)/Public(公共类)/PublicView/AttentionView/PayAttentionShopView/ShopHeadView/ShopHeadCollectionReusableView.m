//
//  ShopHeadCollectionReusableView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShopHeadCollectionReusableView.h"
#import "SDCycleScrollView.h"
#import "VipPriceShopListCell.h"
#import "VipPriceModel.h"
static NSString * itemIdentifier = @"VipPriceShopListCell";

@interface ShopHeadCollectionReusableView ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionviewheight;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation ShopHeadCollectionReusableView


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.array = [NSMutableArray array];
    [self.attentionButton setTitle:LaguageControl(@"关注") forState:UIControlStateNormal];
    [self.attentionButton setTitle:LaguageControl(@"已关注") forState:UIControlStateSelected];
    
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    self.collectionview.backgroundColor = [UIColor colorWithString:@"#f2f1f6"];
    
    // Initialization code
}
-(void)loadViewWith:(NSArray *)array vipPrice:(NSArray *)viparray
{
    if (viparray.count) {
        self.array = [NSMutableArray arrayWithArray:viparray];
        [self.collectionview reloadData];
    }else{
        self.collectionviewheight.constant = 0;
    }
    // 网络加载 --- 创建不带标题的图片轮播器
    if (!self.ScrollerView)
    {
        self.ScrollerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 10, self.frame.size.width-20, 164) imageURLStringsGroup:nil];
        self.ScrollerView.backgroundColor = [UIColor whiteColor];
        self.ScrollerView.infiniteLoop = YES;
        self.ScrollerView.delegate = self;
        self.ScrollerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        self.ScrollerView.titleLabelBackgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        self.ScrollerView.placeholderImage=[UIImage imageNamed:@"sliderBanner.jpg"];
        self.ScrollerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        self.ScrollerView.autoScrollTimeInterval = 5.0; // 轮播时间间隔，默认1.0秒，可自定义
        [self.shopScrollerView addSubview:self.ScrollerView];
    }
    if (array.count)
    {
        self.ScrollerView.imageURLStringsGroup = array;
 
    }
    else{
        self.ScrollerView.imageURLStringsGroup = @[@"",];

    }
}
#pragma mark --UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
    //    return MIN(0, self.dataarray.count);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    VipPriceShopListCell  * item = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    VipPriceShopModel *model = self.array[indexPath.row];
    item.contentView.backgroundColor = [UIColor colorWithString:@"#f2f1f6"];
    
    NSString *tempacmout = [NSString stringWithFormat:@"%.2f",[model.couponAmount floatValue]];
    NSString *temporderacmout = [NSString stringWithFormat:@"%.2f",[model.coupon_order_amount floatValue]];
    
    if ([model.coupon_order_amount isEqualToString:@"0"] ||model.coupon_order_amount == nil ) {
        item.desLabelTop.text = @"代金券";
    }else{
        item.desLabelTop.text = [NSString stringWithFormat:@"满%@减%@",temporderacmout,tempacmout];
    }
    item.desLabel.text = [NSString stringWithFormat:@"有效期:%@ - %@", [NSString YYYYMMDDTOYYYYMMDD:model.couponBeginTime],[NSString YYYYMMDDTOYYYYMMDD:model.couponEndTime]];

    item.moneylabel.text = [NSString stringWithFormat:@"%.2f",[model.couponAmount floatValue]];
    
    return item;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(170, 75);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(shopHeadCollectionReusableView:indexparRow:)]) {
        [_delegate shopHeadCollectionReusableView:self indexparRow:indexPath.row];
    }
   
}

@end
