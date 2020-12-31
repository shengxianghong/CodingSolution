//
//  XHNetWork.h
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XHCacheType){
    CacheTypeReturnCacheDataThenLoad = 0,///< 有缓存就先返回缓存，同步请求数据
    CacheTypeReloadIgnoringLocalCacheData, ///< 忽略缓存，重新请求
    CacheTypeReturnCacheDataElseLoad,///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    CacheTypeReturnCacheDataDontLoad,///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
    CacheTypeReturnCacheDataExpireThenLoad///< 有缓存就用缓存，如果过期了就重新请求 没过期就不请求
};

typedef NS_ENUM(NSUInteger, XHRequestType){
    XHRequestGET = 0,
    XHRequestPOST,
    XHRequestPATCH,
    XHRequestDELETE,
    XHRequestIMAGE,
    XHRequestFILE,
};

@interface XHNetWork : NSObject
+ (void)requestDataWithMethod:(XHRequestType)method url:(NSString *)url params:(nullable NSDictionary *)params cacheType:(XHCacheType)cacheType success:(void(^)(id responseObject))success failure:(void (^)(NSError *))failure;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface XHCache : NSObject
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, assign) BOOL result;
@end

NS_ASSUME_NONNULL_END

