//
//  MenuVC.h
//  PopoverVC
//
//  Created by s&z on 2020/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuVC : UIViewController
@property (nonatomic, copy) void (^dismissBlock) (void);
@end

NS_ASSUME_NONNULL_END
