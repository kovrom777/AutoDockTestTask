//
//  NetworkManager.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 18.06.2023.
//

import Foundation

final class NetworkManager {
    @MainActor
    class func request<T: Decodable>(endPoint: EndPoint) async throws -> T{
        guard let url = URL(string: endPoint.url + endPoint.path) else {
            throw NSError(domain: "Unable to config URL", code: 1)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: "Invalid Response", code: 2)
        }
        guard (200...299).contains(response.statusCode) else {
            throw NSError(domain: "Invalid status code", code: response.statusCode)
        }
      
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}
