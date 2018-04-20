#ifndef DANA_PANORAMA_H
#define DANA_PANORAMA_H

#include <iostream>
#include <string>
#include <unistd.h>
#include <stdio.h>
#include <math.h>
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
//#include <opencv2/calib3d/calib3d.hpp>
#include "opencv2/highgui/highgui.hpp"

using namespace cv;


typedef enum _dana_blending_mode_e {    
     DANA_BLENDING_MODE_LINEAR              = 0, //图像融合-渐入渐出算法
     DANA_BLENDING_MODE_MUTLI_BAND          = 1, //图像融合-多频段融合算法
     DANA_BLENDING_MODE_OPTIMAL_SEAMLINE    = 2, //图像融合-最佳融合线算法
} dana_blending_mode_t;

typedef struct _dana_cabli_map{
    Mat map_x;
    Mat map_y;
}cabli_map;

typedef struct _dana_pano_info
{   
   Mat outimg;
    int align_x;
   dana_blending_mode_t Mode;
   double (*cameraMat)[3];
   double *dist;
   cabli_map map_coff;
}dana_pano_info;





dana_pano_info *dana_pano_info_create(const int align_x, dana_blending_mode_t Mode, double cameraMat[][3],  double dist[],int W,int H);
void dana_pano_process(dana_pano_info *pano, Mat newImg, bool IS_FIRST);
void dana_pano_info_destroy(dana_pano_info *pano);


#endif
