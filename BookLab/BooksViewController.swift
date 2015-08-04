//
//  BooksViewController.swift
//  BookLab
//
//  Created by Pedro Russo on 01/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController, BookDataSourceDelegate, AddBookViewControllerDelegate {
    
    
    @IBOutlet weak var dataSource : BookDataSource!
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        dataSource.showAllBooks()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()        
    }
    
    
    
    func dataSourceCallback(data: BookDataSource, error: NSError?, books: [Book]) {
        if (error != nil){
          presentError(error)
        }
        else {
           tableView.reloadData()
        }
    }

    func didAddNewBook(json: JSON) {
        dataSource.reset()
        dataSource.addBook(json)
        tableView.reloadData()
    }
    
        // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!){
            case "showSingleBook":
                if let indexPath = self.tableView.indexPathForSelectedRow() {
                    let book = dataSource[indexPath.row]
                    let dest = segue.destinationViewController as! BookViewController
                    dest.bookuri = book.uri
                }
                    //(segue.destinationViewController as! BookViewController).bookuri = book.uri}
                break
            case "AddBook":
                let navigationController = segue.destinationViewController as! UINavigationController
                (navigationController.topViewController as! AddBookViewController).delegate = self
                break
            default:
                break
        }
    }

    

}
