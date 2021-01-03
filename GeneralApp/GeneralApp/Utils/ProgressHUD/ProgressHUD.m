//
//  ProgressHUD.m
//  ProgressHUD
//
//  Created by sxh on 2019/8/26.
//  Copyright © 2019 iMac. All rights reserved.
//

#import "ProgressHUD.h"
#import "AppDelegate.h"
#import "UIColor+Category.h"
#import "XHColor.h"
#import "UIImage+ToastGIF.h"

//顶部Navi高度
#define NaviBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)

@implementation ProgressHUD

+ (void)hideProgress:(UIView*)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)showProgressText:(NSString *)text {
    UIWindow *keywindow = [ProgressHUD keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keywindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(text, @"title");
    hud.label.numberOfLines = 0;
    hud.offset = CGPointMake(0.0f, 0.0f);
    [hud hideAnimated:YES afterDelay:2.0f];
}

+ (void)showSubmitProgress:(UIView*)view text:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = NSLocalizedString(text, @"title");
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
}

+ (void)showStatusProgress:(UIView*)view text:(NSString *)text status:(ProgressHUDStatus)status {
    //clear old Hud.
    [MBProgressHUD hideHUDForView:view animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    NSString *imageName = [[NSString alloc] init];
    if (status == ProgressHUDStatusTrue) {
        imageName = @"success";
        hud.contentColor = [UIColor blackColor];
    }else if (status == ProgressHUDStatusError) {
        //imageName = @"error";
        hud.contentColor = [UIColor hex:@"#FF0000"];
    }else {
        imageName = @"tips";
    }
    UIImage *image =  status == ProgressHUDStatusError ? [[UIImage alloc] init] : [UIImage imageNamed:imageName];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.label.text = NSLocalizedString(text, @"title");
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:2.0f];
}

+ (void)showCustomProgress:(UIView*)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *gifImageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage sd_animatedGIFNamed:@"loading"];
    gifImageView.image = image;
    hud.customView = gifImageView;
    hud.backgroundColor = XHColor.white1;
    hud.bezelView.backgroundColor = XHColor.white1;
    hud.bezelView.color = XHColor.white1;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
}

+ (void)showDownProgress:(NSProgress *)progressObject addView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.progressObject = progressObject;
}

#pragma mark -keyWindow

+ (UIWindow *)keyWindow {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *keywindow = delegate.window;
    return keywindow;
}

@end
