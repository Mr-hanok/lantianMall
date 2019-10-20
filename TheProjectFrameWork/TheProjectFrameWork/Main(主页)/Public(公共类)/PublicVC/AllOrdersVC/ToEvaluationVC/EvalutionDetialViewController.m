//
//  EvalutionDetialViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "EvalutionDetialViewController.h"
#import "EvaluationView.h"
#import "EvaluateContentCell.h"
#import "StoreRatingsCell.h"
#import "CameraTakeMamanger.h"
#import "UIImage+Compression.h"
#import "BuyerOrderModel.h"
#import "EvalutionDetialModel.h"
#import "PhotoInfoModel.h"
static NSString * EvaluateContentCellId = @"EvaluateContentCell";
static NSString * StoreRatingsCellId = @"StoreRatingsCell";
@interface EvalutionDetialViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,EvaluateContentCellDelegate>
@property (nonatomic , weak) UITableView * evalutionTableView;
@property (nonatomic , strong) NSArray <EvalutionDetialModel *> * contentArray;
@end

@implementation EvalutionDetialViewController
{
    EvaluateContentCell * currentCell;
    StoreRatingsCell * ratingsCell;
    NSMutableArray * evluateInfos;
    NSMutableArray * imgIDs;
    NSMutableArray * buyVals;
    NSInteger currentPhotoTag;

}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.evalutionTableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = LaguageControl(@"发表评价");
}
#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.gcpList.count + 1;
}
/**
 *  发表评价
 */
- (void)publish
{
    [self spliceParameNetWork];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != self.model.gcpList.count)
    {// 商品评价内容
        EvaluateContentCell * cell = [tableView dequeueReusableCellWithIdentifier:EvaluateContentCellId];
        cell.delegate = self;
        cell.model = self.model.gcpList[indexPath.row];
        cell.contentModel = self.contentArray[indexPath.row];
        return cell;
    }
    /**
     *  店铺评价
     */
    StoreRatingsCell * cell = [tableView dequeueReusableCellWithIdentifier:StoreRatingsCellId];
    ratingsCell = cell;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != self.model.gcpList.count)
    {
        return kScaleHeight(280);
    }
    return kScaleHeight(155);
}

#pragma mark - EvaluateContentCellDelegate
- (void)evaluateContent:(EvaluateContentCell *)cell photoIndex:(NSInteger)index
{
    currentCell = cell;
    currentPhotoTag = index;
    UIActionSheet * photo = [[UIActionSheet alloc]
                             initWithTitle:nil
                             delegate:self
                             cancelButtonTitle:LaguageControl(@"取消")
                        destructiveButtonTitle:LaguageControl(@"相机")
                             otherButtonTitles:LaguageControl(@"相册"),nil];
    [photo showInView:self.view];
}
/**
 *  获取评价内容
 *
 *  @param cell <#cell description#>
 *  @param text <#text description#>
 */
- (void)evaluateCell:(EvaluateContentCell *)cell Text:(NSString *)text
{
    cell.contentModel.evluateInfo = text;
}
/**
 *  返回评价 （好评，中评，差评）
 *
 *  @param type <#type description#>
 */
- (void)evaluateTypeCell:(EvaluateContentCell *)cell WithType:(NSInteger)type
{
    cell.contentModel.buyVal = type;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self localPhoto];
            break;
    }
}
- (void)takePhoto
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [HUDManager showWarningWithText:@"相机不可用"];
        return;
    }
    [[CameraTakeMamanger sharedInstance]imageWithCameraInController:self handler:^(UIImage *image, NSString *imagePath) {
        [currentCell setPhotoSelectImage:image imagePath:imagePath tag:currentPhotoTag];
    } cancelHandler:^{
        
    }];
}
- (void)localPhoto
{
    [[CameraTakeMamanger sharedInstance]imageWithPhotoInController:self handler:^(UIImage *image, NSString *imagePath) {
        [currentCell setPhotoSelectImage:image imagePath:imagePath tag:currentPhotoTag];
    } cancelHandler:^{
        
    }];
}

