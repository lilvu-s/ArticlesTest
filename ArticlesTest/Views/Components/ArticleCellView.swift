//
//  ArticleRow.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 10.06.2023.
//

import SwiftUI

struct ArticleCellView: View {
    let article: ArticleModel
    @State private var image: UIImage?
    
    var body: some View {
        NavigationLink(destination: ArticleDetailView(article: article)) {
            VStack(alignment: .leading) {
                ArticleImageView(article: article)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .padding(.top, 15)
                    .padding(.horizontal, 15)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.headline)
                        .lineLimit(2)
                        .foregroundColor(.black)
                    
                    HStack {
                        if let dateString = article.publishedAt {
                            let formattedDate = formatDateToString(dateString)
                            
                            Text(article.author ?? "Anonymous")
                                .font(.caption)
                            Spacer()
                            Text(formattedDate)
                                .font(.caption)
                        }
                    }
                    .foregroundColor(.primary)
                    
                    Text(article.description ?? "No text found.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                }
                .multilineTextAlignment(.leading)
                .padding(15)
                Divider()
            }
        }
    }
}
