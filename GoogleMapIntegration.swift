//
//  GoogleMapIntegration.swift
//  Flyshare
//
//  Created by administrator on 2/9/19.
//  Copyright © 2019 Kriann Atilano. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapIntegration: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyCB3tDL69S4W4k35t6Fd1PtBr45TBCdGI4")
        let camera = GMSCameraPosition.camera(withLatitude: 39.430841, longitude: 26.234755, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(39.430841, 26.234755)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Online Drone"
        
    }
    
}
