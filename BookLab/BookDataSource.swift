//
//  BookDataSource.swift
//  BookLab
//
//  Created by Pedro Russo on 06/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//


import UIKit

protocol BookDataSourceDelegate {
    func dataSourceCallback(data: BookDataSource, error: NSError?, books: [Book])
}

class BookDataSource: NSObject, UITableViewDataSource {
    
    var items = [Book]()
    var delegate: BookDataSourceDelegate?
    
    
    subscript(index: Int) -> Book {
        return items[index]
    }
    
    func reset() {
        items = [Book]()
    }
    
    func showAllBooks(){
        RestApiManager.sharedInstance.getAllBooks { books in
                self.items = books
                self.delegate?.dataSourceCallback(self, error: nil, books: self.items)
               
        }
    }
    
    private func callDelete(book: Book)
    {
        
        RestApiManager.sharedInstance.deleteBook(book.uri, onCompletion: {resp in
            let respo = resp as! NSHTTPURLResponse
            if (respo.statusCode == 204){
                //self.viewWillAppear(true)
            }
        })
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let book = self[indexPath.row]
            items.removeAtIndex(indexPath.row)
            self.callDelete(book)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    

    private func configBookCell(cell: BookCell, indexPath: NSIndexPath){
        let bookViewModel = BookSummaryViewModel(book: items[indexPath.row])
        cell.setupWithViewModel(bookViewModel)
    }
    
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath) as! BookCell
            self.configBookCell(cell, indexPath: indexPath)
            return cell
   
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {       
        return self.items.count;
    }
}
