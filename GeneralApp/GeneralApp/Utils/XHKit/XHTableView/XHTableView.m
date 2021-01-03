//
//  XHTableView.m
//  GeneralApp
//
//  Created by s&z on 2021/1/3.
//

#import "XHTableView.h"
#import "XHColor.h"
@implementation XHTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = XHColor.white1;
    self.separatorColor = XHColor.white2;
}
@end

@interface RefreshTableView ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end
@implementation RefreshTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//     [refreshControl addTarget:self action:@selector(loadNewHeaderData) forControlEvents:UIControlEventValueChanged];
//     self.refreshControl = refreshControl;
     
     self.emptyDataSetSource = self;
     self.emptyDataSetDelegate = self;
     self.tableFooterView = [UIView new];
}

- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    _loading = loading;
    
    [self reloadEmptyDataSet];
}

#pragma mark - DZNEmptyDataSetSource,DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return[UIImage imageNamed:@"icon_shuaxin"];
    }else {
        return [UIImage imageNamed:@"kongshuju"];
    }
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    self.loading = YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.isLoading;
}


@end
