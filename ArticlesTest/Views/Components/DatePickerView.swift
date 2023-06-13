//
//  DatePickerView.swift
//  ArticlesTest
//
//  Created by Ангеліна Семенченко on 11.06.2023.
//

import SwiftUI

final class DateSelection {
    var updateArticles: (() -> Void)?
    
    init(updateArticles: (() -> Void)? = nil) {
        self.updateArticles = updateArticles ?? {}
    }
    
    @Published var startDate: Date = Date() {
        didSet {
            DispatchQueue.main.async {
                self.updateArticles?()
            }
        }
    }
    
    @Published var endDate: Date = Date() {
        didSet {
            DispatchQueue.main.async {
                self.updateArticles?()
            }
        }
    }
}

struct DatePickerView: View {
    @State var dateSelection: DateSelection
    
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .leading) {
                DatePicker("", selection: $dateSelection.startDate, in: ...Date(), displayedComponents: [.date])
                    .onChange(of: dateSelection.startDate, perform: { value in
                        dateSelection.updateArticles?()
                    })
            }
            .padding(.leading, 15)
            
            VStack(alignment: .leading) {
                DatePicker("", selection: $dateSelection.endDate, in: ...Date(), displayedComponents: [.date])
                    .onChange(of: dateSelection.endDate, perform: { value in
                        dateSelection.updateArticles?()
                    })
            }
        }
        .labelsHidden()
        .background(.white)
        
        Spacer()
    }
}


