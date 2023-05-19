//
//  ImageCaputrePresenter.swift
//  carNumber
//
//  Created by 박경춘 on 2023/05/19.
//

import Foundation
import UIKit

protocol ImageCaputreProtocol: AnyObject {
    
    func viewInit()
    func didImageCaptureButton()
    func didImageLoadButton()
    func didImageSaveButton()
    
    
}

final class ImageCaputrePresenter: NSObject {
    
    private weak var viewController: ImageCaputreProtocol?
    
    init(viewController: ImageCaputreProtocol?) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.viewInit()
    }
    
    func didImageCaptureButton() {
        
        
        
    }
    
    func didImageLoadButton() {
        
        
        
    }
    
    func didImageSaveButton(image: UIImage) {
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
        
        
    }
}
