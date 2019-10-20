//
//  GoodsEvaluationView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@interface GoodsEvaluationView : BaseView
@property(assign,nonatomic) BOOL  ishowed;
@property (weak, nonatomic) IBOutlet UITableView *commentsTableView;

-(void)SetGoodIDWithString:(NSString*)goodsID;
-(void)loadDatawith:(NSString*)goodsId;

@end
