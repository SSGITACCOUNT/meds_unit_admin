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
        tableview.register(UINib(nibName: "SenderTVCell", bundle: nil), forCellReuseIdentifier: "SenderTVCell")
        tableview.register(UINib(nibName: "ReceiverTVCell", bundle: nil), forCellReuseIdentifier: "ReceiverTVCell")
        
    }
}

extension ContactVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTVCell", for: indexPath)
        return cell
    }
}


