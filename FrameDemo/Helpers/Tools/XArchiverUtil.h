//
//  XArchiverUtil.h
//  Unity-iPhone
//
//  Created by xueyiwangluo on 15/12/10.
//
//

#import <Foundation/Foundation.h>


@interface XArchiverUtil : NSObject

+ (void)archiverWithObj:(id)obj objKey:(NSString *)key;

+ (id)unArchiverWithKey:(NSString *)key;

@end
