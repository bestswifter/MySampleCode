//
//  UIView+KtExtension.h
//  KtTableView
//
//  Created by baidu on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KtExtension)

//frame accessors
/*!
 @brief 初始坐标
 */
@property (nonatomic, assign) CGPoint origin;
/*!
 @brief View大小
 */
@property (nonatomic, assign) CGSize size;
/*!
 @brief 顶部坐标值
 */
@property (nonatomic, assign) CGFloat top;
/*!
 @brief 左部坐标值
 */
@property (nonatomic, assign) CGFloat left;
/*!
 @brief 底部坐标值
 */
@property (nonatomic, assign) CGFloat bottom;
/*!
 @brief 右部坐标值
 */
@property (nonatomic, assign) CGFloat right;
/*!
 @brief 宽度值
 */
@property (nonatomic, assign) CGFloat width;
/*!
 @brief 高度值
 */
@property (nonatomic, assign) CGFloat height;
/*!
 @brief 中心点X坐标
 */
@property (nonatomic, assign) CGFloat x;
/*!
 @brief 中心点Y坐标
 */
@property (nonatomic, assign) CGFloat y;

//bounds accessors
/*!
 @brief 边界大小
 */
@property (nonatomic, assign) CGSize boundsSize;
/*!
 @brief 边界宽度
 */
@property (nonatomic, assign) CGFloat boundsWidth;
/*!
 @brief 边界高度
 */
@property (nonatomic, assign) CGFloat boundsHeight;

//content getters
/*!
 @brief 边界区域
 */
@property (nonatomic, readonly) CGRect contentBounds;
/*!
 @brief 边界中心点
 */
@property (nonatomic, readonly) CGPoint contentCenter;

@end
