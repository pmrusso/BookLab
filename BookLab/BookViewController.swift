//
//  BookViewController.swift
//  BookLab
//
//  Created by Pedro Russo on 22/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var readSwitch: UISwitch!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var dataView: UIView!
    
    var bookuri: String!
    
    override func viewWillAppear(animated: Bool) {
        fetchBook()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchBook(){
        RestApiManager.sharedInstance.getBook(bookuri, onCompletion: {book in
            self.configureViewForBookViewModel(BookViewModel(book: book))
            })
    }
    
    @IBAction func switchChanged(sender: AnyObject?) {
        let readSwitch = sender as! UISwitch
        
        self.view.userInteractionEnabled = false
        RestApiManager.sharedInstance.updateBook(self.bookuri!, read: readSwitch.on, onCompletion: {json in ()})
    }
    
    private func setupBookView(book: Book){
        titleLabel.text = book.title
        authorLabel.text = book.author
        readSwitch.setOn(book.read, animated: false)
    }
    
    private func configureViewForBookViewModel(viewModel: BookViewModel) {
        self.titleLabel.text = viewModel.title
        self.authorLabel.text = viewModel.author
        self.readSwitch.on = viewModel.read
    }
 

}
