//
//  detailsVC.swift
//  parse2four
//
//  Created by Suat Selen on 24.10.2018.
//  Copyright © 2018 mehmet selen. All rights reserved.
//

import UIKit
import Parse
import MapKit

class detailsVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var selectedPlace = ""
    var choosenLatitude = ""
    var choosenLongitude = ""
    
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeAtmosphereLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var nameArray = [String]()
    var typeArray = [String]()

    var atmosphereArray = [String]()

    var latitudeArray  = [String]()

    var longitudeArray = [String]()
    var imageArray = [PFFile]()

    
    var manager = CLLocationManager()
    var requestCLLocation = CLLocation()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        findPlaceFromServer()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //selectedLocation
    }
    
    func findPlaceFromServer() {
        
        let query = PFQuery(className: "Places")
        query.whereKey("name", equalTo: self.selectedPlace)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                let okButton  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true , completion: nil)
            } else {
                self.nameArray.removeAll(keepingCapacity: false)
                self.typeArray.removeAll(keepingCapacity: false)
                self.atmosphereArray.removeAll(keepingCapacity: true)
                self.imageArray.removeAll(keepingCapacity: true)
                self.latitudeArray.removeAll(keepingCapacity: false)
                self.longitudeArray.removeAll(keepingCapacity: false)
                
                for object in objects! {
                    self.nameArray.append(object.object(forKey: "name") as! String)
                    self.typeArray.append(object.object(forKey: "type") as! String)
                    self.atmosphereArray.append(object.object(forKey: "atmosphere") as! String)
                    self.imageArray.append(object.object(forKey: "image") as! PFFile)
                    self.latitudeArray.append(object.object(forKey: "latitude") as! String)
                    self.longitudeArray.append(object.object(forKey: "longitude") as! String)
                   
                    
                    self.placeNameLabel.text = "Name: \(self.nameArray.last!)"
                    self.placeTypeLabel.text = "Type: \(self.typeArray.last!)"
                    self.placeAtmosphereLabel.text = "Atmosphere: \(self.typeArray.last!)"
                    self.choosenLatitude = self.latitudeArray.last!
                    self.choosenLongitude = self.longitudeArray.last!
                    
                    self.imageArray.last?.getDataInBackground(block: { (data, error) in
                        if error != nil {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                            let okButton  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                            alert.addAction(okButton)
                            self.present(alert, animated: true , completion: nil)
                        } else {
                            self.placeImage.image = UIImage(data: data!)
                        }
                    })

                    
                }
            }
        }
        
    }
    
    
    

}
