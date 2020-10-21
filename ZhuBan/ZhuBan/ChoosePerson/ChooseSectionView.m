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

@end
