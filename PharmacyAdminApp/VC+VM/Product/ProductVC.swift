//
//  ProductVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-08.
//

import UIKit

class ProductVC: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    let vm = ProductVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.estimatedRowHeight = 100
        productTableView.rowHeight = UITableView.automaticDimension        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension ProductVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCategoryTVCell" , for: indexPath)
        if let _cell = cell as? ProductCategoryTVCell {
            _cell.configCell(model: vm.productList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


