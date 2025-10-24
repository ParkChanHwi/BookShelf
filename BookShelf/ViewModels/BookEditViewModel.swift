//
//  BookEditViewModel.swift
//  BookShelf
//
//  Created by mac mini on 10/24/25.
//


import SwiftUI
// 뷰 모델의 속성을 뷰에 바인딩 하기 위해서 뷰 모델에 ObservableObject 프로토콜
class BookEditViewModel: ObservableObject {
  @Published var book: Book
  @Published var isISBNValid: Bool = true
  
  init(book: Book) {
    self.book = book
    
    self.$book
      .map { checkISBN(isbn: $0.isbn) }
      .assign(to: &$isISBNValid)
  }
}
