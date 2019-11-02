//
//  ClassficationLeftTableViewCell.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2019/5/1.
//  Copyright © 2019 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeClassModel.h"
#import "ClassificationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassficationLeftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic, weak) ClassificationViewController *vc;

@property (nonatomic, strong) HomeClassModel *tableSelModel;
- (void)configCellWithModel:(HomeClassModel *)model;
@end

NS_ASSUME_NONNULL_END
