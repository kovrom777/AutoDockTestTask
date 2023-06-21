//
//  UIImageView+Extension.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 20.06.2023.
//

import UIKit


extension UIImageView {
    func loadImage(from url: String, placeholder: String? = "noImage") async throws {
        if let placeholder = placeholder {
            image = UIImage(named: placeholder)
        }
        
        if let cachedImage = CacheManager.shared.image(for: url){
            image = cachedImage
            return
        }
        
        guard let _url = URL(string: url) else {return}
        let (data, _) = try await URLSession.shared.data(from: _url)
        if let image = UIImage(data: data) {
            CacheManager.shared.setObject(image, for: url)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
