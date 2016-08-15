//
//  ETStarView.m
//  ETStarViewExample
//
//  Created by chenglei on 16/8/11.
//  Copyright © 2016年 ETListener. All rights reserved.
//

#import "ETStarView.h"


/** 布局方式 */
typedef NS_ENUM(NSInteger, BYStarViewLayoutType) {
    BYStarViewLayoutType_Masonry = 0,
    BYStarViewLayoutType_Frame = 1,
};

static NSUInteger const kTotalStarCount = 5;


// |-kHorizontalSpace-yellowStarsView-kHorizontalSpace-|
static CGFloat const kHorizontalSpace = 0.0;  // yellow左右留白填充
static CGFloat const kVerticalSpace = 0.0;    // yellow上下留白填充

static CGFloat const kStarImageWidth = 16.f;     // 单个星星的宽度
static CGFloat const kStarImagePidding = 3.f;    // 星星间的间隔

@interface ETStarView ()

// 逻辑变量
@property (nonatomic, assign) BYStarViewYellowStarShowStyle showStyle;  // 需要先设置才能正常改变rating
@property (nonatomic, assign) BYStarViewLayoutType layoutType;  // 布局方式，default：_Frame

// UI
@property (nonatomic, strong) UIView *grayStarsView;    // 5个灰色星星
@property (nonatomic, strong) UIView *yellowStarsView;  // 5个黄色星星

@end


@implementation ETStarView

#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
//        [self testByColor];
    }
    return self;
}

- (instancetype)initWithRating:(CGFloat)rating showStyle:(BYStarViewYellowStarShowStyle)showStyle {
    self = [self init];
    self.userInteractionEnabled = NO;
    self.layoutType = BYStarViewLayoutType_Masonry;
    [self setupUI];
    self.showStyle = showStyle;
    self.rating = rating;
    return self;
}


+ (instancetype)creatWithRating:(CGFloat)rating showStyle:(BYStarViewYellowStarShowStyle)showStyle {
    ETStarView *starView = [[ETStarView alloc] initWithRating:rating showStyle:showStyle];
    return starView;
}


- (instancetype)initWithRating:(CGFloat)rating
                    layoutType:(BYStarViewLayoutType)layoutType
                     showStyle:(BYStarViewYellowStarShowStyle)showStyle {
    self = [self init];
    self.userInteractionEnabled = NO;
    self.layoutType = layoutType;
    [self setupUI];
    self.showStyle = showStyle;
    self.rating = rating;
    return self;
}

+ (instancetype)creatFrameLayoutWithRating:(CGFloat)rating
                                 showStyle:(BYStarViewYellowStarShowStyle)showStyle {
    ETStarView *starView = [[ETStarView alloc] initWithRating:rating layoutType:BYStarViewLayoutType_Frame showStyle:showStyle];
    return starView;
}

+ (instancetype)creatMasonryLayoutWithRating:(CGFloat)rating
                                   showStyle:(BYStarViewYellowStarShowStyle)showStyle {
    ETStarView *starView = [[ETStarView alloc] initWithRating:rating layoutType:BYStarViewLayoutType_Masonry showStyle:showStyle];
    return starView;
}




- (void)testByColor {
    _yellowStarsView.backgroundColor = [UIColor cyanColor];
    self.backgroundColor = [UIColor blueColor];
}

#pragma mark - Public Method


#pragma mark - Private Method
#pragma mark yellowStar
/** 改变Rating以及视图 */
- (void)chageRating:(CGFloat)rating {
    if (rating < 0.0 && rating > kTotalStarCount) {
        NSLog(@"Error: rating must belongs to [0.0, 5.0] !");
        [self chageRating:0.0];
        return;
    }
    _rating = [self adjustRatingWithTempRating:rating];
    [self adjustYellowStarsViewWithAdjustRating:_rating];
}


