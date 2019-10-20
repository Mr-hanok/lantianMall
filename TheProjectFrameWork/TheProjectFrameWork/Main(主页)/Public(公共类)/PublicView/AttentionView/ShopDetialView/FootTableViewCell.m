//
//  FootTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "FootTableViewCell.h"
#import "StarView.h"
#import "AttentShopModel.h"

@implementation FootTableViewCell

{
    StarView * thecreditView;
    StarView * thedescriptionView;
    StarView * theserviceView;
    StarView * thedeliverySpeedView;

}
- (void)awakeFromNib
{
    if (!thecreditView) {
        thecreditView = [StarView new];
        thecreditView.frame = self.creditRatingView.bounds;
        thecreditView.backgroundColor = [UIColor clearColor];
        thecreditView.fullImage = [UIImage imageNamed:@"level"];
        thecreditView.backImage = [UIImage imageNamed:@""];
        thecreditView.show_star = 0;
        [self.creditRatingView addSubview:thecreditView];
    }
    if (!thedescriptionView) {
        thedescriptionView = [StarView new];
        thedescriptionView.backgroundColor = [UIColor clearColor];
        thedescriptionView.frame = self.descriptionView.bounds;
        thedescriptionView.width = 20 ;
        thedescriptionView.height = 20 ;
        thedescriptionView.fullImage = [UIImage imageNamed:@"xuanzhouxingxing"];
        thedescriptionView.backImage = [UIImage imageNamed:@"weixuanzhongxingxing"];
        thedescriptionView.show_star = 0;
        [self.descriptionView addSubview:thedescriptionView];
    }
    if (!thedeliverySpeedView)
    {
        thedeliverySpeedView = [StarView new];
        thedeliverySpeedView.backgroundColor = [UIColor clearColor];
        thedeliverySpeedView.frame = self.deliverySpeedView.bounds;
        thedeliverySpeedView.width = 20 ;
        thedeliverySpeedView.height = 20 ;
        thedeliverySpeedView.fullImage = [UIImage imageNamed:@"xuanzhouxingxing"];
        thedeliverySpeedView.backImage = [UIImage imageNamed:@"weixuanzhongxingxing"];
        thedeliverySpeedView.show_star = 0;
        [self.deliverySpeedView addSubview:thedeliverySpeedView];
    }
    if (!theserviceView)
    {
        theserviceView = [StarView new];
        theserviceView.backgroundColor = [UIColor clearColor];
        theserviceView.frame = self.serviceView.bounds;
        theserviceView.width = 20 ;
        theserviceView.height = 20 ;
        theserviceView.fullImage = [UIImage imageNamed:@"xuanzhouxingxing"];
        theserviceView.backImage = [UIImage imageNamed:@"weixuanzhongxingxing"];
        theserviceView.show_star = 0;
        [self.serviceView addSubview:theserviceView];
    }
    self.connectSellerLabel.text = LaguageControl(@"联系卖家");
    self.ManagementTypeLabel.text = LaguageControl(@"管理类型");
    self.creditRatingLabel.text = LaguageControl(@"信用等级");
    self.shopatomicScoreLabel.text = LaguageControl(@"店铺动态评分");
    self.descriptionLabel.text = LaguageControl(@"描述相符");
    self.serviceLabel.text = LaguageControl(@"服务态度");
    self.deliverySpeedLabel.text = LaguageControl(@"发货速度");
    CGSize sizes = [NSString sizeWithString:LaguageControl(@"联系卖家") font:KSystemFont(15) maxHeight:100 maxWeight:KScreenBoundWidth];
    
    
    self.labelWidth.constant =sizes.width;
    
    
      CGSize thesize = [NSString sizeWithString:LaguageControl(@"描述相符") font:KSystemFont(15) maxHeight:100 maxWeight:KScreenBoundWidth];
    self.descriptionLabelwidth.constant = thesize.width;
    // Initialization code
}
-(void)LoadModel:(id)Model
{
    AttentShopModel * model = Model;
//    NSArray * array = [model.store_credit componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
//    NSString * string = [NSString stringWithFormat:@"level_%@",[array firstObject]];
//    thecreditView.fullImage = [UIImage imageNamed:string];
//    [thecreditView Setwidtt:15 minWidth:5 showStar:[[array lastObject] floatValue]];
    [thecreditView Setwidtt:15 minWidth:5 with:model.store_credit];

    [thedescriptionView Setwidtt:20 minWidth:5 showStar:[model.description_evaluate_halfyear floatValue]];

    [theserviceView Setwidtt:20 minWidth:5 showStar:[model.service_evaluate_halfyear floatValue]];
    [thedeliverySpeedView Setwidtt:20 minWidth:5 showStar:[model.ship_evaluate_halfyear floatValue]];
    self.servicescoreLabel.text =model.service_evaluate_halfyear;
    if ([model.managed_self isEqualToString:@"1"]) {
        self.severTypeLabel.text = LaguageControl(@"托管");
    }
    else
    {
        self.severTypeLabel.text = LaguageControl(@"自营");
    }
    self.deliverspeedscoreLabel.text =model.ship_evaluate_halfyear;
    self.descriptionscoreLabel.text =model.description_evaluate_halfyear;


    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
