//
//  ArticlesPresenter.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 08.06.2023.
//

import SwiftUI

final class ArticlesPresenter: ObservableObject {
    private let articleService: ArticlesServiceProtocol
    @Published var articles = [ArticleModel]()
    @Published var sortedArticles: [ArticleModel] = []
    @Published var dateSelection: DateSelection?
    
    @Published var searchText: String = "" {
        didSet {
            Task {
                await sortArticles()
            }
        }
    }
    
    @Published var selectedSortOption: SortOption = .title {
        didSet {
            Task {
                await sortArticles()
            }
        }
    }
    
    var filteredArticles: [ArticleModel] {
        if searchText.isEmpty {
            return articles
        } else {
            return articles.filter { article in
                article.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init(articleService: ArticlesServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() async {
        do {
            let articleList = try await articleService.fetchArticles()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.articles = articleList.articles
                Task {
                    await self.sortArticles()
                }
            }
        } catch {
            print("Error fetching articles: \(error)")
        }
    }
    
    func updateSortedArticles() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.dateSelection == nil {
                self.dateSelection = DateSelection(updateArticles: { [weak self] in self?.updateSortedArticles() })
            }
            
            guard let startDate = self.dateSelection?.startDate, let endDate = self.dateSelection?.endDate else {
                self.sortedArticles = self.filteredArticles
                return
            }
            
            guard startDate <= endDate else {
                print("Error: startDate cannot be later than endDate")
                self.sortedArticles.removeAll()
                return
            }
            
            self.sortedArticles = self.filteredArticles.filter { article in
                guard let articleDate = self.formatStringToDate(article.publishedAt ?? "Unwrapping error") else { return false }
                return (startDate...endDate).contains(articleDate)
            }
        }
    }
    
    func sortArticles() async {
        switch selectedSortOption {
        case .title:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.sortedArticles = self.filteredArticles.sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }
            }
        case .publishedAt:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.sortedArticles = self.filteredArticles.sorted { $1.publishedAt ?? "Unwrapping error" < $0.publishedAt ?? "Unwrapping error" }
            }
        case .calendar:
            updateSortedArticles()
        }
    }
}
