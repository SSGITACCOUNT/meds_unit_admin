//
//  OngoingOrderVC.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit
import FirebaseFirestore

class OngoingOrderVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var upCommingOrderList = [FirestoreOrderWithStore]() {
        didSet {
            DispatchQueue.main.async {
                //                self.noUpcomingOrderImg.isHidden = self.upCommingOrderList.isEmpty != true
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchOngoingOrdersList()
    }
    
    func navigateToOrderDetail(model: FirestoreOrderWithStore?) {
        guard let _model = model else { return }
        let vc = ApplicationServiceProvider.shared.viewController(in: .Order, identifier: "OrderDetailsVC")
        if let _vc = vc as? OrderDetailsVC {
            _vc.model = model
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchOngoingOrdersList(){
        Firestore.firestore().collection("stores").addSnapshotListener { querySnapshot, err in
            if let error = err {
                print("****\(error)")
                
            } else {
                print("No error")
                self.upCommingOrderList.removeAll()
                var upCommingOrderListTemp = [FirestoreOrderWithStore]()
                let group = DispatchGroup()
                for  doucment in querySnapshot?.documents ?? [] {
                    let _storeDataDictoanary = doucment.data()
                    var firestoreStore =  FirestorePharmacyStore(dictionary:  _storeDataDictoanary)
                    group.enter()
                    doucment.reference.collection("orders").addSnapshotListener { querySnapshotOrders, errInOrders in
                        for orderDocument in querySnapshotOrders?.documents ?? [] {
                            let _orderDataDictoanary = orderDocument.data()
                            let firestorePharmacyOrder =  Order(dictionary: _orderDataDictoanary)
                            if firestorePharmacyOrder?.pharmacyId == Constants.shared.currentLoggedInFireStoreUser?.id {
                                guard let _firestorePharmacyOrder = firestorePharmacyOrder, let _firestoreStore = firestoreStore else { return }
                                var fireStoreOrderWithPharmacy = FirestoreOrderWithStore(firestoreOrder: _firestorePharmacyOrder, firestoreStore: _firestoreStore)
                                upCommingOrderListTemp.append(fireStoreOrderWithPharmacy)
                                
                            }
                            
                        }
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    self.upCommingOrderList.append(contentsOf: upCommingOrderListTemp)
                }
            }
        }
    }
    
    func navigateToOrderView(model: Order) {
        let vc = ApplicationServiceProvider.shared.viewController(in: .Contact, identifier: "ContactVC")
        if let _vc = vc as? ContactVC {
            _vc.vm.orderModel = model
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension OngoingOrderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upCommingOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OngoingOrderTVCell", for: indexPath)
        if let _cell = cell as? OngoingOrderTVCell {
            _cell.configCell(model: upCommingOrderList[indexPath.row])
            _cell.callback = { [weak self] status, message, data in
                guard let _ = self else { return }
                if let _data = data as? Order {
                    self?.navigateToOrderView(model: _data)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = upCommingOrderList[indexPath.row]
        navigateToOrderDetail(model: model)
    }
}


enum OrderType {
    case ongoing
    case past
}
