//
//  BookViewModel.swift
//  BookLab
//
//  Created by Pedro Russo on 24/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation

class BookViewModel {
    let uri : String
    let title : String
    let author : String
    let read : Bool
    
    init(uri: String?, title: String, author: String, read: Bool) {
        self.uri = uri!
        self.title = title
        self.author = "by " + author
        self.read = read
    }
    
    convenience init(book: Book) {
        self.init(uri: book.uri, title: book.title, author: book.author, read: book.read)
    }
}