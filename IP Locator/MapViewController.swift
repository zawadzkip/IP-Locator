//
//  MapViewController.swift
//  IP Locator
//
//  Created by Patrick Zawadzki on 5/14/15.
//  Copyright (c) 2015 PatZawadzki. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import IJReachability

class MapViewController : UIViewController, MKMapViewDelegate{
    
    private var ipObject: IPObject = IPObject()
   
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navBarBack: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        if(!IJReachability.isConnectedToNetwork()){
            var alert = UIAlertView(title: "No Internet Connection", message: "Please check your internet connection.", delegate: nil, cancelButtonTitle: "Ok")
        }else{
            self.mapView.delegate = self
            var currentLocation = CLLocationCoordinate2DMake(ipObject.getLatitude(), ipObject.getLongitude())
            var dropPin = MKPointAnnotation()
            dropPin.coordinate = currentLocation
            dropPin.title = ipObject.getCity() + ", " + ipObject.getRegion() + ", " + ipObject.getCountry()
            mapView.addAnnotation(dropPin)
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: ipObject.getLatitude(), longitude: ipObject.getLongitude()), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? UIViewController{
            vc.view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        }
    }
  
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    func setIPObject(ipObject: IPObject){
        self.ipObject = ipObject
    }
}
