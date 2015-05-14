//
//  ViewController.swift
//  IP Locator
//
//  Created by Patrick Zawadzki on 5/11/15.
//  Copyright (c) 2015 PatZawadzki. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class LoadingViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.userInteractionEnabled = false
        self.load()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func load(){
        imageView.animationImages = [UIImage]()
        imageView.animationRepeatCount = 1
        for var index = 1; index < 36; index += 1{
            var frameName = String(format: "%d", index)
            imageView.animationImages?.append(UIImage(named: frameName)!)
        }
        imageView.animationDuration = 1
        imageView.startAnimating()
        var triggerTime = (Int64(NSEC_PER_SEC) * 1)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.performSegueWithIdentifier("finishedAnimatingSegue", sender: self)
        })
        
    }


}

