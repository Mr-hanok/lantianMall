//
//  ButtonView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

+(ButtonView*)loadButtonViewWith:(UIImage*)image andbadgeValue:(NSString*)badgeValue andFreme:(CGRect)frame{
    ButtonView * view =[[[NSBundle mainBundle] loadNibNamed:@"ButtonView" owner:nil options:nil] firstObject];
    view.frame = frame;
    if (badgeValue) {
        view.badgeValuLabel.alpha = 1;
    }
    else{
        view.badgeValuLabel.alpha = 0;
    }
    view.badgeValuLabel.layer.masksToBounds = YES;
    view.badgeValuLabel.layer.cornerRadius = 6.5;
    view.ButtonImageView.image = image;
    view.badgeValuLabel.textColor = [UIColor whiteColor];
    view.badgeValuLabel.backgroundColor = kNavigationColor;
    return view;
}

-(void)setBadegeValue:(NSString*)badgeValue
{
    if (badgeValue.length) {
        self.badgeValuLabel.alpha = 1;
    }
    else{
        self.badgeValuLabel.alpha = 0;
    }
    self.badgeValuLabel.text = badgeValue;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
