//
//  ViewController.swift
//  DemoLatLngFromZipCode
//
//  Created by vibha on 31/07/18.
//  Copyright © 2018 vibha. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    let apikey = "AIzaSyDZeAHfq4SdZt-U9sJXQu5Fx5p-RzfU_C4"
    var geocoder = CLGeocoder()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getCoordinate(addressString: "24740", completionHandler: {_,_ in
       //     return
        //})
        //-----------------------
//        let address = "8787 Snouffer School Rd, Montgomery Village, MD 20879"
//        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
//            if((error) != nil){
//                print("Error", error ?? "")
//            }
//            if let placemark = placemarks?.first {
//                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
//                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
//            }
//        })
        
        //----------------
        getLatLngForZip(zipCode: "95014")
       // let geoCoder = CLGeocoder()
//        geoCoder.geocodeAddressString("024740", completionHandler: { placemarks, error in
//            let placemark = placemarks?[0]
//            let location: CLLocation? = placemark?.location
//            let coordinate: CLLocationCoordinate2D? = location?.coordinate
//            print("Latitude \(coordinate?.latitude ?? 0)")
//            print("Longitude \(coordinate?.longitude ?? 0)")
//        })
        
        
    }
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                
                
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getLatLngForZip(zipCode: String) {
        let url = NSURL(string: "\(baseUrl)address=\(zipCode)&key=\(apikey)")
        let data = NSData(contentsOf: url! as URL)
        //let data = NSData(contentsOfURL: url! as URL)
        
        let json = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        if let result = json["results"] as? NSArray {
            if let geometry = result[0] as? NSDictionary {
                if let location = geometry["location"] as? NSDictionary {
                    let latitude = location["lat"] as! Float
                    let longitude = location["lng"] as! Float
                    print("\n\(latitude), \(longitude)")
                }
            }
        }
    }

}

