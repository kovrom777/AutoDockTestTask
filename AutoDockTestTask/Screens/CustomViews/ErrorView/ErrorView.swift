//
//  ErrorView.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 19.06.2023.
//

import UIKit

class ErrorView: UIView {
    
    let separatorView = UIView()
    let containerView = UIView()
    let warningImage = UIImageView()
    let errorText = UILabel()

    init(error: String) {
        super.init(frame: .zero)
        
        backgroundColor = . black.withAlphaComponent(0.8)
        
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        separatorView.backgroundColor = .lightGray
        separatorView.layer.cornerRadius = 2
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorView)
        
        warningImage.image = UIImage(named: "error")
        warningImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(warningImage)
        
        errorText.text = error
        errorText.textColor = .black
        errorText.font = .systemFont(ofSize: 16, weight: .heavy)
        errorText.numberOfLines = 0
        errorText.lineBreakMode = .byWordWrapping
        errorText.translatesAutoresizingMaskIntoConstraints = false
        errorText.textAlignment = .center
        containerView.addSubview(errorText)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: centerYAnchor, constant: 100).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        warningImage.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 12).isActive = true
        warningImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        warningImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        warningImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        errorText.topAnchor.constraint(equalTo: warningImage.bottomAnchor, constant: 12).isActive = true
        errorText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        errorText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
    }
}
