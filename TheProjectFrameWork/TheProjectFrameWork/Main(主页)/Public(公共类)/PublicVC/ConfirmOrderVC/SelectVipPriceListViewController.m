//
//  SelectVipPriceListViewController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/24.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "SelectVipPriceListViewController.h"
#import "SelVipPriceTypeCell.h"
#import "VipPriceModel.h"
static NSString * itemIdentifier = @"SelVipPriceTypeCell";

@interface SelectVipPriceListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation SelectVipPriceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.isLingQu ? @"领取优惠券":@"选择优惠券";
    self.array = [NSMutableArray array];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"celllllllll"];
    
    self.collectionview.backgroundColor = [UIColor colorWithString:@"#f2f1f6"];
    [self getViePricelist];

}
-(void)dealloc{
    
}
#pragma mark --UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.isLingQu) {
        if (self.array.count) {
            return self.array.count+1;
        }
    }
    return self.array.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.array.count) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"celllllllll" forIndexPath:indexPath];
        UILabel *l =[[UILabel alloc]initWithFrame:cell.bounds];
        l.textColor = kTextDeepDarkColor;
        l.font = [UIFont systemFontOfSize:18];
        l.backgroundColor = kBGColor;
        l.text = @"不使用优惠券";
        l.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview: l];
        return cell;
    }
    SelVipPriceTypeCell  * item = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    VipPriceShopModel *model = self.array[indexPath.row];
    item.contentView.backgroundColor = [UIColor whiteColor];
    
    if (self.isLingQu) {
        /**领取优惠券*/
        NSString *tempamout = [NSString stringWithFormat:@"%.2f",[model.couponAmount floatValue]];

        [item.mainBtn setTitle:[@"¥" stringByAppendingString:tempamout] forState:UIControlStateNormal];
        item.nameLabel.text = model.couponName;
        
        if ([model.coupon_order_amount isEqualToString:@"0"] ||model.coupon_order_amount == nil ) {
                item.typeLabel.text = @"代金券";
        }else{
                item.typeLabel.text = model.couponName;
        }
        item.timeLabel.text = [NSString stringWithFormat:@"%@ - %@", [NSString YYYYMMDDTOYYYYMMDD:model.couponBeginTime],[NSString YYYYMMDDTOYYYYMMDD:model.couponEndTime]];
        if ([model.receive isEqualToString:@"0"]) {
            item.lingquLabel.text = @"  领取  ";
        }else{
            item.lingquLabel.text = @"  已领取  ";
        }
        NSString *coupon_order_amount = [NSString stringWithFormat:@"%.2f",[model.coupon_order_amount floatValue]];

        item.desLabel.text = model.tempstr= [NSString stringWithFormat:@"满%@减%@",coupon_order_amount,tempamout];
        
    }else{
        /**选择优惠券*/
        NSString *tempamout = [NSString stringWithFormat:@"%.2f",[model.coupon_amount floatValue]];
        [item.mainBtn setTitle:[@"¥" stringByAppendingString:tempamout] forState:UIControlStateNormal];
        item.nameLabel.text = model.coupon_name;
        item.lingquLabel.text = @"  立即使用  ";
        if ([self.storeID isEqualToString:@""]) {
            item.typeLabel.text = [NSString stringWithFormat:@"适用范围:平台通用"];
        }else{
            item.typeLabel.text = [NSString stringWithFormat:@"适用范围:店铺专用"];
        }
        item.timeLabel.text = [NSString stringWithFormat:@"%@ - %@", [NSString YYYYMMDDTOYYYYMMDD:model.coupon_begin_time],[NSString YYYYMMDDTOYYYYMMDD:model.coupon_end_time]];
        NSString *coupon_order_amount = [NSString stringWithFormat:@"%.2f",[model.coupon_order_amountss floatValue]];

        item.desLabel.text = model.tempstr = [NSString stringWithFormat:@"满%@减%@",coupon_order_amount,tempamout];
    }
    
    return item;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.array.count == indexPath.row) {
        return CGSizeMake(KScreenBoundWidth-40-2, 50);
    }
    return CGSizeMake(KScreenBoundWidth-40-2, 100);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isLingQu) {
        VipPriceShopModel *m = self.array[indexPath.row];
        if ([m.receive isEqualToString:@"1"]) {
            return;
        }
        SelVipPriceTypeCell *cell = (SelVipPriceTypeCell *)[self.collectionview cellForItemAtIndexPath:indexPath];
        [self getViPriceMoneyWithVipPriceId:m.modelId cell:cell];

    }else{
        if (indexPath.row == self.array.count) {
            self.selectVipPriceBlock(nil);
 
        }else{
            self.selectVipPriceBlock(self.array[indexPath.row]);
 
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 获取优惠券
- (void)getViePricelist{
    if ([self.useV containsString:@"¥"]) {
        self.useV = [self.useV stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (!self.isLingQu) {
        [params setObject:self.useV forKey:@"useV"];
    }
    if (![self.storeID isEqualToString:@""]) {
        [params setObject:self.storeID forKey:@"storeId"];
    }
    [params setObject:kUserId forKey:@"userId"];

    
    [NetWork PostNetWorkWithUrl:self.isLingQu ? @"/coupon/getCouponByStoreId" : @"/coupon/getCouponByUserId" with:params successBlock:^(NSDictionary *dic) {
        
        self.array = [VipPriceShopModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        [self.collectionview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];
        [self.collectionview reloadData];
        
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg];
        [self.collectionview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];
        [self backToPresentViewController];
    } errorBlock:^(id error) {
        [self.collectionview showNoView:nil image:nil certer:CGPointZero isShow:!self.array.count];
    }];
}
- (void)getViPriceMoneyWithVipPriceId:(NSString *)vipId cell:(SelVipPriceTypeCell *)cell{
    
    [NetWork PostNetWorkWithUrl:@"/coupon/reciveStoreCoupon" with:@{@"couponId":vipId,@"userId":kUserId} successBlock:^(NSDictionary *dic) {
        [HUDManager showWarningWithText:dic[@"data"]?:@"领取成功"];
        cell.lingquLabel.text = @"已领取";
        
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg?:@"优惠券抢光了"];
    } errorBlock:^(id error) {
        
    }];
}

@end
