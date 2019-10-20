//
//  SellerOrderHeadDefaultView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerOrderHeadDefaultView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;
@property(assign,nonatomic) BOOL  evaluate;
-(void)loadData:(id)model with:(SellerOrderTypes)type section:(NSInteger)section;
@end
