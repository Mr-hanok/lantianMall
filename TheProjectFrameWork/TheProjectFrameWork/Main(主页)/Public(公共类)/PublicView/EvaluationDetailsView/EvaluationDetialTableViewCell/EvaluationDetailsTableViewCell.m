//
//  EvaluationDetailsTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EvaluationDetailsTableViewCell.h"
#import "StarView.h"

@implementation EvaluationDetailsTableViewCell

- (void)awakeFromNib {
    StarView * star = [StarView new];
    star.backgroundColor = [UIColor clearColor];
    star.frame = self.starView.bounds;
    star.fullImage = [UIImage imageNamed:@"level"];
    star.backImage = [UIImage imageNamed:@""];
    star.show_star = 4;
    [star GetValues:^(float values) {
        NSLog(@"%f",values);
    }];
    [self.starView addSubview:star];
    

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
