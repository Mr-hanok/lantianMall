//
//  MineAssistView.h
//  test
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//  我的页面 关注信息

#import <UIKit/UIKit.h>
@class MineAssistView;
@protocol MineAssistViewDelegate <NSObject>
- (void)mineAssistView:(MineAssistView *)view type:(NSInteger)type;
@end
@interface MineAssistView : UIView
@property (nonatomic , weak) id <MineAssistViewDelegate> delegate;

/**
 *  初始化模型并赋值操作
 *
 *  @param model <#model description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithModel:(id)model;
/**
 *  重新赋值方法
 *
 *  @param model <#model description#>
 */
- (void)loadWithModel:(id)model;
@end
