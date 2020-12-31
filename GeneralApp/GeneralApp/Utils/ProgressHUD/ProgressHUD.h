//
//  ProgressHUD.h
//  ProgressHUD
//
//  Created by sxh on 2019/8/26.
//  Copyright © 2019 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ProgressHUDStatus) {
    ProgressHUDStatusTrue = 0,
    ProgressHUDStatusError,
    ProgressHUDStatusOther
};

@interface ProgressHUD : NSObject

// hidden progress HUD view.
+ (void)hideProgress:(UIView*)view;

// show common progress HUD view within no icon.
+ (void)showProgressText:(NSString *)text;

// show 
+ (void)showSubmitProgress:(UIView*)view text:(NSString *)text;

// show
+ (void)showStatusProgress:(UIView*)view text:(NSString *)text status:(ProgressHUDStatus)status;

// show 
+ (void)showCustomProgress:(UIView*)view;

+ (void)showDownProgress:(NSProgress *)progressObject addView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
