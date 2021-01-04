//
//  AppHeader.h
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#ifndef AppHeader_h
#define AppHeader_h
 
//release
//#define API_URL_BASE @""
//debug
#define API_URL_BASE @"https://m.api.zhe800.com/"

// Screen
#define kScreen_Bounds  [[UIScreen mainScreen] bounds]
#define kScreen_Width    [[UIScreen mainScreen] bounds].size.width
#define kScreen_Height   [[UIScreen mainScreen] bounds].size.height

// weakSelf
#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self;

#endif /* AppHeader_h */
