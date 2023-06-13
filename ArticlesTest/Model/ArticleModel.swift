//
//  Article.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 08.06.2023.
//

import Foundation

struct ArticleModel: Codable, Identifiable {
    let id: UUID?
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    let source: Source
}

struct Source: Codable {
    let id: String?
    let name: String
}
