//
//  XHTableView.h
//  GeneralApp
//
//  Created by s&z on 2021/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHTableView : UITableView

@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface RefreshTableView : XHTableView
@property (nonatomic, assign) int correctPage;
@property (nonatomic, getter=isShowHud) BOOL showHud;
@property (nonatomic, strong) NSMutableArray *listMuArray;

@property (nonatomic, copy) void (^refreshPageBlock) (void);

- (void)endRefersh;
- (void)creatListDataArray:(NSMutableArray *)muArray;
@end

NS_ASSUME_NONNULL_END
