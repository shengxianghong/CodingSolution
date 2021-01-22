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
@property (nonatomic, getter=isLoading) BOOL loading;
@end
@implementation RefreshTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showHud = YES;
    self.correctPage = 1;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
     [refreshControl addTarget:self action:@selector(loadHeaderData) forControlEvents:UIControlEventValueChanged];
     self.refreshControl = refreshControl;
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.showHud = NO;
        if (self.refreshPageBlock) {
            self.refreshPageBlock();
        }
    }];
    self.mj_footer.hidden = YES;
     
     self.emptyDataSetSource = self;
     self.emptyDataSetDelegate = self;
     self.tableFooterView = [UIView new];
}

- (void)loadHeaderData {
    self.showHud = NO;
    self.correctPage = 1;
    if (self.refreshPageBlock) {
        self.refreshPageBlock();
    }
}

- (void)endRefersh {
    self.loading = NO;
    [self.refreshControl endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)creatListDataArray:(NSMutableArray *)muArray {
    if (self.correctPage == 1) {
        self.listMuArray = muArray;
        self.mj_footer.hidden = muArray.count == 0;
    }else {
        self.mj_footer.hidden = NO;
        [self.listMuArray addObjectsFromArray:muArray];
        if (muArray.count < 10) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    }
    self.correctPage ++;
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
    [self loadHeaderData];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.isLoading;
}


@end
