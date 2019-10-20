//
//  ClassTitleView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@protocol ClassTitleViewDelegate <NSObject>

-(void)DetialButtonClickedWith:(NSInteger)section;
@end
@interface ClassTitleView : BaseView
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleName;
/** 详情按钮 */
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
/** 分区 */
@property(assign,nonatomic) NSInteger section;

@property(weak,nonatomic) id <ClassTitleViewDelegate> delegate;
/** 标题 */
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
/**
 *  创建方法
 *
 *  @param section <#section description#>
 *
 *  @return <#return value description#>
 */
+(ClassTitleView*)CreatClassTitleViewWithIndex:(NSInteger)section;

@end
