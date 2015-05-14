//
//  IPObject.swift
//  IP Locator
//
//  Created by Patrick Zawadzki on 5/14/15.
//  Copyright (c) 2015 PatZawadzki. All rights reserved.
//

import Foundation

class IPObject : NSObject{
    
    private var ipQueried:String = ""
    private var city:String = ""
    private var region:String = ""
    private var latitude:Double = 0.0
    private var longitude:Double = 0.0
    private var country:String = ""
    private var postalCode:String  = ""
    
    
    func setIP(ip:String){
        self.ipQueried = ip
    }
    
    func setCity(city: String){
        self.city = city
    }
    
    func setRegion(region : String){
        self.region = region
    }
    
    func setLatitude(latitude:Double){
            self.latitude = latitude
    }
    func setLongitude(longitude: Double){
        self.longitude = longitude
    }
    func setCountry(country: String){
        self.country = country
    }
    func setPostalCode(postalCode: String){
        
        self.postalCode = postalCode
    }
    
    func getIP() ->String{
        return self.ipQueried
    }
    func getCity() -> String{
        return city
    }
    func getRegion() -> String{
        return self.region
    }
    func getLatitude() -> Double{
        return self.latitude
    }
    func getLongitude() -> Double{
        return self.longitude
    }
    func getCountry() -> String{
        return self.country
    }
    func getPostalCode() -> String{
        return self.postalCode
    }
    
}