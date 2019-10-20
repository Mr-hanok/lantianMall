//
//  HomeGoodsCollectionViewCell.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/18.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import "HomeGoodsCollectionViewCell.h"

@implementation HomeGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 10;
//    self.backView.layer.masksToBounds = YES;
    self.backView.layer.shadowColor = kTextLightDarkColor.CGColor;
    self.backView.layer.shadowOffset = CGSizeMake(1, 1);
    self.backView.layer.shadowOpacity = 0.5;
    self.backView.layer.shadowRadius = 10;
    self.activityLabel.layer.cornerRadius = 5.f;
    self.activityLabel.layer.masksToBounds = YES;
    self.activityLabel.layer.borderWidth = 1.f;
    self.activityLabel.layer.borderColor = [UIColor redColor].CGColor;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, (KScreenBoundWidth-4)/2.0f-4, (KScreenBoundWidth-4)/2.0f-4) byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0f, 10.0f}].CGPath;
    self.goodIV.layer.masksToBounds = YES;
    self.goodIV.layer.mask = maskLayer;
    

}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}
@end
