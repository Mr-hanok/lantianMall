//
//  CountDownButton.h
//  test
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CountDownButtonDelegate <NSObject>
@optional
/**
 *  计数器停止
 */
- (void)countDownStop;
@end
@interface CountDownButton : UIView
@property (nonatomic , weak) id <CountDownButtonDelegate> delegate;
@property (nonatomic , weak) id target;
@property (nonatomic , assign) BOOL isStart;
- (instancetype)initWithInterval:(NSTimeInterval)Interval Target:(id)target Sel:(SEL)event;
- (void)startTimer;
- (void)invalidateTimer;
- (void)stopTimeing;
@end
