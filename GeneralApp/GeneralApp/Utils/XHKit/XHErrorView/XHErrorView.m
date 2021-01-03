//
//  XHErrorView.m
//  GeneralApp
//
//  Created by s&z on 2021/1/2.
//

#import "XHErrorView.h"

@implementation XHErrorView

- (instancetype)init{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"XHErrorView" owner:self options:nil] firstObject];
    }
    return self;
}

- (IBAction)reloadDataAction:(id)sender {
    if (self.reloadDataBlock) {
        self.reloadDataBlock();
    }
}

@end