#pragma mark - 拼接请求参数并发送请求
- (void)spliceParameNetWork
{
    
    buyVals = [[NSMutableArray alloc] init];
    imgIDs = [[NSMutableArray alloc] init];
    evluateInfos = [[NSMutableArray alloc] init];
    NSInteger loadCount = _contentArray.count;
    [HUDManager showLoadingHUDView:self.view withText:@"请稍候"];
    [self uploadImagesCurrentIndex:loadCount complete:^(id error) {
        if(error)
        {
            [HUDManager hideHUDView];
            [HUDManager showWarningWithError:error];
            return ;
        }
        NSString *tempStr = [evluateInfos componentsJoinedByString:@","];
        if ([tempStr containsString:@" |ios| "] || tempStr == nil) {
            [HUDManager showWarningWithText:@"请输入评价内容"];
            return;
        }

        NSDictionary * params = @{@"user_id":kUserId,@"of_id":_model.buyoderid,
                                  @"evluateInfo":[evluateInfos componentsJoinedByString:@","],
                                  @"buyVal":[buyVals componentsJoinedByString:@","],
                                  @"img":[imgIDs componentsJoinedByString:@","],
                                  @"desEval":@(ratingsCell.descriptionMatch),
                                  @"serviceEval":@(ratingsCell.serviceAttitude),
                                  @"shipEval":@(ratingsCell.deliverySpeed)};
        [self publishedWithParams:params];
    }];
}
- (void)publishedWithParams:(NSDictionary *)params
{
}
- (void)uploadImagesCurrentIndex:(NSInteger)currentIndex complete:(void (^)(id error))complete
{
    if(currentIndex == 0)
    {
        if(complete)
        {
            complete(nil);
        }
        return;
    }
    __block NSInteger tempIndex = currentIndex;
    EvalutionDetialModel * tempModel = _contentArray[currentIndex-1];
    NSArray * images = tempModel.images;

    if(images.count == 0 ||images == nil)
    {
        tempIndex --;
        [self parameSplitWithPhotoArray:nil EvalutionDetialModel:tempModel];
        [self uploadImagesCurrentIndex:tempIndex complete:complete];
    }else
    {
        [NetWork PostUpLoadImageWithImages:images successBlock:^(NSArray<PhotoInfoModel *> *photoInfoArray)
         {
             tempIndex --;
             [self parameSplitWithPhotoArray:photoInfoArray EvalutionDetialModel:tempModel];
             [self uploadImagesCurrentIndex:tempIndex complete:complete];
         } FailureBlock:^(NSString *msg) {
             complete(msg);
         } errorBlock:^(id error) {
             complete(error);
         }];
    }
    
    
}
- (void)parameSplitWithPhotoArray:(NSArray *)photoInfoArray EvalutionDetialModel:(EvalutionDetialModel *)tempModel
{
    NSMutableArray * photoids = [@[] mutableCopy];
    [buyVals addObject:[NSString stringWithFormat:@"%@_%ld",tempModel.goodsCartId,(long)tempModel.buyVal]];
    [evluateInfos addObject:[NSString stringWithFormat:@"%@_%@",tempModel.goodsCartId,tempModel.evluateInfo?:@" |ios| "]];
    if(photoInfoArray.count == 0 || photoInfoArray == nil)
    {
        return;
    }
    for (PhotoInfoModel * photoModel in photoInfoArray){
        [photoids addObject:@(photoModel.photoID)];
    }
    NSString * photoID = [photoids componentsJoinedByString:@"/"];

    [imgIDs addObject:[NSString stringWithFormat:@"%@_%@",tempModel.goodsCartId,photoID]];
}
#pragma mark - setter and getter
- (UITableView *)evalutionTableView
{
    if(!_evalutionTableView)
    {
        UITableView * tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor clearColor];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [UIView new];
        tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        tableview.separatorColor = [UIColor clearColor];
        tableview.backgroundColor = [UIColor clearColor];
        [tableview registerClass:[EvaluateContentCell class] forCellReuseIdentifier:EvaluateContentCellId];
        [tableview registerClass:[StoreRatingsCell class] forCellReuseIdentifier:StoreRatingsCellId];
        UIButton * publish = [UIButton buttonWithType:UIButtonTypeCustom];
        [publish setTitle:LaguageControl(@"发表评价") forState:UIControlStateNormal];
        [publish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        publish.backgroundColor = [UIColor colorWithString:@"#EC2426"];
        [publish addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tableview];
        [self.view addSubview:publish];
        __weak typeof(self) weakSelf = self;
        [publish mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(weakSelf.view);
            make.height.mas_equalTo(50);
        }];
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.equalTo(weakSelf.view);
            make.bottom.mas_equalTo(publish.mas_top);
        }];
        _evalutionTableView = tableview;
    }
    return _evalutionTableView;
}
- (NSArray *)contentArray
{
    if((!_contentArray) || _contentArray.count == 0)
    {
        NSMutableArray * tempArray = [@[] mutableCopy];
        NSInteger modelListCount = _model.gcpList.count;
        for (NSInteger i = 0 ;i < modelListCount; i++) {
            EvalutionDetialModel * modele = [[EvalutionDetialModel alloc] init];
            modele.buyVal = 1;
            modele.images = [@[] mutableCopy];
            modele.goodsCartId = _model.gcpList[i].goodsCartId;
            [tempArray addObject:modele];
        }
        _contentArray = [tempArray copy];
    }
    return _contentArray;
}
@end
