//
//  EvalutaionTypeContentAndImageTableViewCell.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EvalutaionTypeContentAndImageTableViewCell.h"
#import "ImageCollectionViewCell.h"
#import "StarView.h"
#import "GoodsEvaluationModel.h"
#import "ShowImagesView.h"
static NSString * itemIdentifier = @"ImageCollectionViewCell";
@interface EvalutaionTypeContentAndImageTableViewCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation EvalutaionTypeContentAndImageTableViewCell
{
    StarView * star;
    StarView * dectStarView;
}
- (void)awakeFromNib
{
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;

    if (KScreenBoundWidth>320)
    {
        
    }
    else
    {
        self.nameLabel.font = KSystemFont(11);
        self.timeLabel.font = KSystemFont(11);
        self.buyTimeLabel.font = KSystemFont(11);
        self.evalutaionLabel.font = KSystemFont(11);
        self.goodsNameLabel.font = KSystemFont(11);
    }
    if (!star) {
        star = [StarView new];
        star.backgroundColor = [UIColor clearColor];
        star.frame = self.starView.bounds;
        star.width = 20 ;
        star.height = 20 ;
        star.fullImage = [UIImage imageNamed:@"xuanzhouxingxing"];
        star.backImage = [UIImage imageNamed:@"weixuanzhongxingxing"];
        star.show_star = 0;
        [star GetValues:^(float values) {
            NSLog(@"%f",values);
        }];
        [self.starView addSubview:star];
    }
    if (!dectStarView) {
        dectStarView = [StarView new];
        dectStarView.frame = self.levelView.bounds;
        dectStarView.backgroundColor = [UIColor clearColor];
        dectStarView.fullImage = [UIImage imageNamed:@"level"];
        dectStarView.backImage = [UIImage imageNamed:@""];
        dectStarView.show_star = 0;
        [dectStarView GetValues:^(float values) {
            NSLog(@"%f",values);
        [self.levelView addSubview:dectStarView];

        }];
        [self loadViewFormXib];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadViewFormXib
{
    self.ImageCollectionView.delegate = self;
    self.ImageCollectionView.dataSource = self;
    self.dataArray = [NSMutableArray array];
    [self.ImageCollectionView registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    
}
-(void)LoadData:(id)model WithIndexPath:(NSIndexPath*)indexPath With:(NSArray*)array
{   GoodsEvaluationModel * themodel = model;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    CGSize cellSize = [NSString sizeWithString:themodel.userName font:KSystemFont(13) maxHeight:30 maxWeight:KScreenBoundWidth-60];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:themodel.userAcc]];
    self.nameLabelWidth.constant = cellSize.width;
    self.nameLabel.text = themodel.userName;
    self.timeLabel.text = themodel.addTime;
    self.buyTimeLabel.text = themodel.goods_by_date;
    self.evalutaionLabel.text = themodel.evaluateInfo;
    self.goodsNameLabel.text = themodel.goods_spec;
    [star Setwidtt:20 minWidth:5 showStar:[themodel.evaluateBuyerVal floatValue]];
    [dectStarView Setwidtt:15 minWidth:5 showStar:[themodel.userCredit floatValue]];
    [self.ImageCollectionView reloadData];
}

- (IBAction)thumbUpButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(EvalutaionTypeContentTableViewCellthumbUpButton:WithIndexPath:)])
    {
        [self.delegate EvalutaionTypeContentTableViewCellthumbUpButton:sender WithIndexPath:self.indexPath];
    }
    sender.selected = !sender.selected;
}

- (IBAction)evluationButtonClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(EvalutaionTypeContentTableViewCellEvaluationClickedWithIndexPath:)])
    {
        [self.delegate EvalutaionTypeContentTableViewCellEvaluationClickedWithIndexPath:self.indexPath];
    }
    
}


#pragma mark --UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    [cell.evaluationImageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    cell.dataArray = self.dataArray;
    cell.indexRow = indexPath.row;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/3.5, collectionView.frame.size.width/3.5);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
