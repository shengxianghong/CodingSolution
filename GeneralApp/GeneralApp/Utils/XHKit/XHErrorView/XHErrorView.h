//
//  XHErrorView.h
//  GeneralApp
//
//  Created by s&z on 2021/1/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHErrorView : UIView
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIButton *againButton;
@property (nonatomic, copy) void (^reloadDataBlock) (void);

@end

NS_ASSUME_NONNULL_END
