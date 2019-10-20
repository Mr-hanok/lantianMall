//
//  PopMoreView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopMoreView.h"

@implementation PopMoreView
+(id)loadView{
    PopMoreView * view = [super loadView];
    view.isShow = NO;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapTheView)];
    [view.tapView addGestureRecognizer:tap];
    [view.ContactthesellerButton setTitle:LaguageControl(@"联系卖家") forState:UIControlStateNormal];
     [view.complaintsButton setTitle:LaguageControl(@"投诉") forState:UIControlStateNormal];
    return view;
}
-(void)showViewWithheight:(CGFloat)height withBlcok:(PopMoreViewBlock)block
{
    self.isShow = YES;
    self.block = block;
    [KeyWindow addSubview:self];
    self.frame = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight);
    
    if (height>KScreenBoundHeight/2)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.heightToTop.constant = height-100;
            self.backToTop.constant =10;
            self.backToBottom.constant=0;
            self.backGroundImageView.image = [UIImage imageNamed:@"fanbaijing"];
        } completion:^(BOOL finished){
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.heightToTop.constant = height;
            self.backToTop.constant =0;
            self.backToBottom.constant=10;
            self.backGroundImageView.image = [UIImage imageNamed:@"baijing"];
        } completion:^(BOOL finished){
        }];
        
    }
}
-(void)tapTheView{
    
    [self viewDissMissFromWindow];
}
-(void)viewDissMissFromWindow{
    self.isShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, KScreenBoundHeight, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}
- (IBAction)connectSeller:(UIButton *)sender
{
    self.block(SelectTypesConnectSeller);
    [self viewDissMissFromWindow];
}
- (IBAction)ComplaintsButton:(UIButton *)sender
{
    self.block(SelectTypesComplaints);
    [self viewDissMissFromWindow];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
