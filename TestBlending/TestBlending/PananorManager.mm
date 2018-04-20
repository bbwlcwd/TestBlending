//
//  PananorManager.m
//  TestBlending
//
//  Created by chenweidong on 2018/4/10.
//  Copyright © 2018年 chenweidong. All rights reserved.
//

#import "PananorManager.h"
#include "dana_panorama.h"

using namespace std;
using namespace cv;

@interface PananorManager()
@property(nonatomic, assign) dana_pano_info *panno;
@property(nonatomic, assign) BOOL isFirstImage;
@end

@implementation PananorManager

-(instancetype)init{
    self = [super init];
    if (self) {
        _isFirstImage = YES;
        [self setUpInfo];
    }
    return self;
}


-(void)setUpInfo{
    Mat result;
    double cameraMat[3][3]={{1086.824276893329/2,0, 270},{0, 1086.824276893329/2, 540},{0, 0, 1}};//1080x1920的camera坐标参数
    double dist[5]={-0.4177642150313481,0.2237463754008228,0,0,-0.0716236427291802};
    _panno = dana_pano_info_create(200, DANA_BLENDING_MODE_OPTIMAL_SEAMLINE, cameraMat, dist, 540, 960);
}


-(BOOL)insertImageWithImagePath:(NSString *)imagePath{
    
    if (!imagePath || imagePath.length == 0) {
        return NO;
    }
     char img_name[1024];
    strcpy(img_name, [imagePath UTF8String]);
    Mat img=imread(img_name,1);
    Mat newImg;
    resize(img,newImg,Size2i(540,960),0,0,INTER_LINEAR);
    if (self.isFirstImage) {
        dana_pano_process(self.panno,newImg,1);
        self.isFirstImage = NO;
    }else{
         dana_pano_process(self.panno,newImg,0);
    }
    
    return YES;
}

-(BOOL)savePanoImageToPath:(NSString *)outPutFilePath{
    
    if (!outPutFilePath || outPutFilePath.length == 0) {
        return NO;
    }
    NSString *path = outPutFilePath;
    char file[1024];
    strcpy(file, [path UTF8String]);
    
   bool ret = imwrite(file,self.panno->outimg);
    NSLog(@"image path = %@    %d", path, ret);
    dana_pano_info_destroy(self.panno);
    
    return ret;
}

@end
