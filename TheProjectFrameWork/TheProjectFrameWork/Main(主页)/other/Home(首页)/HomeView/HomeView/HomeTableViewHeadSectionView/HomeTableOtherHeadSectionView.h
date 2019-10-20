//
//  HomeTableOtherHeadSectionView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewHeadSectionViewDelegate.h"

@interface HomeTableOtherHeadSectionView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UICollectionView *homeTableOtherHeadSectionView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property(assign,nonatomic)id <HomeTableViewHeadSectionViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(assign,nonatomic) NSInteger section;

@property(assign,nonatomic) NSInteger selectsection;

@property(strong,nonatomic) NSMutableArray * dataArray;

-(void)loadViewWith:(id)model WithSection:(NSInteger)section ;



@end
