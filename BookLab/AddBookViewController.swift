//
//  ViewController.swift
//  BookLab
//
//  Created by Pedro Russo on 20/06/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    @IBOutlet var bookTitle: UITextField!
    @IBOutlet var author: UITextField!
    @IBOutlet var readSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearForm(){
        self.bookTitle.text = ""
        self.author.text = ""
        self.readSwitch.setOn(false, animated: false)
        
    }
    
    @IBAction func addBook(){
        var json:JSON = [:]
        json["title"].string = bookTitle.text
        json["author"].string = author.text
        json["read"].boolValue = readSwitch.on
        
       
        
        RestApiManager.sharedInstance.addBook(json, onCompletion: {json, response in
            let respo = response as! NSHTTPURLResponse
            
            if (respo.statusCode == 201){
                //is to clear form but cannot seem to do it because of thread stuff
            }
            
        })
        
            }

}

