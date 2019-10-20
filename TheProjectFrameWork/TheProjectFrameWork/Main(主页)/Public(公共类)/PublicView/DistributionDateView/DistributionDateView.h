//
//  DistributionDateView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DistributionDateView,DistributionDateModel;
@protocol DistributionDateViewDelegate <NSObject>
- (void)distributionDate:(DistributionDateView *)dateView;
@end
/**
 *  配送时间选择
 */
@interface DistributionDateView : UIView

@property (nonatomic , copy) NSString * dateString;

@property (nonatomic , weak) id <DistributionDateViewDelegate> delegate;
@property (nonatomic , strong) NSArray <DistributionDateModel *>* timeArray;
- (void)removeFromWindow;
- (void)displayToWindow;
@end

@interface DistributionDateModel : NSObject

@property (nonatomic , copy) NSString * startTime;
@property (nonatomic , copy) NSString * endTime;


@end
