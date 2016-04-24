//
//  CLLocationManager+Extensions.swift
//  Whereno
//
//  Created by Kyle Bashour on 4/24/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import CoreLocation

extension CLLocationManager {

    class func requestLocationPermissionIfNeeded() {
        if authorizationStatus() == .NotDetermined {
            CLLocationManager().requestWhenInUseAuthorization()
        }
    }
}