//
//  GoogleMapsManager.swift
//  PharmacyApp
//
//  Created by Shashikala on 2023-01-14.
//

import Foundation

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapsManager: NSObject {
    static var shared: GoogleMapsManager = {
        let sharedObj = GoogleMapsManager()
        
        return sharedObj
    }()
    var origin_marker: GMSMarker = GMSMarker()
    var destination_marker: GMSMarker = GMSMarker()
    var polyline = GMSPolyline()
    
    func configure() {
        GMSServices.provideAPIKey(Constants.shared.MAPKEY)
        GMSPlacesClient.provideAPIKey(Constants.shared.MAPKEY)
    }
    
    func setStyle(_ mapView: GMSMapView) {
        do {
          if let styleURL = Bundle.main.url(forResource: "GoogleMapsStyle", withExtension: "json") {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
          } else {
            print("Unable to find GoogleMapsStyle.json")
          }
        } catch {
          print("One or more of the map styles failed to load. \(error)")
        }
      }
    
    func getAddressFromLocation(location: CLLocation, _ completion: @escaping ActionHandler) {
        GMSGeocoder().reverseGeocodeCoordinate(location.coordinate) { (response, error) in
            guard let address = response?.firstResult()?.lines else {
                completion(false, "")
                return
            }
            
            let _address = address.joined(separator: ", ")
            completion(true, _address)
        }
    }
    
    func navigateWithDirection(location: CLLocation) -> Bool {
        guard let appUrl = URL(string: Constants.shared.GOOGLEMAPS_APP_BASE_URL), UIApplication.shared.canOpenURL(appUrl) else { return false }
        
        let url = "\(Constants.shared.GOOGLEMAPS_APP_BASE_URL)?saddr=&daddr=\(location.coordinate.latitude),\(location.coordinate.longitude)&directionsmode=driving"
        
        guard let _url = URL(string: url) else { return false }
        UIApplication.shared.open(_url, options: [:], completionHandler: nil)
        return true
    }
}
