//
//  Router.swift
//  Whereno
//
//  Created by Kyle Bashour on 4/26/16.
//  Copyright © 2016 Kyle Bashour. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

enum Router: URLRequestConvertible {

    case comments(Int)
    case hammockLocations(MKCoordinateRegion)

    var URL: NSURL { return ObjectFetcher.sharedInstance.baseURL.URLByAppendingPathComponent(route.path) }

    var route: (path: String, parameters: [String: AnyObject]) {
        switch self {
        case .comments(let locationID):
            return ("/comment", ["id": locationID])
        case .hammockLocations(let region):

            let lat = region.center.latitude
            let lon = region.center.longitude
            let latDelt = region.span.latitudeDelta
            let lonDelt = region.span.longitudeDelta

            return ("/feed", ["latitude": lat, "longitude": lon, "latitude_delta": latDelt, "longitude_delta": lonDelt])
        }
    }

    var URLRequest: NSMutableURLRequest {
        let request = Alamofire.ParameterEncoding.URLEncodedInURL
            .encode(NSURLRequest(URL: URL), parameters: route.parameters).0
        request.setValue("Token token=\"\(User.authenticatedUser?.authToken ?? "")\"", forHTTPHeaderField: "Authorization")
        return request
    }
}