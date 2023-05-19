//
//  OpenCVwrapper.m
//  carNumber
//
//  Created by 박경춘 on 2023/05/19.
//

#import "OpenCVwrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

using namespace std;
using namespace cv;

@implementation OpenCVwrapper

#pragma mark Public

+ (UIImage *)toGray:(UIImage *)image {
    
    cv::Mat imageMat;
    
    UIImageToMat(image, imageMat);
    
    if (imageMat.channels() == 1)
        return image;
    
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, COLOR_BGR2GRAY);
    
    return MatToUIImage(grayMat);
    
}


@end
