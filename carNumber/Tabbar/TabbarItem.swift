//
//  TabBarItem.swift
//  Twitter
//
//  Created by 박경춘 on 2023/04/02.
//

import UIKit

enum TabBarItem: CaseIterable {
    
    case ImageCapture
    case RecordImage
    
    
    var title : String {
        switch self {
        case .ImageCapture:
            return "번호판 캡처 및 인식"
        
        case .RecordImage:
            return "번호판 기록"
            
        
        }
        
    }
    
    var icon: (default: UIImage?, selected: UIImage?) {
        
        switch self {
        case .ImageCapture:
            return (UIImage(systemName: "camera"), UIImage(systemName: "camera.fill"))
        case .RecordImage:
            return (UIImage(systemName: "videoprojector"), UIImage(systemName: "videoprojector.fill"))
        
        }
        
    }
    
    var viewController: UIViewController {
        switch self {
        case .ImageCapture:
            return UINavigationController(rootViewController: ImageCaptureViewController())
        case .RecordImage:
            return UINavigationController(rootViewController: UIViewController())
        
        }
    }
    
}
