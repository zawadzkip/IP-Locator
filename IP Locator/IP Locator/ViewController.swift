//
//  ViewController.swift
//  IP Locator
//
//  Created by Patrick Zawadzki on 5/11/15.
//  Copyright (c) 2015 PatZawadzki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let IP = IPRequest()
        IP.sendMyIPInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

