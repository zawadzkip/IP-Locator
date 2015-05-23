//
//  IPRequest.swift
//  IP Locator
//
//  Created by Patrick Zawadzki on 5/11/15.
//  Copyright (c) 2015 PatZawadzki. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class IPRequest : NSObject{
    private let baseURL = "http://ipinfo.io/"
    private let getGeo = "geo"
    private var responseInfo:IPObject = IPObject()
    //Reader beware, the next two constants make me cringe, but they're useful.
    private let validIPV4AddressRegex = "^(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})(\\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})){3}$"
    private let validIPV6AddressRegex = "^(^(([0-9A-F]{1,4}(((:[0-9A-F]{1,4}){5}::[0-9A-F]{1,4})|((:[0-9A-F]{1,4}){4}::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,1})|((:[0-9A-F]{1,4}){3}::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,2})|((:[0-9A-F]{1,4}){2}::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,3})|(:[0-9A-F]{1,4}::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,4})|(::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,5})|(:[0-9A-F]{1,4}){7}))$|^(::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,6})$)|^::$)|^((([0-9A-F]{1,4}(((:[0-9A-F]{1,4}){3}::([0-9A-F]{1,4}){1})|((:[0-9A-F]{1,4}){2}::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,1})|((:[0-9A-F]{1,4}){1}::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,2})|(::[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,3})|((:[0-9A-F]{1,4}){0,5})))|([:]{2}[0-9A-F]{1,4}(:[0-9A-F]{1,4}){0,4})):|::)((25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{0,2})\\.){3}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{0,2})$$"

    
    override init(){
        //does't really do much
    }
    
    /**
    This function makes a JSON call to the ipinfo API using Alamofire and SwiftyJSON, this will cause a response that will hold
    the user's current IP information with their location added.
    **/
    func sendMyIPInfo(activityIndicator: UIActivityIndicatorView, textBox: UITextField) -> Void{
        Alamofire.request(.GET, baseURL+getGeo).responseJSON{ (_,_,jsonResponse,error) in
            if(error == nil){
                var json = JSON(jsonResponse!)
                self.setVariables(json)
                activityIndicator.stopAnimating()
                textBox.text = self.responseInfo.getIP()
            }else{
                activityIndicator.stopAnimating()
                var alert = UIAlertView(title: "Response Error", message: "There was an error with the response returned from the intial request", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            }
            
        }
    }
    /**
    This will send an Alamofire request to the ipinfo API and set the information
    in the object to the proper information. This should really only be called after
    checkIPAddress is called. This way there can't be any issues
    **/
    func sendOtherIPInfo(ipToSend: String) -> Void {
        Alamofire.request(.GET, (baseURL + ipToSend + "/" + getGeo)).responseJSON{(_,_,jsonResponse,error)in
            if error == nil{
                var json = JSON(jsonResponse!)
                self.setVariables(json)
                
            }else{
                var alert = UIAlertView(title: "Response Error", message: "There was an error with the response returned from the initial request" , delegate: nil, cancelButtonTitle:"Ok")
                alert.show()
            }
            
        }
    
    }
    
    /**
    This is used to check the validity of the IP Address passed in. If the value is a proper
    IPV4 and IPV6 address, then it will return true, otherwise it is false.
    **/
    func checkIPAddress(ipToSend: String) -> Bool{
        if (ipToSend.rangeOfString(validIPV4AddressRegex, options: .RegularExpressionSearch) != nil){
            return true
        }else if ipToSend.rangeOfString(validIPV6AddressRegex, options: .RegularExpressionSearch) != nil{
            return true
        }else {
            return false
        }

    }
    /**
    This is used to just set the variables based off of the JSON response, this should only be called
    after the response has been turned into a JSON object. Check the "send..." functions for usage
    examples.
    **/
    private func setVariables(json: JSON) -> Void{
        var geoArray = json["loc"].string!.componentsSeparatedByString(",")
        let lat = NSString(string: geoArray[0]).doubleValue
        let long = NSString(string: geoArray[1]).doubleValue
        responseInfo.setIP(json["ip"].string!)
        responseInfo.setCity(json["city"].string!)
        responseInfo.setRegion(json["region"].string!)
        responseInfo.setCountry(json["country"].string!)
        responseInfo.setLatitude(lat)
        responseInfo.setLongitude(long)
        responseInfo.setPostalCode(json["postal"].string!)
    }
    
    func getResponseInfo() -> IPObject{
        return self.responseInfo
    }
    
    
    
}
