//
//  ChoosePersonCell.h
//  ZhuBan
//
//  Created by s&z on 2020/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChoosePersonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UIButton *zhubanButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (nonatomic, copy) void (^clickZhuBanBlock) (BOOL choose);
@property (nonatomic, copy) void (^clickPersonBlock) (BOOL choose);

@end

NS_ASSUME_NONNULL_END
