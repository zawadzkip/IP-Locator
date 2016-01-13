//
//  MainScreenViewController.swift
//  IP Locator
//
//  Created by Patrick Zawadzki on 5/13/15.
//  Copyright (c) 2015 PatZawadzki. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

class MainScreenViewController : UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var ipTextBox: UITextField!
    private var request:IPRequest = IPRequest()
    
    override func viewDidLoad() {
        //After all elements are added, have each individual part
        //fade in, change alpha value from 0 to 1.
        checkInternet() // checks the internet connection and automatically shows a message if something is wrong.
        self.ipTextBox.delegate = self
        
    }
    func textFieldShouldReturn(textField : UITextField) -> Bool{
        self.view.endEditing(true)
        return false;
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if checkIPFormat(){
            if(!checkInternet()){
                return false
            }
            return true
        } else{
            
            return false
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? MapViewController{
            destination.setIPObject(request.getResponseInfo())
        }
    }
    @IBAction func checkMyIP(sender: AnyObject) {
        if !activityIndicator.isAnimating(){
            activityIndicator.startAnimating()
            request.sendMyIPInfo(activityIndicator, textBox : ipTextBox)

        }
    }
    
    
    @IBAction func locate(sender: AnyObject) {
        
    }
    
    @IBAction func startedIPEditing(sender: AnyObject) {
        switch(self.segmentControl.selectedSegmentIndex){
        case 0:
            ipTextBox.keyboardType = UIKeyboardType.NumbersAndPunctuation
            break
        case 1:
            ipTextBox.keyboardType = UIKeyboardType.ASCIICapable
            break;
        default:
            ipTextBox.keyboardType = UIKeyboardType.ASCIICapable
            break;
        }
        
    }
    
    /**
     Will need to update this function to better handle the new reachability class. Check podfile for link to repo.
    */
    private func checkInternet() -> Bool{
        if(!IJReachability.isConnectedToNetwork()){
            var alert = UIAlertView(title: "Unable to Connect to Internet", message: "Please check your internet connection and try again", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
            return false
        }else {
            return true
        }
    }
    
    private func checkIPFormat() -> Bool{
        if request.checkIPAddress(ipTextBox.text!){
            return true
        }else{
            var alert = UIAlertView(title: "Improper IP Format", message: "\"" + ipTextBox.text + "\" is not a valid IP Address", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
            return false;
        }
    }
    
}
