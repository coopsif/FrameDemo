//
//  UIApplication+Addtion.h
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//


#import <UIKit/UIKit.h>

/// Returns "Documents" folder in this app's sandbox.
NSString *NSDocumentsPath(void);

/// Returns "Library" folder in this app's sandbox.
NSString *NSLibraryPath(void);

/// Returns "Caches" folder in this app's sandbox.
NSString *NSCachesPath(void);

@interface UIApplication (Addtion)

/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly,getter=ch_documentsURL) NSURL *documentsURL;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly, getter=ch_cachesURL) NSURL *cachesURL;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly, getter=ch_libraryURL) NSURL *libraryURL;

/// Application's Bundle Name (show in SpringBoard).
@property (nonatomic, readonly, getter=ch_appBundleName) NSString *appBundleName;

/// Application's Bundle ID.  e.g. "com.live Interactive.MyApp"
@property (nonatomic, readonly, getter=ch_appBundleID) NSString *appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nonatomic, readonly, getter=ch_appVersion) NSString *appVersion;

/// Application's Build number. e.g. "123"
@property (nonatomic, readonly, getter=ch_appBuildVersion) NSString *appBuildVersion;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly, getter=ch_memoryUsage) int64_t memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly, getter=ch_cpuUsage) float cpuUsage;

@end
