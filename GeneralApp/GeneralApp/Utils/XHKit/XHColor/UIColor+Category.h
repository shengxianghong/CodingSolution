//
//  UIColor+Category.h
//  KidsBall
//
//  Created by sxh on 2019/9/9.
//  Copyright © 2019 sxh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  功能:通过RGB创建颜色
 *
 *  @param red <CGFloat> <范围:0~255.0>
 *  @param green <CGFloat> <范围:0~255.0>
 *  @param blue <CGFloat> <范围:0~255.0>
 *
 *  @return UIColor
 *
 *  example: rgb(173.0,23.0,11.0)
 */
UIColor *rgb(CGFloat red, CGFloat green, CGFloat blue);

/**
 *  功能:通过RGB以及alpha创建颜色
 *
 *  @param red <CGFloat> <范围:0~255.0>
 *  @param green <CGFloat> <范围:0~255.0>
 *  @param blue <CGFloat> <范围:0~255.0>
 *  @param alpha <CGFloat> <范围:0~1.0>
 *
 *  @return UIColor
 *
 *  example: rgbA(173.0,23.0,11.0,0.5)
 */
UIColor *rgbA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);


@interface UIColor (Category)

/**
 *  Create a color from a HEX string.
 *  It supports the following type:
 *  - #RGB
 *  - #ARGB
 *  - #RRGGBB
 *  - #AARRGGBB
 *
 *  @param hexString NSString
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor *)hex:(NSString *)hexString;

/**
 *  通过0xffffff的16进制数字创建颜色
 *
 *  @param aRGB 0xffffff
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithRGB:(NSUInteger)aRGB;


/**
 调节颜色的明亮度
 
 @param color 颜色
 @param delta 明亮度
 @return return value description
 */
+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta;


/**
 调整颜色的透明度
 
 @param color 颜色
 @param delta 透明度
 @return <#return value description#>
 */
+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withAlphaDelta:(CGFloat)delta;

//随机色
+ (UIColor *)randomColor;
@end

NS_ASSUME_NONNULL_END
