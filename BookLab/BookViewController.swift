//
//  BookViewController.swift
//  BookLab
//
//  Created by Pedro Russo on 03/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import Foundation
import UIKit

class BookViewController: UIViewController {
    var bookuri: String = ""
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!){
        case "showBook":
                let dest = segue.destinationViewController as! BookTableViewController
                dest.bookuri = bookuri
                break
        default:
            break
            }
        }

}