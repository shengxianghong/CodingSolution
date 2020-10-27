//
//  CPModel.m
//  ZhuBan
//
//  Created by s&z on 2020/10/21.
//

#import "CPModel.h"


@implementation CPItemModel

@end


@implementation CPModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"items":[CPItemModel class]};
}

@end
