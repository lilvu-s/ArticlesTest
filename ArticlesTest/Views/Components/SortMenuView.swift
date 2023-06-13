//
//  SortMenuView.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 10.06.2023.
//

import SwiftUI

enum SortOption {
    case title
    case publishedAt
    case calendar
}

struct SortMenuView: View {
    @Binding var selectedSortOption: SortOption
    @Binding var searchIsShown: Bool
    @State var presenter: ArticlesPresenter
    
    var body: some View {
        HStack() {
            if selectedSortOption == .calendar {
                if let dateSelection = presenter.dateSelection {
                    DatePickerView(dateSelection: dateSelection)
                }
            }
            
            Menu {
                Button(action: {
                    selectedSortOption = .title
                    searchIsShown = true
                }) {
                    Label("Sort by Title", systemImage: "a.circle")
                }
                
                Button(action: {
                    selectedSortOption = .publishedAt
                    searchIsShown = true
                }) {
                    Label("Sort by Published At", systemImage: "calendar.circle")
                }
                
                Button(action: {
                    selectedSortOption = .calendar
                    searchIsShown = false
                }) {
                    Label("Sort by Period of Time", systemImage: "12.square")
                }
            }
        label: {
            let sortLabel = selectedSortOption == .calendar ? "" : (selectedSortOption == .title ? "Title" : "Date")
            
            Label("\(sortLabel)", systemImage: "arrow.up.arrow.down.circle")
                .padding(.horizontal)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .menuStyle(BorderlessButtonMenuStyle())
        .foregroundColor(.black)
        }
    }
}