/** 根据showStyle计算adjustRating */
- (CGFloat)adjustRatingWithTempRating:(CGFloat)rating {
    if (rating < 0.0 && rating > kTotalStarCount) {
        NSLog(@"Error: rating must belongs to [0.0, 5.0] !");
        return 0.0;
    }
    CGFloat tempAdjustRating = 0.0;
    switch (_showStyle) {
        case BYStarViewYellowStarShowStyle_None: {
            NSLog(@"Error: must set BYStarViewShowStyle before adjustRating !");
        }
            break;
        case BYStarViewYellowStarShowStyle_RoundInt: {
            tempAdjustRating = roundf(rating);
        }
            break;
        case BYStarViewYellowStarShowStyle_FloorInt: {
            tempAdjustRating = floorf(rating);
        }
            break;
        case BYStarViewYellowStarShowStyle_CeilInt: {
            tempAdjustRating = ceilf(rating);
        }
            break;
        case BYStarViewYellowStarShowStyle_Float: {
            tempAdjustRating = rating;
        }
            break;
        case BYStarViewYellowStarShowStyle_RoundHalf: {
            tempAdjustRating = roundf(rating * 2.0) / 2.0;
        }
            break;
        case BYStarViewYellowStarShowStyle_FloorHalf: {
            tempAdjustRating = floorf(rating * 2.0) / 2.0;
        }
            break;
        case BYStarViewYellowStarShowStyle_CeilHalf: {
            tempAdjustRating = ceilf(rating * 2.0) / 2.0;
        }
            break;
        default: {
            NSLog(@"Error: not define BYStarViewShowStyle !");
        }
            break;
    }
    //NSLog(@"tempAdjustRating:%.2f", tempAdjustRating);
    return tempAdjustRating;
}

/** 根据adjustRating调整视图 */
- (void)adjustYellowStarsViewWithAdjustRating:(CGFloat)adjustRating {
    [_yellowStarsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([self getAdjustYellowStarsViewWidth:adjustRating]);
    }];
}

/** 根据adjustRating获取YellowStarsView显示宽度 */
- (CGFloat)getAdjustYellowStarsViewWidth:(CGFloat)adjustRating {
    return adjustRating * kStarImageWidth + floorf(adjustRating) * kStarImagePidding;
}

#pragma mark grayStar




#pragma mark - Getters & Setters
- (void)setRating:(CGFloat)rating {
    if (_rating != rating) {
        // 注意，在chageRating方法内给rating赋值的
        [self chageRating:rating];
    }
}

- (void)setLayoutType:(BYStarViewLayoutType)layoutType {
    switch (layoutType) {
        case BYStarViewLayoutType_Masonry:
        case BYStarViewLayoutType_Frame: {
            _layoutType = layoutType;
        }
            break;
        default: {
            _layoutType = BYStarViewLayoutType_Masonry;
        }
            break;
    }
}

- (void)setIsShowGrayStar:(BOOL)isShowGrayStar {
    if (_isShowGrayStar != isShowGrayStar) {
        _isShowGrayStar = isShowGrayStar;
        _grayStarsView.hidden = !isShowGrayStar;
    }
}

- (void)setCanTouchSlide:(BOOL)canTouchSlide {
    if (_canTouchSlide != canTouchSlide) {
        _canTouchSlide = canTouchSlide;
        // 通过整个starView是否接受事件来设置
        self.userInteractionEnabled = canTouchSlide;
        //self.showStyle = BYStarViewYellowStarShowStyle_CeilInt;
        //self.showStyle = BYStarViewYellowStarShowStyle_CeilHalf;
    }
}

//- (BOOL)canTouchSlide {
//    return self.userInteractionEnabled;
//}

#pragma mark - Getters UI
- (void)setupUI {
    if (self.layoutType == BYStarViewLayoutType_Frame) {
        [self setupUIByFrame];
    }else {
        [self setupUIByMasonry];
    }
    
}

- (UIView *)grayStarsView {
    if (!_grayStarsView) {
        switch (_layoutType) {
            case BYStarViewLayoutType_Masonry: {
                [self creatGrayStarsViewByMasonry];
            }
                break;
            case BYStarViewLayoutType_Frame: {
                [self creatGrayStarsViewByFrame];
            }
                break;
            default: {
                [self creatGrayStarsViewByMasonry];
            }
                break;
        }
    }
    return _grayStarsView;
}

