//
//  XHFileData.h
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHFileData : NSObject
@property (class, nonatomic, strong) NSArray *fileArray;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface XHFileListModel : NSObject
@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *filename;
@end

NS_ASSUME_NONNULL_END
