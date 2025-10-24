//
//  BookEditView.swift
//  BookShelf
//
//  Created by mac mini on 10/23/25.
//
import SwiftUI

struct BookEditView: View {
    @Binding var book : Book
    var body: some View {
        Form {
            TextField("Book title", text: $book.title)
            Image(book.largeCoverImageName)
                .resizable()
                .scaledToFit()
                .shadow(radius: 10)
                .padding()
            TextField("Author", text : $book.author)
            TextField("Pages", value : $book.pages, formatter: NumberFormatter())
            Toggle("Read", isOn: $book.isRead)
        }
        .navigationTitle(book.title)
    }
}

//struct BookEditView_Previews: PreviewProvider {
//  static var previews: some View {
//    BookEditView(book: .constant(book.sampleBooks[0]))
//  }
//}
//
//#Preview {
//    BookEditView(book: ])
//}