- (UIView *)yellowStarsView {
    if (!_yellowStarsView) {
        switch (_layoutType) {
            case BYStarViewLayoutType_Masonry: {
                [self creatYellowStarsViewByMasonry];
            }
                break;
            case BYStarViewLayoutType_Frame: {
                [self creatYellowStarsViewByFrame];
            }
                break;
            default: {
                [self creatYellowStarsViewByMasonry];
            }
                break;
        }
    }
    return _yellowStarsView;
}

#pragma mark Getters UI By Masonry
- (void)setupUIByMasonry {
    [self addSubview:self.grayStarsView];
    [_grayStarsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(kStarViewWidth);
    }];
    
    [self addSubview:self.yellowStarsView];
    [_yellowStarsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kVerticalSpace);
        make.left.equalTo(self).offset(-kVerticalSpace);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(kStarViewWidth);
    }];
}

- (void)creatGrayStarsViewByMasonry {
    UIView *tempGrayStarsView = [[UIView alloc] init];
    tempGrayStarsView.backgroundColor = [UIColor clearColor];
    tempGrayStarsView.clipsToBounds = YES;
    tempGrayStarsView.hidden = YES;
    
    for (NSInteger i = 0; i < kTotalStarCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:@"icon_stars_empty"];
        [tempGrayStarsView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tempGrayStarsView).offset(i * (kStarImageWidth + kStarImagePidding));
            make.centerY.equalTo(tempGrayStarsView);
            make.size.mas_equalTo(CGSizeMake(kStarImageWidth, kStarImageWidth));
        }];
    }
    
    _grayStarsView = tempGrayStarsView;
}


- (void)creatYellowStarsViewByMasonry {
    UIView *tempYellowStarsView = [[UIView alloc] init];
    tempYellowStarsView.backgroundColor = [UIColor clearColor];
    tempYellowStarsView.clipsToBounds = YES;
    
    for (NSInteger i = 0; i < kTotalStarCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        /*
         icon_productedit_stars_full, icon_productedit_stars_half, icon_productedit_stars_empty
         btn_assess_star_on, btn_assess_star_off
         */
        imgView.image = [UIImage imageNamed:@"icon_stars_full"];
        [tempYellowStarsView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tempYellowStarsView).offset(i * (kStarImageWidth + kStarImagePidding));
            make.centerY.equalTo(tempYellowStarsView);
            make.size.mas_equalTo(CGSizeMake(kStarImageWidth, kStarImageWidth));
        }];
    }
    
    _yellowStarsView = tempYellowStarsView;
}



#pragma mark Getters UI By Frame
- (void)setupUIByFrame {
    
    [self addSubview:self.grayStarsView];
    [_grayStarsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(kStarViewWidth);
    }];
    
    [self addSubview:self.yellowStarsView];
    [_yellowStarsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kVerticalSpace);
        make.left.equalTo(self).offset(-kVerticalSpace);
        make.height.equalTo(self.mas_height);
        make.width.mas_equalTo(kStarViewWidth);
    }];
}


- (void)creatGrayStarsViewByFrame {
    UIView *tempGrayStarsView = [[UIView alloc] initWithFrame:CGRectMake(kHorizontalSpace, kVerticalSpace, kStarViewWidth, kStarViewHeight)];
    tempGrayStarsView.backgroundColor = [UIColor clearColor];
    tempGrayStarsView.clipsToBounds = YES;
    tempGrayStarsView.hidden = YES;
    
    for (NSInteger i = 0; i < kTotalStarCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:@"icon_productedit_stars_empty"];
        [tempGrayStarsView addSubview:imgView];
        imgView.frame = CGRectMake(i * (kStarImageWidth + kStarImagePidding), 0, kStarImageWidth, kStarImageWidth);
    }
    
    _grayStarsView = tempGrayStarsView;
    
}

/*
 icon_productedit_stars_full, icon_productedit_stars_half, icon_productedit_stars_empty
 btn_assess_star_on, btn_assess_star_off
 */

