//
//  ChooseSectionView.h
//  ZhuBan
//
//  Created by zkworld on 2020/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseSectionView : UIView
@property (weak, nonatomic) IBOutlet UIButton *arrowButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (nonatomic, copy) void (^chooseGroupBlock) (BOOL choose);
@property (nonatomic, copy) void (^arrowSentionBlock) (BOOL choose);

@end

NS_ASSUME_NONNULL_END
