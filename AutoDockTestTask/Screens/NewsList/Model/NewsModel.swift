//
//  NewsModel.swift
//  AutoDockTestTask
//
//  Created by Роман Ковайкин on 19.06.2023.
//

import Foundation

struct News: Codable {
    var news: [SingleNews]
    let totalCount: Int
    
    enum CodingKeys: CodingKey {
        case news, totalCount
    }
}

struct SingleNews: Codable, Hashable {
    let id: Int
    let title: String
    let description: String
    let publishedDate: String
    let url: String
    let fullUrl: String
    let titleImageUrl: String?
    let categoryType: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, publishedDate, url, fullUrl, titleImageUrl, categoryType
    }
}
