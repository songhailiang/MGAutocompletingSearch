//
//  UITextField+Extension.h
//  50+sh
//
//  Created by 宋海梁 on 15/12/4.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import <UIKit/UIKit.h>

//UITextField底部下划线颜色
#define kTextFieldBottomLineColor   [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]
//UITextField placeholder颜色
#define kTextFieldPlaceHolderColor  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]

@interface UITextField (Extension)

/**
 *  设置leftview为图片
 *
 *  @param imageName 图片名称
 */
- (void)setLeftViewWithImageName:(NSString *)imageName;

/**
 *  设置leftView为文字
 *
 */
- (void)setLeftViewWithText:(NSString *)text;

/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param minWidth 最小宽度
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth;

/**
 *  设置rightView为文字
 *
 *  @param text 文字
 */
- (void)setRightViewWithText:(NSString *)text;

/**
 *  设置leftView为文字
 *
 *  @param text  文字
 *  @param width 最小宽度
 *  @param color 占位文字颜色
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth color:(UIColor *)color;


/**
 *  设置rightView为图片
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewWithImageName:(NSString *)imageName;

/**
 *  设置UITextField左侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingLeftSpace:(float)padding;

/**
 *  设置UITextField右侧内边距
 *
 *  @param padding 距离
 */
- (void)setPaddingRightSpace:(float)padding;

/**
 *  设置底部边框
 *
 *  @param lineColor 边框颜色
 */
- (void)setBottomBorderLineWithColor:(UIColor *)lineColor;

/**
 *  设置placeholder的颜色
 *
 */
- (void)setPlaceholderColor:(UIColor *)color;

/**
 *  设置rightView为button
 *
 *  @param imageName 图片名称
 */
- (void)setRightViewButtonWithImageName:(NSString *)imageName taget:(id)taget selector:(SEL)selector;
/**
 *  设置下划线出去左边的文字
 */
- (void)setLeftViewWithText:(NSString *)text minWidth:(CGFloat)minWidth withOutTextBottomLineColor:(UIColor *)color;
@end
