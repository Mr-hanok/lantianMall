//
//  PopChangView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PopChangView.h"

@implementation PopChangView
+(id)loadView{
    PopChangView * view = [super loadView];
    view.isShow = NO;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapTheView)];
    [view.tapView addGestureRecognizer:tap];
    [view.changelogisticsButton setTitle:LaguageControl(@"修改物流") forState:UIControlStateNormal];
    if (KScreenBoundWidth>320) {
        view.changelogisticsButton.titleLabel.font =KSystemFont(12);
    }
    else{
        view.changelogisticsButton.titleLabel.font =KSystemFont(12);
    }
    CGSize contentSize = [NSString sizeWithString:LaguageControl(@"修改物流") font:KSystemFont(16) maxHeight:40 maxWeight:KScreenBoundWidth];
    view.contentWidth.constant =contentSize.width+20;
    return view;
}
+(id)loadViewWith:(NSString*)name{
    PopChangView * view = [super loadView];
    view.isShow = NO;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapTheView)];
    [view.tapView addGestureRecognizer:tap];
    [view.changelogisticsButton setTitle:LaguageControl(name) forState:UIControlStateNormal];
    CGSize contentSize = [NSString sizeWithString:LaguageControl(name) font:KSystemFont(16) maxHeight:40 maxWeight:KScreenBoundWidth];
    view.contentWidth.constant = MAX(contentSize.width+20, 80);
    return view;
    
}
-(void)showViewWithheight:(CGFloat)height withBlcok:(PopChangViewBlock)block
{
    self.isShow = YES;
    self.block = block;
    [KeyWindow addSubview:self];
    self.frame = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight);
    
    if (height>KScreenBoundHeight/2)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.heightToTop.constant = height-60;
            self.buttonToBottom.constant =5;
            self.buttonToTop.constant =0;
            self.backImageView.image = [UIImage imageNamed:@"fanbaijing"];
        } completion:^(BOOL finished){
            
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.heightToTop.constant = height;
            self.buttonToTop.constant =5;
            self.buttonToBottom.constant =0;
            self.backImageView.image = [UIImage imageNamed:@"baijing"];
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
- (IBAction)changeLogisticsClicked:(UIButton *)sender
{
    [self viewDissMissFromWindow];
    self.block (YES);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
