//
//  ShoppingButtonView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShoppingButtonView.h"

@implementation ShoppingButtonView
+(ShoppingButtonView*)loadShoppingButtonViewWithShoppingNumber:(NSInteger )number frame:(CGRect)frame{
    ShoppingButtonView * view = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingButtonView" owner:nil options:nil] firstObject];
    view.frame = frame;
    view.goodsCollectionNumber =1;
    view.shoppingNumber.backgroundColor = [UIColor whiteColor];
    view.goodsNumber = number;
    [view SetView];
    view.shoppingNumber.text = [NSString stringWithFormat:@"%ld",(long)view.goodsNumber];
    if (KSCREEN_WIDTH == 320) {
        view.bgViewHeight.constant = 24;
    }
    return view;
}

-(void)SetView
{
    if (self.goodsNumber<=1)
    {
        [self.subtractButton setImage:[UIImage imageNamed:@"zjgwcbgjiangrayicon"] forState:UIControlStateNormal];
    }
    else
    {
        [self.subtractButton setImage:[UIImage imageNamed:@"zjgwcbgjianicon"] forState:UIControlStateNormal];

    }
    
    if (self.goodsNumber<self.goodsCollectionNumber){
        [self.addButton setImage:[UIImage imageNamed:@"zjgwcbgjiaicon"] forState:UIControlStateNormal];

    }
    else
    {
        [self.addButton setImage:[UIImage imageNamed:@"zjgwcbgjiagrayicon"] forState:UIControlStateNormal];

    }
}
-(void)SetTheGoodsNumber:(NSInteger)number
{
    self.goodsCollectionNumber =number;
    self.goodsNumber = 1;
    self.shoppingNumber.text = @"1";
    [self SetView];
}
-(void)SetGoodsDetialNumber:(NSInteger)number andCollection:(NSInteger )collectionnumber
{
    self.goodsCollectionNumber =collectionnumber;
    if (number>collectionnumber) {
        self.goodsNumber = collectionnumber;
    }
    else{
        self.goodsNumber = number;
    }
    self.shoppingNumber.text = [NSString stringWithFormat:@"%ld",number];
    [self SetView];
}

-(void)SetCollectionNumber:(NSInteger)number
{
    if (number>1)
    {
        self.goodsCollectionNumber=number;
        [self SetView];
    }
}
- (IBAction)addButtonClicked:(UIButton *)sender
{

    if (self.goodsNumber<self.goodsCollectionNumber)
    {
        self.goodsNumber++;
        if (self.goodsNumber==self.goodsCollectionNumber) {
            
            [self.addButton setImage:[UIImage imageNamed:@"zjgwcbgjiagrayicon"] forState:UIControlStateNormal];
        }
        self.shoppingNumber.text = [NSString stringWithFormat:@"%ld",(long)self.goodsNumber];
        [self.delegate shoppingNumberChangeedvalue:self.goodsNumber];
        
        if (self.goodsNumber<=1){
            
            [self.subtractButton setImage:[UIImage imageNamed:@"zjgwcbgjiangrayicon"] forState:UIControlStateNormal];

        }
        else
        {
            [self.subtractButton setImage:[UIImage imageNamed:@"zjgwcbgjianicon"] forState:UIControlStateNormal];

        }
    }
    else
    {
    
    }

}

- (IBAction)subtractButtonClicked:(UIButton *)sender
{
    if (self.goodsNumber <=1){
        return;
    }
    if (self.goodsNumber<self.goodsCollectionNumber) {
        [self.addButton setImage:[UIImage imageNamed:@"zjgwcbgjiaicon"] forState:UIControlStateNormal];
    }
    if (self.goodsNumber <=1)
    {
        [self.delegate shoppingNumberChangeedvalue:1];
    }
    else{
        self.goodsNumber--;
        self.shoppingNumber.text = [NSString stringWithFormat:@"%ld",(long)self.goodsNumber];
        [self.delegate shoppingNumberChangeedvalue:self.goodsNumber];
    }
    if (self.goodsNumber<=1){
        [sender setImage:[UIImage imageNamed:@"zjgwcbgjiangrayicon"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"zjgwcbgjianicon"] forState:UIControlStateNormal];
    }
   
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
