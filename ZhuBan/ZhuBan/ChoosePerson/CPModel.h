//
//  CPModel.h
//  ZhuBan
//
//  Created by s&z on 2020/10/21.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPItemModel : NSObject
@property (nonatomic, copy) NSString *rybh;
@property (nonatomic, copy) NSString *bm;
@property (nonatomic, copy) NSString *yhry;
@property (nonatomic, assign, getter=isChoose) BOOL choose;
@property (nonatomic, assign, getter=isZhuban) BOOL zhuban;

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface CPModel : NSObject<MJKeyValue,MJCoding>
@property (nonatomic, copy) NSString *mc;
@property (nonatomic, copy) NSString *dwbh;
@property (nonatomic, copy) NSString *bmh;
@property (nonatomic, copy) NSString *xjcount;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign, getter=isChoose) BOOL choose;
@property (nonatomic, assign, getter=isZhankai) BOOL zhankai;

@end

NS_ASSUME_NONNULL_END
