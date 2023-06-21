//
//  FooterLoadingView.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 20.06.2023.
//

import UIKit

class FooterLoadingView: UICollectionReusableView {
    static let cellId = "FooterLoadingView"
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func toggleLoading(isEnabled: Bool) {
        if isEnabled {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
