//
//  DashboardVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-08.
//

import UIKit

class DashboardVC: UIViewController {

    let vm = DashboardVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupUI() {
        
    }
}
