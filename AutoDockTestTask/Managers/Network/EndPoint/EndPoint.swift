//
//  EndPoint.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 19.06.2023.
//

import Foundation

public protocol EndPoint {
    var url: String { get }
    var path: String { get }
    var method: URLMethods { get }
    var parameters: [URLQueryItem]? { get }
    
}

public enum URLMethods: String {
    case get = "GET"
}
