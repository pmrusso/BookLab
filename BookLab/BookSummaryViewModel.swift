//
//  BookSummaryViewModel.swift
//  BookLab
//
//  Created by Pedro Russo on 24/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation

class BookSummaryViewModel {
    let uri : String
    let title : String
    
    convenience init(book: Book) {
        self.init(uri: book.uri, title: book.title)
    }
    
    init(uri: String?, title: String) {
        self.uri = uri!
        self.title = title
    }
}