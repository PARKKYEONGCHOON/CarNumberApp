//
//  TextRecog.swift
//  carNumber
//
//  Created by 박경춘 on 2023/05/20.
//

import Foundation
import MLKitTextRecognitionKorean
import UIKit
import AVFoundation
import MLKitVision

class TextRecog {
    
    var koreanOptions = KoreanTextRecognizerOptions()
    lazy var koreanTextRecognizer = TextRecognizer.textRecognizer(options: koreanOptions)
    var recogtext = ""
    
    
    
    func UIimageRecog(image: UIImage) -> String{
        
        
        
        let image = VisionImage(image: image)
        image.orientation = self.imageOrientation(deviceOrientation: UIDevice.current.orientation, cameraPosition: .back)
        
        
        koreanTextRecognizer.process(image) { features, error in
            self.koreanTextRecognizer.process(image) { result, error in
                guard error == nil, let result = result else {
                    // Error handling
                    print("TextRecognizer Fail")
                    return
                }
                let resultText = result.text
                print("resultText: \(resultText)")
                
                
              
              
               for block in result.blocks {
                   self.recogtext += block.text
               }
                
                print("self.recogtext: \(self.recogtext)")
            }
        }
        

        return self.recogtext
        
        
    }
    
    func getRecogText() -> String {
        
        if self.recogtext != "" {
            return self.recogtext
        }
        else {
            return "인식 불가"
        }
        
        
    }
    ;
    
    
    func imageOrientation(
      deviceOrientation: UIDeviceOrientation,
      cameraPosition: AVCaptureDevice.Position
    ) -> UIImage.Orientation {
      switch deviceOrientation {
          case .portrait:
            return cameraPosition == .front ? .leftMirrored : .right
          case .landscapeLeft:
            return cameraPosition == .front ? .downMirrored : .up
          case .portraitUpsideDown:
            return cameraPosition == .front ? .rightMirrored : .left
          case .landscapeRight:
            return cameraPosition == .front ? .upMirrored : .down
          case .faceDown, .faceUp, .unknown:
            return .up
      }
    }
    
}
