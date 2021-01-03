//
//  BaseController.h
//  GeneralApp
//
//  Created by s&z on 2021/1/2.
//

#import <UIKit/UIKit.h>
#import "XHErrorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseController : UIViewController
//error view
@property (nonatomic, strong) XHErrorView *errorView;
//load data
- (void)loadDisplayData;
@end

NS_ASSUME_NONNULL_END
