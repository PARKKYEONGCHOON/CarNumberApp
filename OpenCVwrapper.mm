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

+ (UIImage *)classifyImage:(UIImage *) image {
    cv::Mat colorMat;
    UIImageToMat(image, colorMat);
    
    cv::Mat grayMat;
    cv::cvtColor(colorMat, grayMat, COLOR_BGR2GRAY);
    
    cv::CascadeClassifier classifier;
    const NSString* cascadePath = [[NSBundle mainBundle]
                                   pathForResource:@"haarcascade_frontalface_default" ofType:@"xml"];
    
    classifier.load([cascadePath UTF8String]);
    
    std::vector<cv::Rect> detections;
    
    const double scalingFactor = 1.1;
    const int minNeighbors = 2;
    const int flags = 0;
    const cv::Size minimumSize(300, 300);
    
    classifier.detectMultiScale(grayMat, detections, scalingFactor, minNeighbors,flags,minimumSize);
    
    if(detections.size() <= 0){
        return nil;
    }
    
    for (auto &face : detections) {
        const cv::Point tl(face.x, face.y);
        const cv::Point br = tl + cv::Point(face.width, face.height);
        const cv::Scalar magenta = cv::Scalar(255, 0, 255);
        
        cv::rectangle(colorMat, tl, br, magenta, 4, 8, 0);
        
        
    }
    
    return MatToUIImage(colorMat);
    
}

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

+ (UIImage *)drawLine:(UIImage *)image:(int)x1:(int)y1:(int)x2:(int)y2:(int)r:(int)g:(int)b:(int)thick {
    
    cv::Mat imageMat;
    
    UIImageToMat(image, imageMat);
    
    cv::Mat lineimageMat;
    
    cv::line(imageMat, cv::Point(x1,y1), cv::Point(x2,y2), cv::Scalar(r,g,b), thick, 8, 0);
    
    
    return MatToUIImage(imageMat);
    
}



@end
