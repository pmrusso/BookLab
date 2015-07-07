//
//  BookDataSource.swift
//  BookLab
//
//  Created by Pedro Russo on 06/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//


import UIKit

protocol BookDataSourceDelegate {
    func dataSourceCallback(data: BookDataSource, error: NSError?, books: NSMutableArray)
}

class BookDataSource: NSObject, UITableViewDataSource {
    
    var items = NSMutableArray()
    var delegate: BookDataSourceDelegate?
    
    
    subscript(index: Int) -> AnyObject {
        return items[index]
    }
    
    
    func showAllBooks(){
        RestApiManager.sharedInstance.getAllBooks { json in
            let books = json["books"]
            for (index:String, book:JSON) in books {
                let item: AnyObject = book.object
                self.items.addObject(item)
                println("show books")
                dispatch_async(dispatch_get_main_queue(),{
                    delegate?.dataSourceCallback(self, error: nil, books: items)
                })
            }
        }
    }
    
    
    func updateBook(index: Int, option: Bool){
        
        var package:JSON = JSON(self.items[index])
        
        package["read"].boolValue = (option)

        RestApiManager.sharedInstance.updateBook(package, onCompletion: {json in ()})
    }
    
    
    func callDelete(indexPath: NSIndexPath)
    {
        RestApiManager.sharedInstance.deleteBook(JSON(self.items[indexPath.row]), onCompletion: {resp in
            let respo = resp as! NSHTTPURLResponse
            if (respo.statusCode == 204){
                //self.viewWillAppear(true)
            }
        })
    }
    
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        var deleteAlert = UIAlertController(title: "Delete Book", message: "Do you wish to delete this bool?", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: {(action: UIAlertAction!) in self.callDelete(indexPath)}))
        
        deleteAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: {(action: UIAlertAction!) in println("No")}))
        
        //presentViewController(deleteAlert, animated: true, completion: nil)
    }

    
    
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath) as! BookCell
            
            // Configure the cell...
            
            println("config cell")
            
            /*cell.readSwitch.addTarget(self, action: Selector("onSwitch:"), forControlEvents: UIControlEvents.ValueChanged)*/
            cell.readSwitch.tag = indexPath.row
            
            
            let book:JSON = JSON(self.items[indexPath.row])
            
            cell.title.text = book["title"].string
            cell.author.text = book["author"].string
            cell.readSwitch.setOn((book["read"].boolValue), animated: false)
            
            return cell
   
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count;
    }
}
