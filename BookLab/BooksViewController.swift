//
//  BooksViewController.swift
//  BookLab
//
//  Created by Pedro Russo on 01/07/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController, BookDataSourceDelegate {
    
    
    @IBOutlet weak var dataSource : BookDataSource!
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
        dataSource.showAllBooks()
       
    }
    
    
    
    func dataSourceCallback(data: BookDataSource, error: NSError?, books: NSMutableArray) {
        println("callback")
        tableView.reloadData()
        println("callbackend")
    }


    
    
    @IBAction func onSwitch(sender: AnyObject) {
        
        let option = sender as! UISwitch
        println(sender.tag)
        dataSource.updateBook(sender.tag, option: option.on)
        
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
