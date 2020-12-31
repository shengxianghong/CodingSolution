//
//  XHCacheTool.m
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import "XHCacheTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "CacheConstant.h"

@implementation XHCacheTool
+ (void)cacheForData:(NSData *)data fileName:(NSString *)fileName {
    NSString *path = [kCachePath stringByAppendingPathComponent:[XHMD5 md5:fileName]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [data writeToFile:path atomically:YES];
    });
}

+ (NSData *)getCacheFileName:(NSString *)fileName {
    NSString *path = [kCachePath stringByAppendingPathComponent:[XHMD5 md5:fileName]];
    return [[NSData alloc] initWithContentsOfFile:path];
}

+ (NSUInteger)getAFNSize {
    NSUInteger size = 0;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:kCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [kCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];//B字节 --> 转化MB folderSize/(1024.0*1024.0); 返回数据类型改为float
    }
    return size;
}

+ (NSUInteger)getSize {
    //获取AFN的缓存大小
    NSUInteger afnSize = [self getAFNSize];
    return afnSize;
}

+ (void)clearAFNCache {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:kCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [kCachePath stringByAppendingPathComponent:fileName];
        
        [fm removeItemAtPath:filePath error:nil];
        
    }
}

+ (void)clearCache {
    [self clearAFNCache];
}

+ (BOOL)isExpire:(NSString *)fileName {
    NSString *path = [kCachePath stringByAppendingPathComponent:[XHMD5 md5:fileName]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *attributesDict = [fm attributesOfItemAtPath:path error:nil];
    NSDate *fileModificationDate = attributesDict[NSFileModificationDate];
    NSTimeInterval fileModificationTimestamp = [fileModificationDate timeIntervalSince1970];
    //现在的时间戳
    NSTimeInterval nowTimestamp = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    return ((nowTimestamp-fileModificationTimestamp)>kRTCache_Expire_Time);
}
@end

@implementation XHMD5
+ (NSString *)md5:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
