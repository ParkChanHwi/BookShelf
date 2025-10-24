//
//  BookDetailsView.swift
//  BookShelf
//
//  Created by mac mini on 10/23/25.
//

import SwiftUI

struct BookDetailsView: View {
    @Binding var book : Book
    @State var showEditBookView = false
    var body: some View {
        Form {
            Text(book.title)
                .font(.headline).foregroundColor(.red)
            Image(book.largeCoverImageName)
            Label(book.author, systemImage: "person.crop.rectangle")
            Label("\(book.pages) pages", systemImage: "book")
            Toggle("Read", isOn: .constant(book.isRead))
            Button(action: { showEditBookView.toggle()  }) {
                Label("Edit", systemImage: "pencil")
            }
        }
        .sheet(isPresented: $showEditBookView) {
            BookEditView(book : $book)
        }
        .navigationTitle(book.title)
    }
}

