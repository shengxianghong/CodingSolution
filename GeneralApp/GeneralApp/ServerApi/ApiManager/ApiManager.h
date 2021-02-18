//
//  ApiManager.h
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import <Foundation/Foundation.h>
#import "XHNetWork.h"
#import "BaseController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ShowHudType){
    HudNone = 0,
    HudCostum,
    HudSubmit
};

typedef void (^DataResultBlock)(NSDictionary *data, NSError  * _Nullable error);

@interface ApiManager : NSObject
+ (ApiManager *)shardInstance;
- (void)requestWithType:(XHRequestType)requsetType
                    url:(NSString *)urlString
                  param:(nullable NSDictionary *)param
         viewController:(nullable BaseController *)baseVC
                hudType:(ShowHudType)hudType
            resultBlock:(DataResultBlock)block;
@end

NS_ASSUME_NONNULL_END
