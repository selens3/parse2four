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



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}
