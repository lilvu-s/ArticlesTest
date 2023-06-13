//
//  Extensions.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 11.06.2023.
//

import SwiftUI

extension Text {
    func highlightedText(_ text: String, searched: String) -> Text {
        guard !text.isEmpty && !searched.isEmpty else { return Text(text) }
        
        let words = text.components(separatedBy: .whitespacesAndNewlines)
        
        let highlightedWords = words.map { word -> Text in
            if word.localizedCaseInsensitiveContains(searched) {
                return Text(word).bold().foregroundColor(.yellow)
            } else {
                return Text(word)
            }
        }
        
        return highlightedWords.reduce(into: Text("")) { result, word in
            result = result + Text(" ") + word
        }
    }
}

extension View {
    func formatDateToString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd.MM.yy"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return "Invalid date"
        }
    }
}

extension ArticlesPresenter {
    func formatStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let formattedDate = dateFormatter.date(from: dateString) else { return Date() }
        return formattedDate
    }
}

