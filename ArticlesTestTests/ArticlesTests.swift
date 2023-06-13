//
//  ArticlesTests.swift
//  ArticlesTests
//
//  Created by Ангеліна Семенченко on 08.06.2023.
//

import XCTest
@testable import ArticlesTest

final class ArticlesServiceTests: XCTestCase {
    var service: ArticlesServiceProtocol?
    
    func testFetchArticles() async throws {
        let service: ArticlesServiceProtocol = ArticlesService()
        
        do {
            let articlesList = try await service.fetchArticles()
            XCTAssertFalse(articlesList.articles.isEmpty, "Articles list shouldn't be empty")
            
        } catch {
            XCTFail("Error occured while fetching articles \(error)")
        }
    }
    
    func testFetchArticlesWithInvalidResponse() async throws {
        let service = ArticlesService()
        service.urlString = "https://example.com/invalid"
        
        do {
            _ = try await service.fetchArticles()
            
            XCTFail("The fetchArticles method should throw an error for an invalid response")
        } catch let error as APIError {
            XCTAssertEqual(error.message, "Invalid response", "App should throw an APIError with the invalid response message")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    func testFetchArticlesCount() async throws {
        let service = ArticlesService()
        let articlesList = try await service.fetchArticles()
        let pageSize = service.pageSize
        
        XCTAssertEqual(articlesList.articles.count, pageSize, "Number of articles should match pageSize")
    }
}
