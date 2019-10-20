//
//  PopPayAttentionView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@protocol PopPayAttentionViewDelegate <NSObject>

-(void)ClickedWithSection:(NSInteger)section;

@end

@interface PopPayAttentionView : BaseView

@property (weak, nonatomic) IBOutlet UITableView *classTableView;
@property (weak, nonatomic) IBOutlet UIView *tapView;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(weak,nonatomic) id<PopPayAttentionViewDelegate>delegate;

@property(assign,nonatomic) BOOL isShow;
/**
 *  移除视图
 */
-(void)viewDissMissFromWindow;
/**
 *  显示视图
 */
-(void)showView;

@end
