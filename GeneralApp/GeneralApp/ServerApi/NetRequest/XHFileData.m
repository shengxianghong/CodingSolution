//
//  XHFileData.m
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import "XHFileData.h"

@implementation XHFileData
static  NSArray*_fileArray = nil;

+ (NSArray *)fileArray {
    if (_fileArray == nil) {
        _fileArray = [[NSArray alloc] init];
      }
      return _fileArray;
}

+ (void)setFileArray:(NSArray *)fileArray {
    if (fileArray != _fileArray) {
        _fileArray = [fileArray copy];
      }
}
@end

@implementation XHFileListModel

@end
