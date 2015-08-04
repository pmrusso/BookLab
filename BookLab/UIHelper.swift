//
//  UIHelper.swift
//  BookLab
//
//  Created by Pedro Russo on 04/08/15.
//  Copyright (c) 2015 Pedro Russo. All rights reserved.
//

import UIKit

func presentError(error: NSError?) {
    let alertView = UIAlertView(title: "Error", message: error?.description, delegate: nil, cancelButtonTitle: "Ok")
    alertView.show()
}