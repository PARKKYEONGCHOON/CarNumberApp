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

+ (UIImage *)toGaussianBlur:(UIImage *)image {
    
    cv::Mat imageMat;
    
    UIImageToMat(image, imageMat);
    
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, COLOR_BGR2GRAY);
    
    cv::Mat blurMat;
    cv::GaussianBlur(grayMat, blurMat, cv::Size(5,5), 0);
    
    
    
    return MatToUIImage(blurMat);
    
    
}

+ (UIImage *)toCanny:(UIImage *)image {
    
    cv::Mat imageMat;
    
    UIImageToMat(image, imageMat);
    
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, COLOR_BGR2GRAY);
    
    cv::Mat blurMat;
    cv::GaussianBlur(grayMat, blurMat, cv::Size(5,5), 0);
    
    cv::Mat CannyMat;
    cv::Canny(grayMat, CannyMat, 100, 300);
    
    
    return MatToUIImage(CannyMat);
    
    
}

+ (UIImage *)toThreshold:(UIImage *)image {
    
    cv::Mat imageMat;
    
    UIImageToMat(image, imageMat);
    
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, COLOR_BGR2GRAY);
    
    cv::Mat thresholdMat;
    cv::threshold(grayMat, thresholdMat, 127, 255, THRESH_BINARY);
    
    
    return MatToUIImage(thresholdMat);
    
}


@end
