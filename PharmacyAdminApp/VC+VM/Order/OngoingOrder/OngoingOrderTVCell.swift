//
//  OngoingOrderTVCell.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

class OngoingOrderTVCell: UITableViewCell {

    @IBOutlet weak var logoNameImg: UIImageView!
    @IBOutlet weak var customerLbl: UILabel!
    @IBOutlet weak var orderNoLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    var callback: CompletionHandlerWithData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    func configCell(model: FirestoreOrderWithStore) {
        orderNoLbl.text = model.firestoreOrder?.orderId
        customerLbl.text = model.firestoreOrder?.user?.fName
        dateLbl.text = model.firestoreOrder?.orderDate
        statusLbl.text = model.firestoreOrder?.orderStatus
    }

    @IBAction func chatAction(_ sender: Any) {
        callback?(true, "", nil)
    }
}
