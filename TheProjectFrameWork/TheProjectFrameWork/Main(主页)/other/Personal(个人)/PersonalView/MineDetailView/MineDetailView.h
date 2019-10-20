//
//  MineDetailView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineDetailView;
@protocol MineDetailViewDelegate <NSObject>
@optional
- (void)mineDetailViewClick:(MineDetailView *)view;
- (void)mineDetailViewAccessoryStrClick:(MineDetailView *)view;
@end
@interface MineDetailView : UIView
@property (nonatomic , assign) double value;
@property (nonatomic , copy) NSString * text;
@property (nonatomic , copy) NSString * accessoryStr;
@property (nonatomic , assign) BOOL isIntegral;
@property (nonatomic , weak) id <MineDetailViewDelegate> delegate;



@end
