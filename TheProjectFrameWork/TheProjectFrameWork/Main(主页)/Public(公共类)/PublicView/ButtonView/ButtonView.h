//
//  ButtonView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@interface ButtonView : BaseView
/** 背景视图 */
@property (weak, nonatomic) IBOutlet UIImageView *ButtonImageView;
/** 点击button */
@property (weak, nonatomic) IBOutlet UIButton *clickButton;
/** badgeValue */
@property (weak, nonatomic) IBOutlet UILabel *badgeValuLabel;



+(ButtonView*)loadButtonViewWith:(UIImage*)image andbadgeValue:(NSString*)badgeValue andFreme:(CGRect)frame;

-(void)setBadegeValue:(NSString*)badgeValue;
@end
