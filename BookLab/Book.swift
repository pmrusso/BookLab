//
//  Book.swift
//  BookLab
//
//  Created by Pedro Russo on 01/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class Book: NSObject {
    
    var uri: String
    var title: String
    var author: String
    var read: Bool
    
    init(uri: String, title: String, author: String, read: Bool) {
        self.uri = uri
        self.title = title
        self.author = author
        self.read = read
        super.init()
    }
   
}
