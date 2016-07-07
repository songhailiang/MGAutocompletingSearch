//
//  NSString+Extension.h
//  50+sh
//
//  Created by 宋海梁 on 15/12/4.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 *  获取字符串的实际宽度
 *
 *  @param font   字体
 *  @param height 高度
 *
 *  @return 实际宽度
 */
- (float)widthWithFont:(UIFont *)font height:(float)height;

/**
 *  获取字符串的实际高度
 *
 *  @param font  字体
 *  @param width 宽度
 *
 *  @return 实际高度
 */
- (float)heightWithFont:(UIFont *)font width:(float)width;

/**
 *  获取字符串的实际高度
 *
 *  @param font        字体
 *  @param width       宽度
 *  @param lineSpacing 行间距
 *
 *  @return 实际高度
 */
- (float)heightWithFont:(UIFont *)font width:(float)width lineSpacing:(float)lineSpacing;

/**
 *  返回字体的实际大小
 *
 *  @param font  字体大小
 *  @param width 限制宽度
 *
 *  @return 实际大小
 */
- (CGSize)sizeWithFont:(UIFont *)font width:(float)width lineSpacing:(float)lineSpacing;

/**
 *  判断电话号码是否正确
 *
 *  @return YES:是 NO：否
 */
- (BOOL)isValidateMobile;

/**
 *  判断是否固定电话
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isValidatePhone;

/**
 *  判断是否是400客服电话
 *
 *  @return YES：是 NO：否
 */
- (BOOL)is400Phone;

/**
 *  是否正整数
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isPositiveInteger;

/**
 *  检查输入字符串是否只由英文字母和数字组成
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isNumberOrLetter;

/**
 *  检查输入字符串是否只由汉字和英文字母组成
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isChineseOrLetter;

/**
 *  是否浮点数
 *
 */
- (BOOL)isFloat;

/**
 *  检查输入字符串是否是身份证号
 *
 *  @return YES：是 NO：否
 */
- (BOOL)isIdCard;

/**
 *  转成NSAttributedString
 *
 *  @param lineSpacing 行间距
 *
 *  @return NSAttributedString
 */
- (NSAttributedString *)toAttributeStringWithLineSpacing:(float)lineSpacing;

/**
 *  MD5加密
 *
 *  @return 加密后字符串
 */
- (NSString *)md5;

/**
 *  将空格替换掉
 */
-(NSString *)trim;
/**
 *  去除html格式
 *
 *  @param html html文字
 *
 */
+ (NSString *)filterHtml:(NSString *)html;
/**
 *  搜索飘红
 *
 *  @param searchStr
 *  @param keyWord
 */
+ (NSAttributedString *)searchStrWithSearchString:(NSString*)searchStr keyWord:(NSString *)keyWord start:(NSInteger)start;
/**
 *  转换成拼音
 *
 */
- (NSString *)transformToPinyin;
@end
