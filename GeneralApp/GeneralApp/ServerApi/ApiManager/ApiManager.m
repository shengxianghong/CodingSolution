//
//  ApiManager.m
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//
#define kCacheValue 1
#define CustomErrorDomain @"com.zkword.ErrorDomain"

#import "ApiManager.h"

static ApiManager *apiManager;

@implementation ApiManager
+ (ApiManager *)shardInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiManager = [[ApiManager alloc] init];
    });
    return apiManager;
}

- (void)requestWithRequsetType:(XHRequestType)requsetType url:(NSString *)urlString param:(nullable NSDictionary *)param view:(nullable UIView *)view hudType:(ShowHudType)hudType resultBlock:(DataResultBlock)block {
    [XHNetWork requestDataWithMethod:requsetType url:urlString params:param cacheType:1 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        [self successSettings:data resultBlock:block];
    } failure:^(NSError * _Nonnull error) {
        [self failMessage:error resultBlock:block];
    }];
}

- (void)failMessage:(NSError *)error resultBlock:(DataResultBlock)block {
    NSString *strMsg = nil;
    long  errorCode= [error code];
    switch (errorCode) {
        case -1009://网络无连接。模拟器一直返回此状态。
            strMsg = @"当前网络不可用，请检查网络设置";
            break;
        case -1001://网络请求超时
            strMsg = @"网络请求超时";
            break;
        default:
            strMsg = @"服务器繁忙，请稍后操作";
            break;
    }
    NSDictionary *dict = @{@"message":strMsg};
    [self successSettings:dict resultBlock:block];
}

- (void)successSettings:(NSDictionary *)data resultBlock:(DataResultBlock)block {
    if (!data) return;
    if ([[data objectForKey:@"code"] integerValue] == 200) {
        if (block) block(data, nil);
    }else {
//        NSString *message = [NSString stringWithFormat:@"%@",[data objectForKey:@"msg"]];
        NSError *error = [NSError errorWithDomain:CustomErrorDomain code:-1000 userInfo:nil];
        if (block) block(data, error);
    }
}
@end
