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
    private var ipQueried:String = ""
    private var city:String = ""
    private var region:String = ""
    private var latitude:String = ""
    private var longitude:String = ""
    private var country:String = ""
    private var postalCode:String  = ""
    
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
    func sendMyIPInfo() -> Void{
        Alamofire.request(.GET, baseURL+getGeo).responseJSON{ (_,_,jsonResponse,error) in
            if(error == nil){
                var json = JSON(jsonResponse!)
                self.setVariables(json)
            }else{
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
        if (ipToSend.rangeOfString(validIPV4AddressRegex, options: .RegularExpressionSearch) != nil){                return true
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
        self.ipQueried = json["ip"].string!
        self.city = json["city"].string!
        self.region = json["region"].string!
        self.country = json["country"].string!
        self.latitude = geoArray[0]
        self.longitude = geoArray[1]
        self.postalCode = json["postal"].string!
    }
    
    
    
}
