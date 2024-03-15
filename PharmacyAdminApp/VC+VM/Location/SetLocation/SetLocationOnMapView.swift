//
//  SetLocationOnMapView.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-16.
//

import UIKit
import GoogleMaps

class SetLocationOnMapView: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var setLocationBtn: RoundedButton!
    
    let MIN_MAP_ZOOM: Float = 18.0
    var currentLocation: CLLocation?
    var driverMarker = GMSMarker()
    var vwGMap = GMSMapView()
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var callback: LocationHandler?
    
    var isLocationButtonActive: Bool = true {
        didSet {
            setLocationBtn.isUserInteractionEnabled = isLocationButtonActive
            setLocationBtn.alpha = isLocationButtonActive ? 1 : 0.6
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncLocation()
        changeMapMarkerStyle(.searching)
        isLocationButtonActive = false
        vwGMap.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func  syncLocation() {
        LocationManager.shared.getLocation { [weak self] (location, error) in
            guard let _ = self, let _location = location else { return}
            self?.currentLocation = _location
            self?.setupMap()
        }
    }
    func setupMap() {
        mapView.delegate = self
        guard let _currentLocation = currentLocation else { return }
        MapUtils.moveMapCamera(mapView, CLLocationCoordinate2D(latitude: _currentLocation.coordinate.latitude, longitude: _currentLocation.coordinate.longitude), animated: false)
    }
    func changeMapMarkerStyle(_ status: MapDelegateStatus){
        switch status {
        case .searching:
            searchTxt.text = "Fetching Location"
            isLocationButtonActive = false
            // markerPinImg.image = UIImage(named: "ic_map_pin_searching")
        case .idle:
            isLocationButtonActive = true
            // markerPinImg.image = UIImage(named: "ic_map_pin_location")
        }
    }
    func reverseLocationCoordinates(_ position: GMSCameraPosition) {
        GeocodeHelper.shared.reverseCoordinate(location: position.target) { [weak self] (address) in
            guard let _ = self else { return }
            let location = position.target
            self?.changeMapMarkerStyle(.idle)
            self?.searchTxt.text = address
            self?.latitude = location.latitude
            self?.longitude = location.longitude
            self?.address = address
        }
    }
    
    @IBAction func setLocationAction(_ sender: Any) {
        if let _latitude = latitude, let _longitude = longitude, let _address = address {
            self.callback?(_latitude, _longitude, _address)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
extension SetLocationOnMapView: CLLocationManagerDelegate, GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print("GMAP","Will Move")
        changeMapMarkerStyle(.searching)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        print("GMAP","Did Move")
        reverseLocationCoordinates(cameraPosition)
    }
}
