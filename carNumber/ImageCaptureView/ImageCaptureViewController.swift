//
//  ImageCaptureViewController.swift
//  carNumber
//
//  Created by 박경춘 on 2023/05/19.
//

import Foundation
import UIKit
import SnapKit

class ImageCaptureViewController: UIViewController {
    
    private lazy var presenter = ImageCaputrePresenter(viewController: self)
    
    private lazy var imagePickerController = UIImagePickerController()
    
    private lazy var textCog = TextRecog()
    
    private lazy var ImageView: UIImageView = {
        
        let ImageView = UIImageView()
        ImageView.backgroundColor = .gray
        
        return ImageView
        
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "차량 번호 : "
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var carNumberLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    
    
    
    private lazy var CaptureImageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .blue
        button.setTitle("카메라 촬영", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        button.addTarget(self, action: #selector(didImageCaptureButton), for: .touchUpInside)
                
        return button
    }()
    
    private lazy var LoadImageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .blue
        button.setTitle("이미지 불러오기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        button.addTarget(self, action: #selector(didImageLoadButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var SaveImageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .blue
        button.setTitle("결과 이미지 저장", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20.0, weight: .bold)
        button.addTarget(self, action: #selector(didImageSaveButton), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
        
        presenter.viewDidLoad()
        
        
    }
    
    
    
}



extension ImageCaptureViewController: ImageCaputreProtocol {
    
    func viewInit() {
        
        navigationItem.title = "번호판 캡처 및 인식"
        
        let labelStackView = UIStackView(arrangedSubviews: [titleLabel, carNumberLabel])
        labelStackView.axis = .horizontal
        labelStackView.distribution = .fillEqually
        labelStackView.spacing = 8.0
        
        
        let buttonStackView = UIStackView(arrangedSubviews: [CaptureImageButton, LoadImageButton, SaveImageButton])
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 8.0
        
        [ImageView, labelStackView, buttonStackView].forEach {
            self.view.addSubview($0)
        }
        
        ImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(ImageView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(16.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        
    }
    
    @objc func didImageCaptureButton() {
        
        imagePickerController.sourceType = .camera
        imagePickerController.cameraFlashMode = .auto
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true)
    }
    
    @objc func didImageLoadButton() {
        
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
        
    }
    
    @objc func didImageSaveButton() {
        
        guard let image = ImageView.image ?? nil else {
            return
        }
        
        presenter.didImageSaveButton(image: image)
        
        showToast(view: self.view, message: "이미지 저장이 완료되었습니다.")
        
    }
    
}

extension ImageCaptureViewController: UINavigationControllerDelegate {
    
    
    
}


extension ImageCaptureViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.imagePickerController.dismiss(animated: true)
        
        guard let PickImage = info[.originalImage] as? UIImage else {
            fatalError("이미지 로드 실패")
        }
        
        textCog.UIimageRecog(image: PickImage)
        
        carNumberLabel.text = textCog.getRecogText()
        
        
        ImageView.image = PickImage
        
    }
    
    
    
    
    
}
