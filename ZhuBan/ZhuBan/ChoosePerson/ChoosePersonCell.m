//
//  ChoosePersonCell.m
//  ZhuBan
//
//  Created by s&z on 2020/10/21.
//

#import "ChoosePersonCell.h"

@implementation ChoosePersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)chooseZhuBanAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.clickZhuBanBlock) {
        self.clickZhuBanBlock(sender.isSelected);
    }
}

- (IBAction)choosePersonAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.clickPersonBlock) {
        self.clickPersonBlock(sender.isSelected);
    }
}

@end
