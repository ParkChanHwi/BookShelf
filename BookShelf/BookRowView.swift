//
//  BookRowView.swift
//  BookShelf
//
//  Created by mac mini on 10/24/25.
//

import SwiftUI

struct BookRowView: View {
    @Binding var book: Book
    var body: some View {
        NavigationLink(destination: BookDetailsView(book: $book)) {
            HStack(alignment: .top) {
                Image(book.mediumCoverImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 90)
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text("by \(book.author)")
                        .font(.subheadline)
                    Text("\(book.pages) pages")
                        .font(.subheadline)
                }
                Spacer()
                
            }
        }
    }
}

