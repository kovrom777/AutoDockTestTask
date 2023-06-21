//
//  CacheManager.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 20.06.2023.
//

import UIKit

final class CacheManager {
    static let shared = CacheManager()
    private init() {}
    
    private var cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.totalCostLimit = 10 * 1024 * 1024 // == 10Mb
        return cache
    }()
    
    func image(for url: String) -> UIImage? {
        guard let url = URL(string: url) else {return nil}
        return cache.object(forKey: url as NSURL)
    }
    
    func setObject(_ image: UIImage, for url: String) {
        guard let url = URL(string: url) else {return}
        cache.setObject(image, forKey: url as NSURL)
    }
}
