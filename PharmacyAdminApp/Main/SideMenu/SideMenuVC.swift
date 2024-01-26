//
//  SideMenuVC.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-18.
//

import UIKit

class SideMenuVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let vm = SideMenuVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVCell", for: indexPath)
        if let _cell = cell as? SideMenuTVCell {
            _cell.configCell(model: vm.menuList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.menuList = vm.menuList.map({SideMenuModel(image: $0.image, name: $0.name, targetIdentifier: $0.targetIdentifier)})
        tableView.reloadData()
        
        sideMenuControllerInstance?.performSegue(withIdentifier: vm.menuList[indexPath.row].targetIdentifier, sender: nil)
    }
}
