//
//  Contact.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var messegeTxt: UITextField!
    
    let vm = ContactVM()
    var messages: [MessageFireData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        
        tableview.register(UINib(nibName: "SenderTVCell", bundle: nil), forCellReuseIdentifier: "SenderTVCell")
        tableview.register(UINib(nibName: "ReceiverTVCell", bundle: nil), forCellReuseIdentifier: "ReceiverTVCell")
        
        fetchChatMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func sendMessageAction() {
        guard let _message = messegeTxt.text, let model = vm.orderModel else { return }
        let trimmedMessage = _message.trimmingCharacters(in: .whitespacesAndNewlines)
        if  trimmedMessage == "" || trimmedMessage.isEmpty { return }
        
        FirestoreHelper.shared.sendMessage(orderId: model.orderId ?? "", _message, customerName: model.name ?? "", customerId: model.phoneNumber ?? "", customerImage: model.imageUrl ?? "")
        messegeTxt.text = ""
    }
    
    func fetchChatMessages(){
        guard let _orderNo =  vm.orderModel?.orderId else { return }
        FirestoreHelper.shared.getOrderChatData(orderNo: _orderNo, CustomerId: vm.orderModel?.customerId ?? "", customerName: vm.orderModel?.name ?? "", customerImage: "") { [weak self] messageData, isClosed in
            guard let _ = self else { return }
            self?.messages = messageData
            self?.tableview.reloadData()
        }
    }
        
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openCameraAction(_ sender: Any) {
        
    }
        
    @IBAction func messageSendAction(_ sender: Any) {
        sendMessageAction()
    }
    
}

extension ContactVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = messages[indexPath.row]
        if model.sender?.phoneNumber == Constants.shared.currentLoggedInFireStoreUser?.phone {
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


