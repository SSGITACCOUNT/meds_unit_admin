//
//  OrderDetailsVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-11.
//

import UIKit

class OrderDetailsVC: UIViewController {

    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var customerNamelbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    
    var model: FirestoreOrderWithStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func updateUI() {
        guard let _model = model else { return }
        phoneNumberLbl.text = model?.firestoreOrder?.phoneNumber
        addressLbl.text = model?.firestoreOrder?.customerAddress
        customerNamelbl.text = model?.firestoreOrder?.name
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
