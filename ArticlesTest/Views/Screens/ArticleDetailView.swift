//
//  ContentView.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 08.06.2023.
//

import SwiftUI

struct ArticleDetailView: View {
    @State private var searchText = ""
    @State private var searchIsShown: Bool = false
    let article: ArticleModel
    
    var body: some View {
        if searchIsShown {
            HStack(spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 15)
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
                    .textFieldStyle(.plain)
            }
            .padding(.top, 10)
        }
        
        ScrollView {
            LazyVStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text(article.source.name)
                        .bold()
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ArticleImageView(article: article)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                
                if let articleDescription = article.description {
                    ForEach(articleDescription.split(separator: "\n").filter { paragraph in
                        searchText.isEmpty || paragraph.localizedCaseInsensitiveContains(searchText)
                    }, id: \.self) { paragraph in
                        
                        Text(verbatim: "").highlightedText(String(paragraph), searched: searchText)
                            .padding(.leading, 10)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                HStack {
                    if let dateString = article.publishedAt {
                        let formattedDate = formatDateToString(dateString)
                        
                        Text(article.author ?? "Anonymous")
                            .italic()
                        Spacer()
                        Text(formattedDate)
                    }
                }
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        searchIsShown.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .foregroundColor(.black)
        }
    }
}
