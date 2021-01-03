//
//  ApiManager.m
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//
#define kCacheValue 1
#define CustomErrorDomain @"com.zkword.ErrorDomain"

#import "ApiManager.h"
#import "ProgressHUD.h"

static ApiManager *apiManager;

@implementation ApiManager
+ (ApiManager *)shardInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiManager = [[ApiManager alloc] init];
    });
    return apiManager;
}

- (void)requestWithRequsetType:(XHRequestType)requsetType url:(NSString *)urlString param:(nullable NSDictionary *)param viewController:(nullable BaseController *)vc hudType:(ShowHudType)hudType resultBlock:(DataResultBlock)block {
    if (hudType == 1) {
        [ProgressHUD showCustomProgress:vc.view];
    }else if (hudType == 2) {
        [ProgressHUD showSubmitProgress:vc.view text:@""];
    }
    [XHNetWork requestDataWithMethod:requsetType url:urlString params:param cacheType:1 success:^(id  _Nonnull responseObject) {
        [ProgressHUD hideProgress:vc.view];
        NSDictionary *data = (NSDictionary *)responseObject;
        [self successSettings:data viewController:vc resultBlock:block];
    } failure:^(NSError * _Nonnull error) {
        [ProgressHUD hideProgress:vc.view];
        [self failMessage:error viewController:vc resultBlock:block];
    }];
}

- (void)failMessage:(NSError *)error viewController:(nullable BaseController *)vc resultBlock:(DataResultBlock)block {
    NSString *strMsg = nil;
    long  errorCode= [error code];
    switch (errorCode) {
        case -1009:
            strMsg = NSLocalizedString(NoNetworkText, @"");
            break;
        case -1001:
            strMsg = NSLocalizedString(RequestTimeOutText, @"");
            break;
        default:
            strMsg = NSLocalizedString(ServerBusyText, @"");
            break;
    }
    NSDictionary *dict = @{@"message":[NSString stringWithFormat:@"%@(%ld)",strMsg,errorCode]};
    [self successSettings:dict viewController:vc resultBlock:block];
}

- (void)successSettings:(NSDictionary *)data viewController:(nullable BaseController *)vc resultBlock:(DataResultBlock)block {
    if (!data) return;
    if ([[data objectForKey:@"code"] integerValue] == 200) {
        vc.errorView.hidden = YES;
        if (block) block(data, nil);
    }else {
        NSString *message = [NSString stringWithFormat:@"%@",[data objectForKey:@"message"]];
        vc.errorView.hidden = NO;
        vc.errorView.errorLabel.text = message;
        __weak __typeof(&*vc) weakVc = vc;
        vc.errorView.reloadDataBlock = ^{
            [weakVc loadDisplayData];
        };
        NSError *error = [NSError errorWithDomain:CustomErrorDomain code:-1000 userInfo:nil];
        if (block) block(data, error);
    }
}
@end
