//
//  ArticlesView.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 08.06.2023.
//

import SwiftUI

struct ArticlesScrollView: View {
    @StateObject var presenter: ArticlesPresenter
    @State private var selectedDate = Date()
    @State private var selectedSortOption: SortOption = .title
    @State private var searchIsShown: Bool = true
    @Environment(\.openURL) var openURL
    
    private var sortedArticles: [ArticleModel] {
        return presenter.sortedArticles
    }
    
    init() {
        let articleService = ArticlesService()
        _presenter = StateObject(wrappedValue: ArticlesPresenter(articleService: articleService))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if presenter.articles.isEmpty {
                    VStack(alignment: .center) {
                        ProgressView()
                            .padding(.bottom, 5)
                        Text("Loading articles...")
                    }
                } else {
                    VStack {
                        HStack {
                            if searchIsShown {
                                HStack(spacing: 5) {
                                    Image(systemName: "magnifyingglass")
                                        .padding(.leading, 15)
                                        .foregroundColor(.gray)
                                    TextField("Search", text: $presenter.searchText)
                                        .textFieldStyle(.plain)
                                        .accessibility(identifier: "SearchField")
                                }
                            }
                            SortMenuView(selectedSortOption: $presenter.selectedSortOption, searchIsShown: $searchIsShown, presenter: presenter)
                        }
                        .padding(.bottom, 5)
                    }
                    
                    GeometryReader { geometry in
                        ScrollView {
                            LazyVStack {
                                if sortedArticles.isEmpty {
                                    VStack(alignment: .center) {
                                        Text("Articles not found")
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: geometry.size.height)
                                    .foregroundColor(.gray)
                                } else {
                                    ForEach(sortedArticles.indices, id: \.self) { index in
                                        let article = sortedArticles[index]
                                        
                                        ArticleCellView(article: article)
                                            .contextMenu(ContextMenu() {
                                                Button("URL 🔎") {
                                                    guard let url = URL(string: article.url) else { return }
                                                    openURL(url)
                                                }
                                            })
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Articles")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                Task {
                    await presenter.fetchArticles()
                }
            }
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesScrollView()
    }
}
