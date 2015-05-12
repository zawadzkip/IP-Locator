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
    private let baseURL = "ipinfo.io/"
    private let json = "json"
    private var ipQueried:String = ""
    private var city:String = ""
    private var region:String = ""
    private var latitude:String = ""
    private var longitude:String = ""
    private var country:String = ""
    private var postalCode:String  = ""
    
    override init(){
        //does't really do much
    }
    
    func sendMyIPInfo() -> Void{
        Alamofire.request(.GET, "http://ipinfo.io/json").responseJSON{ (_,_,json,error) in
            if(error == nil){
                var json = JSON(json!)
                var geoArray = json["loc"].string!.componentsSeparatedByString(",")
                self.ipQueried = json["ip"].string!
                self.city = json["city"].string!
                self.region = json["region"].string!
                self.country = json["country"].string!
                self.latitude = geoArray[0]
                self.longitude = geoArray[1]
                self.postalCode = json["postal"].string!
            }else{
                var alert = UIAlertView(title: "Request Error", message: "There was an error with the Response", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            }
            
        }
    }
    
    
    
}
