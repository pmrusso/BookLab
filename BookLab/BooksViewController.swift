//
//  BooksViewController.swift
//  BookLab
//
//  Created by Pedro Russo on 01/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController, UITableViewDelegate {
    
    
    var items = NSMutableArray()

    override func viewWillAppear(animated: Bool) {
        items.removeAllObjects()
        self.showAllBooks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func showAllBooks(){
        RestApiManager.sharedInstance.getAllBooks { json in
        let books = json["books"]
        for (index:String, book:JSON) in books {
            let item: AnyObject = book.object
            self.items.addObject(item)
            dispatch_async(dispatch_get_main_queue(),{
            tableView?.reloadData()
            })
        }
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }

    
    @IBAction func onSwitch(sender: AnyObject) {
        var package:JSON = JSON(self.items[sender.tag])
        
        let option = sender as! UISwitch
        
        package["read"].boolValue = (option.on)
        
        RestApiManager.sharedInstance.updateBook(package, onCompletion: {json in self.items[sender.tag] = json.object})
        
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCellWithIdentifier("BookCell", forIndexPath: indexPath) as! BookCell

        // Configure the cell...
        
        
        cell.readSwitch.addTarget(self, action: Selector("onSwitch:"), forControlEvents: UIControlEvents.ValueChanged)
        cell.readSwitch.tag = indexPath.row

        
        let book:JSON = JSON(self.items[indexPath.row])
        
        cell.title.text = book["title"].string
        cell.author.text = book["author"].string
        cell.readSwitch.setOn((book["read"].boolValue), animated: false)
        
        return cell
    }
    
    func callDelete(indexPath: NSIndexPath)
    {
        RestApiManager.sharedInstance.deleteBook(JSON(self.items[indexPath.row]), onCompletion: {resp in
            let respo = resp as! NSHTTPURLResponse
            if (respo.statusCode == 204){
                self.viewWillAppear(true)
            }
        })
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        var deleteAlert = UIAlertController(title: "Delete Book", message: "Do you wish to delete this bool?", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: {(action: UIAlertAction!) in self.callDelete(indexPath)}))
        
        deleteAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: {(action: UIAlertAction!) in println("No")}))
        
        presentViewController(deleteAlert, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
