//
//  ShoppingHeadView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@protocol ShoppingHeadViewDelegate <NSObject>

-(void)ShoppingHeadViewDidSelected:(NSInteger)section with:(UIButton*)button ;
-(void)ShoppingHeadViewLookDetialSelected:(NSInteger)section;

@end
/**购物车店铺headview*/
@interface ShoppingHeadView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *lookDetialButton;

@property(assign,nonatomic) NSInteger  section;

@property(weak,nonatomic) id<ShoppingHeadViewDelegate>delegate;

-(void)loadDataWith:(id)model andsection:(NSInteger)section;
@end
