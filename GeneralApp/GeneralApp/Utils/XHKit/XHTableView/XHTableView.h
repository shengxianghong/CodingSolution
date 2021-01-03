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
@property (nonatomic, strong) NSMutableArray *listMuArray;
@property (nonatomic, assign) int correctPage;
@property (nonatomic, getter=isLoading) BOOL loading;
@end

NS_ASSUME_NONNULL_END
