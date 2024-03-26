//
//  StoreRegisterVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-16.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class StoreRegisterVC: UIViewController {

    @IBOutlet weak var shopNameLbl: UITextField!
    @IBOutlet weak var shopAddressTxt: UITextField!
    @IBOutlet weak var contactNumberTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let vm = StoreRegisterVM()
    var longitude: Double?
    var latitude: Double?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func navigateToAdminHomeView() {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Auth, identifier: "AdminHomeVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToToMapView() {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Location, identifier: "SetLocationOnMapView")
        if let _vc = vc as? SetLocationOnMapView {
            _vc.callback = { [weak self] (latitude, longitude, address) in
                guard let _ = self else { return }
                self?.latitude = latitude
                self?.longitude = longitude
                self?.shopAddressTxt.text = address
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func addStoreNetworkRequest() {
        vm.createNewStoreOnFirebase(storeName: shopNameLbl.text, address: shopAddressTxt.text, phoneNumber: contactNumberTxt.text, location: GeoPoint(latitude:latitude ?? 0.0, longitude: longitude ?? 0.0)) { status, message, data in
            let _errorMsg = message ?? "Failed To Create an Store.Please Try Again!"
            if(status){
                self.navigateToAdminHomeView()
            }else{
                AlertManager.shared.singleActionMessage(title: "Alert", message: _errorMsg, action: "Ok", vc: self)
            }
        }
    }
    @IBAction func addAction(_ sender: Any) {
        addStoreNetworkRequest()
    }
    
    @IBAction func navigateToMapViewAction(_ sender: Any) {
        navigateToToMapView()
    }
}
