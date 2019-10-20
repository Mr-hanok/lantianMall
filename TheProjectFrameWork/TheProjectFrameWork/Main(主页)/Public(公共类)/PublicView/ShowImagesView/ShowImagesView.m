//
//  ShowImagesView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShowImagesView.h"
static NSString * ShowImageCellID = @"ShowImageCell";
@interface ShowImagesView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end
@implementation ShowImagesView
{
    UICollectionView * _collection;
    NSInteger _currentIndex;
    BOOL _isFirstShow;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    frame = kScreenFreameBound;
    self = [super initWithFrame:frame];
    if(self)
    {
        CGRect bounds = (CGRect){{0,0},{KScreenBoundWidth,KScreenBoundHeight}};
//        bounds.size.width += PhotoBrowerMargin;
        
        // 1.create layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:bounds.size];
        [layout setMinimumInteritemSpacing:0];
        [layout setMinimumLineSpacing:0];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [layout setItemSize:kScreenFreameBound.size];

        // 2.create collectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:bounds collectionViewLayout:layout];
        
        [collectionView setBackgroundColor:[UIColor clearColor]];
        [collectionView setPagingEnabled:YES];
        [collectionView setBounces:YES]; // 设置 collectionView的 弹簧效果,这样拉最后一张图时会有拉出来效果,再反弹回去
        
        [collectionView setDataSource:self];
        [collectionView setDelegate:self];
        
        [collectionView setShowsHorizontalScrollIndicator:NO];
        [collectionView setShowsVerticalScrollIndicator:NO];
        [collectionView registerClass:[ShowImageCell  class] forCellWithReuseIdentifier:ShowImageCellID];
        collectionView.backgroundColor = [UIColor blackColor];
        _collection = collectionView;
        
        [self addSubview:collectionView];
    }
    return self;
}
- (void)present
{
    if(_imagesPath.count == 0 || [_imagesPath isKindOfClass:[NSNull class]])
    {
        return;
    }
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [self setFrame:window.bounds];
    [window addSubview:self];

}
- (void)dismiss
{
    UIImageView *tempView = [[UIImageView alloc] init];
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    if([mgr diskImageExistsForURL:[NSURL URLWithString:_imagesPath[_currentIndex]]]){
        tempView.image = [[mgr imageCache] imageFromDiskCacheForKey:_imagesPath[_currentIndex]];
    }else{
        tempView.frame = _selectView.frame;
        UIImageView * tt = (UIImageView *)_selectView;
        tempView.image = tt.image;
    }
    CGRect rect = [_selectView convertRect:_selectView.bounds toView:self];
    
    CGFloat width  = tempView.image.size.width;
    CGFloat height = tempView.image.size.height;
    
    CGSize tempRectSize = (CGSize){KScreenBoundWidth,(height * KScreenBoundWidth / width) > KScreenBoundHeight ? KScreenBoundHeight:(height * KScreenBoundWidth / width)};
    
    [tempView setBounds:(CGRect){CGPointZero,{tempRectSize.width,tempRectSize.height}}];
    [tempView setCenter:[self center]];
    [self addSubview:tempView];
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [tempView setFrame:rect];
        _collection.backgroundColor = [UIColor clearColor];
        [_collection removeFromSuperview];
        [self setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self photoWillShowWithAnimated];
}
- (void)photoWillShowWithAnimated
{
    if(_isFirstShow)
    {
        return;
    }
    CGRect rect = [_selectView convertRect:_selectView.bounds toView:self];
    
    UIImageView * tempView = [[UIImageView alloc] initWithFrame:rect];
    UIImageView * tImage = (UIImageView *)_selectView;
    tempView.image = tImage.image;

    [self addSubview:tempView];
    
    CGSize tempRectSize;
    CGFloat width = tempView.image.size.width;
    CGFloat height = tempView.image.size.height;
    
    tempRectSize = (CGSize){KScreenBoundWidth,(height * KScreenBoundWidth / width) > KScreenBoundHeight ? KScreenBoundHeight:(height * KScreenBoundWidth / width)};
    [_collection setHidden:YES];
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [tempView setCenter:[self center]];
        [tempView setBounds:(CGRect){CGPointZero,tempRectSize}];
        [self setBackgroundColor:[UIColor blackColor]];
    } completion:^(BOOL finished) {
        _isFirstShow = YES;
        [tempView removeFromSuperview];
        [_collection setHidden:NO];
    }];
}
- (void)setImagesPath:(NSArray *)imagesPath
{
    NSMutableArray * temp = [@[] mutableCopy];
    for (NSString * url  in imagesPath) {
        if(![url isKindOfClass:[NSNull class]])
        {
            [temp addObject:url];
        }
    }
    _imagesPath = [temp copy];
    [_collection reloadData];
}
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [_collection setContentOffset:(CGPoint){currentIndex * KScreenBoundWidth,0}];
}
#pragma mark - collection Delegate Method
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    ShowImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShowImageCellID forIndexPath:indexPath];
    cell.url = _imagesPath[indexPath.row];
    cell.tapBlock = ^(){
        [weakSelf dismiss];
    };
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imagesPath.count;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _currentIndex = scrollView.contentOffset.x / KScreenBoundWidth;
}
@end



