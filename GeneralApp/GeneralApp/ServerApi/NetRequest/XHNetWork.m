//
//  XHNetWork.m
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import "XHNetWork.h"
#import "XHCacheTool.h"

@implementation XHNetWork

+ (void)requestDataWithMethod:(XHRequestType)method url:(NSString *)url params:(nullable NSDictionary *)params cacheType:(XHCacheType)cacheType success:(void(^)(id responseObject))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *sessionManager = [XHNetWork sessionManager];
    NSString *urlString = [[API_URL_BASE stringByAppendingString:url] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (method == XHRequestGET) {
        //can set catch GET
        XHCache *cache = [XHNetWork getCache:cacheType url:url params:params success:success];
        NSString *fileName = cache.fileName;
        if (cache.result) return;
        [sessionManager GET:urlString parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            [XHCacheTool cacheForData:data fileName:fileName];
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if (method == XHRequestPOST) {
        //POST
        [sessionManager POST:urlString parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if (method == XHRequestPATCH) {
        //PATCH
        [sessionManager PATCH:urlString parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if (method == XHRequestDELETE) {
        //DELETE
        [sessionManager DELETE:urlString parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if (method == XHRequestIMAGE) {
        //up load images
        [sessionManager POST:urlString parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSInteger imgCount = 0;
            for (UIImage *image in XHFileData.fileArray) {
                NSData *data = UIImageJPEGRepresentation(image, 0.5);
                NSString *name = [NSString stringWithFormat:@"file[%ld]",(long)imgCount];
                NSString *fileName = [NSString stringWithFormat:@"file%ld.jpeg",(long)imgCount];
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
                imgCount++;
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if (method == XHRequestFILE) {
        //up load files
        [sessionManager POST:urlString parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (XHFileListModel *model in XHFileData.fileArray) {
                [formData appendPartWithFileData:model.data name:@"file" fileName:model.filename mimeType:@"application/octet-stream"];
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}

//sessionManager
+ (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    return sessionManager;
}

+ (XHCache *)getCache:(XHCacheType)cacheType url:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success
{
    //缓存数据的文件名
    NSString *fileName = [self fileName:url params:params];
    NSData *data = [XHCacheTool getCacheFileName:fileName];
    
    XHCache *cache = [[XHCache alloc] init];
    cache.fileName = fileName;
    
    if (data.length) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (cacheType == CacheTypeReloadIgnoringLocalCacheData) {//忽略缓存，重新请求
            
        } else if (cacheType == CacheTypeReturnCacheDataDontLoad) {//有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
            
        } else if (cacheType == CacheTypeReturnCacheDataElseLoad) {//有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
            if (success) {
                success(dict);
            }
            cache.result = YES;
            
        } else if (cacheType == CacheTypeReturnCacheDataThenLoad) {///有缓存就先返回缓存，同步请求数据
            if (success) {
                success(dict);
            }
        } else if (cacheType == CacheTypeReturnCacheDataExpireThenLoad) {//有缓存 判断是否过期了没有 没有就返回缓存
            //判断是否过期
            if (![XHCacheTool isExpire:fileName]) {
                if (success) {
                    success(dict);
                }
                cache.result = YES;
            }
        }
    }
    return cache;
}

+ (NSString *)fileName:(NSString *)url params:(NSDictionary *)params
{
    NSMutableString *mStr = [NSMutableString stringWithString:url];
    if (params != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [mStr appendString:str];
    }
    return mStr;
}

@end

@implementation XHCache

@end