- (void)creatYellowStarsViewByFrame {
    UIView *tempYellowStarsView = [[UIView alloc] initWithFrame:CGRectMake(kHorizontalSpace, kVerticalSpace, kStarViewWidth, kStarViewHeight)];
    tempYellowStarsView.backgroundColor = [UIColor clearColor];
    tempYellowStarsView.clipsToBounds = YES;
    
    for (NSInteger i = 0; i < kTotalStarCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:@"icon_productedit_stars_full"];
        [tempYellowStarsView addSubview:imgView];
        imgView.frame = CGRectMake(i * (kStarImageWidth + kStarImagePidding), 0, kStarImageWidth, kStarImageWidth);
    }
    
    _yellowStarsView = tempYellowStarsView;
}




@end







#pragma mark - ******************** 触摸事件处理部分 ********************
/** cl_remind
 如果发现计算出现问题，请先确定showStyle设置是否正确
 BYStarViewYellowStarShowStyle_CeilInt 或 BYStarViewYellowStarShowStyle_CeilHalf
 */
@implementation ETStarView (TouchSlideHelper)

#define touchRect   CGRectMake(self.frame.origin.x-100, self.frame.origin.y-100, 200, 200)
#define viewRect    CGRectMake(-100, -100, 200, 200)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(touchRect, point)) {
        return self;
    }
    return  [super hitTest:point withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    if (CGRectContainsPoint(viewRect, touchPoint)) {
        CGFloat tempWidth = [self calculateTouchStarsWidthByTouchPointX:touchPoint.x];
        self.rating = tempWidth / kStarImageWidth;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self];
    if (CGRectContainsPoint(viewRect, touchPoint)) {
        CGFloat tempWidth = [self calculateMoveStarsWidthByTouchPointX:touchPoint.x];
        self.rating = tempWidth / kStarImageWidth;
    }
}

/** Touch:根据触摸点计算出显示的黄色星星绝对宽度(无间隙) */
- (CGFloat)calculateTouchStarsWidthByTouchPointX:(CGFloat)pointX {
    CGFloat tempWidth = 0.0;
    //    CGFloat usefulPadding = kStarImagePidding * 0.5;
    //    CGFloat usefulImageWidth = kStarImageWidth + usefulPadding * 2;
    
    // 这么写可读性更高（其实我就是懒得抽取方法啦~\(≧▽≦)/~）
    if (pointX < kHorizontalSpace) {
        tempWidth = 0.0;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 1) {
        tempWidth = pointX - kHorizontalSpace - kStarImagePidding * 0;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 1 + kStarImagePidding * 1) {
        tempWidth = kStarImageWidth * 1;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 2 + kStarImagePidding * 1) {
        tempWidth = pointX - kHorizontalSpace - kStarImagePidding * 1;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 2 + kStarImagePidding * 2) {
        tempWidth = kStarImageWidth * 2;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 3 + kStarImagePidding * 2) {
        tempWidth = pointX - kHorizontalSpace - kStarImagePidding * 2;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 3 + kStarImagePidding * 3) {
        tempWidth = kStarImageWidth * 3;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 4 + kStarImagePidding * 3) {
        tempWidth = pointX - kHorizontalSpace - kStarImagePidding * 3;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 4 + kStarImagePidding * 4) {
        tempWidth = kStarImageWidth * 4;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 5 + kStarImagePidding * 4) {
        tempWidth = pointX - kHorizontalSpace - kStarImagePidding * 4;
    }else if (pointX < kHorizontalSpace + kStarImageWidth * 5 + kStarImagePidding * 5) {
        tempWidth = kStarImageWidth * 5;
    }else {
        tempWidth = kStarImageWidth * 5;
    }
    //NSLog(@"tempWidth:%.2f", tempWidth);
    return tempWidth;
}

/** Move:根据触摸点计算出显示的黄色星星绝对宽度(无间隙) */
- (CGFloat)calculateMoveStarsWidthByTouchPointX:(CGFloat)pointX {
    // 实际逻辑可能不一致，待处理
    return [self calculateTouchStarsWidthByTouchPointX:pointX];
}

@end

