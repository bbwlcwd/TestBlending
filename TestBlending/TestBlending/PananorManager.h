//
//  PananorManager.h
//  TestBlending
//
//  Created by chenweidong on 2018/4/10.
//  Copyright © 2018年 chenweidong. All rights reserved.
//工程配置https://segmentfault.com/a/1190000003105187
// 本工程使用的的openvc版本是2.4.10 下载地址：https://sourceforge.net/projects/opencvlibrary/files/opencv-ios/
//遇到的问题与解决办法 https://blog.csdn.net/u014068781/article/details/52890525

#import <Foundation/Foundation.h>

@interface PananorManager : NSObject
-(BOOL)insertImageWithImagePath:(NSString *)imagePath;
-(BOOL)savePanoImageToPath:(NSString *)outPutFilePath;
@end
