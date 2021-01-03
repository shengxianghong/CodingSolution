//
//  UIImage+ToastGIF.h
//  QHZG
//
//  Created by 掌控物联网iMac on 2019/7/9.
//  Copyright © 2019 sxh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ToastGIF)

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
