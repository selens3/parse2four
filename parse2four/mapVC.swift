//
//  mapVC.swift
//  parse2four
//
//  Created by Suat Selen on 24.10.2018.
//  Copyright © 2018 mehmet selen. All rights reserved.
//

import UIKit
import Parse
import MapKit

class mapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    

    @IBOutlet weak var mapView: MKMapView!
    var manager = CLLocationManager()
    var choosenLatitude = ""
    var choosenLongitude = ""
    
    override func viewDidLoad() { ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        super.viewDidLoad()
        
        mapView.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        

        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(mapVC.chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(recognizer)
        
        
        
        
     ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.choosenLongitude = ""
        self.choosenLatitude = ""
        
    }
    
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = globalName
            annotation.subtitle = globalType
            
            self.mapView.addAnnotation(annotation)
            
            self.choosenLatitude = String(coordinates.latitude)
            self.choosenLongitude = String(coordinates.longitude)
            
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    

    @IBAction func saveClicked(_ sender: Any) {
        let object = PFObject(className: "Places")
        object["name"] = globalName
        object["type"] = globalType
        object["atmosphere"] = globalAtmosphere
        object["latitude"] = self.choosenLatitude
        object["longitude"] = self.choosenLongitude
        
        if let imageData = globalImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFile(name: "image.jpg", data: imageData)
            
        }
        object.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                self.performSegue(withIdentifier: "frommapVCtoplacesVC", sender: nil)
                
            }
        }
        
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
