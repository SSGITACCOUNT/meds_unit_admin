//
//  HomeVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-06.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func orderViewAction(_ sender: Any) {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Order, identifier: "OrderVC")
        navigationController?.pushViewController(vc, animated: true)
    }
}