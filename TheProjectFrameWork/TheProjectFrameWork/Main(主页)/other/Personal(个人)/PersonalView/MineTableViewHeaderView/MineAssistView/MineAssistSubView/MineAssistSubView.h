//
//  MineAssistSubView.h
//  test
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineAssistSubView;
@protocol MineAssistSubViewDelegate <NSObject>
- (void)mineAssistSubView:(MineAssistSubView *)view;
@end
@interface MineAssistSubView : UIView

@property (nonatomic , assign) NSInteger type;
@property (nonatomic , weak) id <MineAssistSubViewDelegate> delegate;

/**
 *  <#Description#>
 *
 *  @param title <#title description#>
 *  @param count 当count = -1 时，为空
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithTitle:(NSString *)title
                        count:(NSInteger)count;


- (instancetype)initWithMineStore:(NSString *)title;
/**
 *  赋值方法
 *
 *  @param title <#title description#>
 *  @param count <#count description#>
 */
- (void)loadAssistWithTitle:(NSString *)title
                      count:(NSInteger)count;
@end
