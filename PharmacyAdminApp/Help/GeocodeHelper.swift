//
//  GeocodeHelper.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-16.
//

import Foundation
import GoogleMaps

class GeocodeHelper {
 
    static let shared = GeocodeHelper()
    var geocoder: GMSGeocoder?
    
    init() {
        self.geocoder = GMSGeocoder()
    }
    
    func reverseLatLng(latitude: Double, longitude: Double, completion: @escaping (_ address: String) -> ()) {
        let locationCoordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.reverseCoordinate(location: locationCoordinates, completion: completion)
    }
    
    func reverseCoordinate(location : CLLocationCoordinate2D, completion: @escaping (_ address: String) -> ()) {
        geocoder?.accessibilityLanguage = "en-US"
        geocoder?.reverseGeocodeCoordinate(location) { response , error in
            if let _address = response?.firstResult(), let _lines = _address.lines {
                completion("\(_lines.joined(separator: ", "))")
            }
        }
    }
}
