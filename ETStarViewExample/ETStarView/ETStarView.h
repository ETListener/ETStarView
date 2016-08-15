//
//  ETStarView.h
//  ETStarViewExample
//
//  Created by chenglei on 16/8/11.
//  Copyright © 2016年 ETListener. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Masonry.h"
#import "UIView+LayoutMethods.h"



static CGFloat const kStarViewWidth = 16.f * 5 + 3.f * 4;  //(kStarWidth * 5 + kStarPidding * 4)
static CGFloat const kStarViewHeight = 20.f;



/** yellowStar显示的样式 */
typedef NS_ENUM(NSInteger, BYStarViewYellowStarShowStyle) {
    BYStarViewYellowStarShowStyle_None = 0,     // 未设置(使用必须先设置非None)
    BYStarViewYellowStarShowStyle_RoundInt = 1,     // 整颗【四舍五入，4.49->4;4.50->5】
    BYStarViewYellowStarShowStyle_FloorInt = 2,     // 整颗【向下取整，3.9->3】
    BYStarViewYellowStarShowStyle_CeilInt = 3,      // 整颗【向上取整，3.1->4】
    
    BYStarViewYellowStarShowStyle_Float = 10,   // 小数
    BYStarViewYellowStarShowStyle_RoundHalf = 11,   // 半颗【相对四舍五入，4.24->4;4.25->4.5】
    BYStarViewYellowStarShowStyle_FloorHalf = 12,   // 半颗【向下相对取整，3.9->3.5】
    BYStarViewYellowStarShowStyle_CeilHalf = 13,    // 半颗【向上相对取整，3.1->3.5】
};


/** 星星视图 */
@interface ETStarView : UIView

@property (nonatomic, assign) CGFloat rating;   // 星评分数(set设置后会自动根据显示样式showStyle换算成实际显示星星的分数，值改变为时间显示的星星个数)
@property (nonatomic, assign) BOOL isShowGrayStar;  // 是否显示灰色星星，YES:显示。default is NO

// 注：canTouchSlide模式showStyle为相应的ceil好用一些。 _CeilInt或_CeilHalf
@property (nonatomic, assign) BOOL canTouchSlide; // 是否能【点击】或【滑动】改变分数，YES:能。default is NO



// 初始化方法
//- (instancetype)initWithRating:(CGFloat)rating showStyle:(BYStarViewYellowStarShowStyle)showStyle;
//+ (instancetype)creatWithRating:(CGFloat)rating showStyle:(BYStarViewYellowStarShowStyle)showStyle;

/**
 *  创建基于Frame布局的星星视图
 *
 *  @param rating    原始星评分数(set设置后会自动根据显示样式showStyle换算成实际显示星星的分数，值改变为时间显示的星星个数)
 *  @param showStyle yellowStar显示的样式
 *
 *  @return BYStarView
 */
//+ (instancetype)creatFrameLayoutWithRating:(CGFloat)rating showStyle:(BYStarViewYellowStarShowStyle)showStyle;

/**
 *  创建基于Masonry布局的星星视图
 *
 *  @param rating    原始星评分数(set设置后会自动根据显示样式showStyle换算成实际显示星星的分数，值改变为时间显示的星星个数)
 *  @param showStyle yellowStar显示的样式
 *
 *  @return BYStarView
 */
+ (instancetype)creatMasonryLayoutWithRating:(CGFloat)rating showStyle:(BYStarViewYellowStarShowStyle)showStyle;



@end