@interface ShowImageCell ()<UIScrollViewDelegate>

@end
@implementation ShowImageCell
{
    UIImageView * _image;
    UIScrollView * _scrollView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:kScreenFreameBound];
        [self.contentView addSubview:_scrollView];
        _image = [[UIImageView alloc] initWithFrame:kScreenFreameBound];
        _image.userInteractionEnabled = YES;
        [_scrollView addSubview:_image];
        [self initDefaultData];
    }
    return self;
}
- (void)initDefaultData{
    // 1.生产 两种 手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidDoubleTap:)];
    
    // 2.设置 手势的要求
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [doubleTap setNumberOfTapsRequired:2];
    [doubleTap setNumberOfTouchesRequired:1];
    
    // 3.避免两种手势冲突
    [tap requireGestureRecognizerToFail:doubleTap];
    
    // 4.添加 手势
    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:doubleTap];
}

- (void)scrollViewDidTap:(UITapGestureRecognizer *)tap{
   if(_tapBlock)
   {
       _tapBlock();
   }
}
- (void)scrollViewDidDoubleTap:(UITapGestureRecognizer *)doubleTap{
    // 这里先判断图片是否下载好,, 如果没下载好, 直接return
    if(!_image.image) return;
    
    if(_scrollView.zoomScale <= 1){
        // 1.获取到 手势 在 自身上的 位置
        // 2.scrollView的偏移量 x(为负) + 手势的 x 需要放大的图片的X点
        CGFloat x = [doubleTap locationInView:self].x + _scrollView.contentOffset.x;
        
        // 3.scrollView的偏移量 y(为负) + 手势的 y 需要放大的图片的Y点
        CGFloat y = [doubleTap locationInView:self].y + _scrollView.contentOffset.y;
        [_scrollView zoomToRect:(CGRect){{x,y},CGSizeZero} animated:YES];
    }else{
        // 设置 缩放的大小  还原
        [_scrollView setZoomScale:1.f animated:YES];
    }
}
#pragma mark - scrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    // 在ScrollView上  所需要缩放的 对象
    return _image;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    // 每次 完成 拖动时 都 重置 图片的中心点
    _image.center = [self centerOfScrollViewContent:scrollView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self reloadFrames];
}
- (void)reloadFrames{
    CGRect frame = self.frame;
    if(_image.image){
        
        CGSize imageSize = _image.image.size;
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        
        if (frame.size.width <= frame.size.height) {
            CGFloat ratio = frame.size.width / imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height * ratio;
            imageFrame.size.width = frame.size.width;
        }else{

            CGFloat ratio = frame.size.height / imageFrame.size.height;
            imageFrame.size.width = imageFrame.size.width*ratio;
            imageFrame.size.height = frame.size.height;
        }
        
        // 设置 imageView 的 frame
        _image.frame = imageFrame;
        
        // scrollView 的滚动区域
        _scrollView.contentSize = _image.frame.size;
        
        // 将 scrollView.contentSize 赋值为 图片的大小. 再获取 图片的中心点
        _image.center = [self centerOfScrollViewContent:_scrollView];
        
        // 获取 ScrollView 高 和 图片 高 的 比率
        CGFloat maxScale = frame.size.height / imageFrame.size.height;
        // 获取 宽度的比率
        CGFloat widthRadit = frame.size.width / imageFrame.size.width;
        
        // 取出 最大的 比率
        maxScale = widthRadit > maxScale?widthRadit:maxScale;
        // 如果 最大比率 >= 2 倍 , 则取 最大比率 ,否则去 2 倍
        maxScale = maxScale > 2?maxScale:2;
        
        // 设置 scrollView的 最大 和 最小 缩放比率
        _scrollView.minimumZoomScale = 0.6;
        _scrollView.maximumZoomScale = maxScale;
        
        // 设置 scrollView的 原始缩放大小
        _scrollView.zoomScale = 1.0f;
        
    }else{
        frame.origin = CGPointZero;
        _image.frame = frame;
        _scrollView.contentSize = _image.frame.size;
    }
    _scrollView.contentOffset = CGPointZero;
}
- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

- (void)setUrl:(NSString *)url
{
    if([url isKindOfClass:[NSNull class]] || url.length == 0)
    {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [_image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(!error)
        {
            [weakSelf layoutSubviews];
        }
    }];
}


@end