//
//  EvaluationView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  评价星级

#import <UIKit/UIKit.h>

@interface EvaluationView : UIView

@property (nonatomic , assign) CGFloat scorePercent; ///< 评价星级 (0~5)
@property (nonatomic , assign) BOOL isAnimate;
@end
