//
//  PastOrderVC.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit
import FirebaseFirestore

class PastOrderVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pastOrderList = [FirestoreOrderWithStore]() {
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
        fetchPastOrdersList()
    }
    
    func navigateToOrderDetail(model: FirestoreOrderWithStore?) {
        guard let _model = model else { return }
        let vc = ApplicationServiceProvider.shared.viewController(in: .Order, identifier: "OrderDetailsVC")
        if let _vc = vc as? OrderDetailsVC {
            _vc.model = model
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchPastOrdersList(){
        Firestore.firestore().collection("stores").addSnapshotListener { querySnapshot, err in
            if let error = err {
                print("****\(error)")
                
            } else {
                print("No error")
                self.pastOrderList.removeAll()
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
                    let arryList = upCommingOrderListTemp.filter({$0.firestoreOrder?.orderStatus == "COMPLETED" || $0.firestoreOrder?.orderStatus == "CANCELED"})
                    self.pastOrderList.append(contentsOf: arryList)
                }
            }
        }
    }

}

extension PastOrderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastOrderTVCell", for: indexPath)
        if let _cell = cell as? PastOrderTVCell {
            _cell.configCell(model: pastOrderList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = pastOrderList[indexPath.row]
        navigateToOrderDetail(model: model)
    }
}
