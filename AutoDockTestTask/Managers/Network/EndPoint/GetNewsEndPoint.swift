//
//  GetNewsEndPoint.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 19.06.2023.
//

import Foundation

enum GetNewsEndPoint: EndPoint {
    case requestNews(page: Int, pageSize: Int)
    
    var url: String {
        return Config.baseURL
    }
    
    var path: String {
        switch self {
        case .requestNews(let page, let pageSize):
            return "news/\(page)/\(pageSize)"
        }
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
    var method: URLMethods {
        return .get
    }
}
