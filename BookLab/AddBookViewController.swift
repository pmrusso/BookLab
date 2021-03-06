//
//  ViewController.swift
//  BookLab
//
//  Created by Pedro Russo on 20/06/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

protocol AddBookViewControllerDelegate {
    func didAddNewBook(json: JSON)
}

class AddBookViewController: UITableViewController {
    
    @IBOutlet var bookTitle: UITextField!
    @IBOutlet var author: UITextField!
    @IBOutlet var readSwitch: UISwitch!

    var delegate: AddBookViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.enabled = validate()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textChanged(sender: AnyObject?){
        navigationItem.rightBarButtonItem?.enabled = validate()
    }
    
    @IBAction func clearForm(){
        self.bookTitle.text = ""
        self.author.text = ""
        self.readSwitch.setOn(false, animated: false)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    private func validate() -> Bool {
        return !bookTitle.text.isEmpty && !author.text.isEmpty
    }
    
    @IBAction func addBook(){
        var json:JSON = [:]
        json["title"].string = bookTitle.text
        json["author"].string = author.text
        json["read"].boolValue = readSwitch.on
        
        
        RestApiManager.sharedInstance.addBook(json, onCompletion: {json, response in
            let respo = response as! NSHTTPURLResponse
            if (respo.statusCode == 201){
                self.delegate?.didAddNewBook(json)
                self.dismissViewControllerAnimated(true, completion: nil)
            }else {
                presentError(NSError(domain: "API Domain", code: respo.statusCode, userInfo: nil))
            }
            
        })
        
            }

}

