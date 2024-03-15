//
//  MapUtils.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-16.
//

import Foundation
import CoreLocation
import GoogleMaps
import UIKit
import AlamofireImage

open class MapUtils {
    
    class func addMarker(_ mapView: GMSMapView,_ point: CLLocationCoordinate2D, image: String, snippet: String, isCentered: Bool = false){
        let marker = GMSMarker(position: point)
        marker.position = point
        marker.icon = UIImage(named: image)
        marker.snippet = snippet
        marker.isTappable = false
        if isCentered {
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        }
        marker.map = mapView
    }
    
    class func addCustomMarker(_ mapView: GMSMapView,_ point: CLLocationCoordinate2D, imageUrl: String, snippet: String){
        let marker = GMSMarker(position: point)
        marker.zIndex = 0
        marker.position = point
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        
        let markerImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        markerImgView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        markerImgView.contentMode = .scaleAspectFill
        markerImgView.layer.masksToBounds = true
        markerImgView.layer.cornerRadius = 20
        markerImgView.layer.borderWidth = 1
        markerImgView.layer.borderColor = UIColor.black.cgColor
        
        if let url = URL(string: imageUrl) {
            markerImgView.af.setImage(withURL: url, cacheKey: imageUrl, placeholderImage: nil, runImageTransitionIfCached: true) { image in
                if let imageData = image.data {
                    markerImgView.image = UIImage(data: imageData)
                }
            }
        } else {
            markerImgView.image = nil
        }
        
        marker.iconView = markerImgView
        marker.snippet = snippet
        marker.isTappable = false
        marker.map = mapView
    }
    
    class func addCustomMarker(_ mapView: GMSMapView,_ point: CLLocationCoordinate2D, image: String, snippet: String){
        let marker = GMSMarker(position: point)
        marker.position = point
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        
        let markerImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        markerImgView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        markerImgView.contentMode = .scaleAspectFill
        markerImgView.layer.masksToBounds = true
        markerImgView.layer.cornerRadius = 20
        markerImgView.layer.borderWidth = 1
        markerImgView.layer.borderColor = UIColor.black.cgColor
        markerImgView.image = UIImage(named: image)
        
        marker.iconView = markerImgView
        marker.snippet = snippet
        marker.isTappable = false
        marker.map = mapView
    }
    
    class func moveMapCamera(_ mapView: GMSMapView,_ point: CLLocationCoordinate2D, zoomLevel: Float = 15, animated: Bool = true) {
        if animated == true {
            mapView.camera = GMSCameraPosition.camera(withLatitude: point.latitude, longitude: point.longitude, zoom: 1)
            CATransaction.begin()
            CATransaction.setValue(2.0, forKey: kCATransactionAnimationDuration)
            let city = GMSCameraPosition.camera(withLatitude: point.latitude, longitude: point.longitude, zoom: zoomLevel)
            mapView.animate(to: city)
            CATransaction.commit()
        } else {
            mapView.camera = GMSCameraPosition.camera(withLatitude: point.latitude, longitude: point.longitude, zoom: zoomLevel)
        }
    }
    
    class func getArcPath(from startLocation: CLLocationCoordinate2D, to endLocation: CLLocationCoordinate2D) -> GMSMutablePath {
        
        let distance = GMSGeometryDistance(startLocation, endLocation)
        let midPoint = GMSGeometryInterpolate(startLocation, endLocation, 0.5)
        
        let midToStartLocHeading = GMSGeometryHeading(midPoint, startLocation)
        
        let controlPointAngle = 360.0 - (90.0 - midToStartLocHeading)
        let controlPoint = GMSGeometryOffset(midPoint, distance / 2.0 , controlPointAngle)
        
        let path = GMSMutablePath()
        
        let stepper = 0.05
        let range = stride(from: 0.0, through: 1.0, by: stepper)// t = [0,1]
        
        func calculatePoint(when t: Double) -> CLLocationCoordinate2D {
            let t1 = (1.0 - t)
            let latitude = t1 * t1 * startLocation.latitude + 2 * t1 * t * controlPoint.latitude + t * t * endLocation.latitude
            let longitude = t1 * t1 * startLocation.longitude + 2 * t1 * t * controlPoint.longitude + t * t * endLocation.longitude
            let point = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            return point
        }
        
        range.map { calculatePoint(when: $0) }.forEach { path.add($0) }
        return path
    }
    
    class func getLinePath(wayPoints: [CLLocationCoordinate2D]) -> GMSMutablePath {
        let path = GMSMutablePath()
        for wayPoint in wayPoints {
            path.add(wayPoint)
        }
        return path
    }
}


