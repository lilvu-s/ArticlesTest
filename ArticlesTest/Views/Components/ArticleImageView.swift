//
//  ArticleImageView.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 10.06.2023.
//

import SwiftUI

struct ArticleImageView: View {
    let article: ArticleModel
    
    var body: some View {
        if let imageURLString = article.urlToImage, let imageURL = URL(string: imageURLString) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 200)
            }
            .background(Color(.quaternarySystemFill))
        }
    }
}
