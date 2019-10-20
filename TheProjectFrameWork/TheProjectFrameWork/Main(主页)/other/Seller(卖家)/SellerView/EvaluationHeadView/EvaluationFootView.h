//
//  EvaluationFootView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationFootView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UICollectionView *footCollectionView;
@property(strong,nonatomic) NSMutableArray * dataArray;
-(void)LoadDataWithArray:(NSArray*)array;
-(void)loadCollectionView;
@end
