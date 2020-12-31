//
//  CacheConstant.h
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#ifndef CacheConstant_h
#define CacheConstant_h

/**
 缓存的有效期  单位是s
 */
#define kRTCache_Expire_Time (3600*24)
/**
 *  沙盒Cache路径
 */
#define kCachePath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject])

#endif /* CacheConstant_h */
