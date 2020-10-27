//
//  ChooseSectionView.m
//  ZhuBan
//
//  Created by zkworld on 2020/10/21.
//

#import "ChooseSectionView.h"

@implementation ChooseSectionView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ChooseSectionView" owner:self options:nil] lastObject];
    }
    return self;
}

- (IBAction)arrowButtonAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.arrowSentionBlock) {
        self.arrowSentionBlock(sender.isSelected);
    }
}

- (IBAction)choosePersonAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.chooseGroupBlock) {
        self.chooseGroupBlock(sender.isSelected);
    }
}

@end
