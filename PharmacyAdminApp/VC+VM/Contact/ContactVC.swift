//
//  Contact.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    let vm = ContactVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        
        tableview.register(UINib(nibName: "SenderTVCell", bundle: nil), forCellReuseIdentifier: "SenderTVCell")
        tableview.register(UINib(nibName: "ReceiverTVCell", bundle: nil), forCellReuseIdentifier: "ReceiverTVCell")
        
    }
}

extension ContactVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.chatModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = vm.chatModel[indexPath.row]
        if model.isSender == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTVCell", for: indexPath)
            if let _cell = cell as? SenderTVCell {
                _cell.configCell(model: model)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTVCell", for: indexPath)
            if let _cell = cell as? ReceiverTVCell {
                _cell.configCell(model: model)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


