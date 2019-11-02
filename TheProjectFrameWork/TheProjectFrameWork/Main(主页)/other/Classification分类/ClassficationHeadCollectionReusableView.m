//
//  ClassficationHeadCollectionReusableView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassficationHeadCollectionReusableView.h"

@implementation ClassficationHeadCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

-(void)loadClassficationHeadViewWithSection:(NSInteger)section{
    self.section = section;
}

- (IBAction)detialListButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ClassficationHeadCollectionReusableViewDeatialistClickWithseciton:)]) {
        [self.delegate ClassficationHeadCollectionReusableViewDeatialistClickWithseciton:self.section];
    }
}

@end
