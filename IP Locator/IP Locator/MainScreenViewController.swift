//
//  MainScreenViewController.swift
//  IP Locator
//
//  Created by Patrick Zawadzki on 5/13/15.
//  Copyright (c) 2015 PatZawadzki. All rights reserved.
//

import Foundation
import UIKit
import IJReachability

class MainScreenViewController : UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var ipTextBox: UITextField!
    private var request:IPRequest = IPRequest()
    override func viewDidLoad() {
        //After all elements are added, have each individual part
        //fade in, change alpha value from 0 to 1.
        if(!IJReachability.isConnectedToNetwork()){
            var alert = UIAlertView(title: "No Internet Connection", message: "Please connect to the internet in order to use this application.", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
        self.ipTextBox.delegate = self
        
    }
    func textFieldShouldReturn(textField : UITextField) -> Bool{
        self.view.endEditing(true)
        return false;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? MapViewController{
            destination.setIPObject(request.getResponseInfo())
        }
    }
    @IBAction func checkMyIP(sender: AnyObject) {
            if(!IJReachability.isConnectedToNetwork()){
                var alert = UIAlertView(title: "Unable to Connect to Internet", message: "Please check your internet connection and try again", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            }else{
                request.sendMyIPInfo()
        }
    }
    @IBAction func finishedIPEditing(sender: AnyObject) {
        if request.checkIPAddress(ipTextBox.text!){
            if(!IJReachability.isConnectedToNetwork()){
                var alert = UIAlertView(title: "Unable to Connect to Internet", message: "Please check your internet connection and try again", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            }else{
                request.sendOtherIPInfo(ipTextBox.text!)
            }
            
        }else{
            var alert = UIAlertView(title: "Improper IP Format", message: "\"" + ipTextBox.text + "\" is not a valid IP Address", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
        
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
    
}
