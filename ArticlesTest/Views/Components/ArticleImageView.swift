//
//  ArticleImageView.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 10.06.2023.
//

import SwiftUI

struct ArticleImageView: View {
    @State private var image: UIImage?
    let article: ArticleModel
    let imageURL: URL?
    
    var body: some View {
        if let imageURLString = article.urlToImage, let imageURL = URL(string: imageURLString) {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } placeholder: {
                ProgressView()
            }
        }
    }
}
