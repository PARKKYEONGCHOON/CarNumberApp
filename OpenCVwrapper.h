//
//  OpenCVwrapper.h
//  carNumber
//
//  Created by 박경춘 on 2023/05/19.
//

#import <Foundation/Foundation.h>
#import "OpenCVwrapper.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVwrapper : NSObject

+ (UIImage *)toGray:(UIImage *)image;
+ (UIImage *)toGaussianBlur:(UIImage *)image;
+ (UIImage *)toCanny:(UIImage *)image;
+ (UIImage *)toThreshold:(UIImage *)image;
+ (UIImage *)classifyImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
