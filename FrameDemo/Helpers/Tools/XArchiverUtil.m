//
//  XArchiverUtil.m
//  Unity-iPhone
//
//  Created by xueyiwangluo on 15/12/10.
//
//

#import "XArchiverUtil.h"

@implementation XArchiverUtil

+ (void)archiverWithObj:(id)obj objKey:(NSString *)key
{
    //***********归档，序列化****************
    //1.创建一个可变的二进制流
    NSMutableData *data=[[NSMutableData alloc]init];
    //2.创建一个归档对象(有将自定义类转化为二进制流的功能)
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //3.用该归档对象，把自定义类的对象，转为二进制流
    [archiver encodeObject:obj forKey:key];
    //4归档完毕
    [archiver finishEncoding];
    
    //将data写入文件
    [data writeToFile:[self getObjFilePath] atomically:YES];

//    NSLog(@"archiver data=%@",data);
   
}


+ (NSString *)getObjFilePath
{
    //设定文本框存储文件的位置
    NSString *strFilePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //指定存储文件的文件名
    NSString *fileName=[strFilePath stringByAppendingPathComponent:@"data.archiver"];
    return fileName;
}


+ (id)unArchiverWithKey:(NSString *)key
{
    NSMutableData *mData=[NSMutableData dataWithContentsOfFile:[self getObjFilePath]];
    //2.创建一个反归档对象，将二进制数据解成正行的oc数据
    NSKeyedUnarchiver *unArchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:mData];
    id obj = [unArchiver decodeObjectForKey:key];
    if (obj == nil) {
        NSKeyedUnarchiver *newUnArchiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:mData];
        obj = [newUnArchiver decodeObjectForKey:@"shop"];
    }
    return obj;
}

@end
