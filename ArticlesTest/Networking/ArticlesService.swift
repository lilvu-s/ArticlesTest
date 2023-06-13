//
//  NetworkingService.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 08.06.2023.
//

import SwiftUI

protocol ArticlesServiceProtocol {
    func fetchArticles() async throws -> ArticlesListModel
}

struct APIError: Error {
    let message: String
}

final class ArticlesService: ArticlesServiceProtocol {
    var urlString: String
    var pageSize = 30
    
    init() {
        self.urlString = "https://newsapi.org/v2/everything?q=ukraine&pageSize=\(pageSize)&apiKey=c09f8c39de7949da81d8604ff46ffcc8"
    }
    
    func fetchArticles() async throws -> ArticlesListModel {
        guard let url = URL(string: urlString) else {
            throw APIError(message: "Invalid URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError(message: "Invalid response")
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(ArticlesListModel.self, from: data)
    }
}

