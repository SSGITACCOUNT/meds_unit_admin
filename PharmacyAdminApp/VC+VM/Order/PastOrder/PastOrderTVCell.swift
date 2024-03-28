//
//  PastOrderTVCell.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

class PastOrderTVCell: UITableViewCell {

    @IBOutlet weak var logoNameImg: UIImageView!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var orderNoLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    var orderModel: Order?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    func configCell(model: FirestoreOrderWithStore) {
        self.orderModel = model.firestoreOrder
        orderNoLbl.text = model.firestoreOrder?.orderId
        customerNameLbl.text = model.firestoreOrder?.name
        dateLbl.text = model.firestoreOrder?.orderDate
        statusLbl.text = model.firestoreOrder?.orderStatus
        
        if let url = URL(string: model.firestoreOrder?.imageUrl ?? "") {
            logoNameImg.af.setImage(withURL: url, cacheKey: model.firestoreOrder?.imageUrl ?? "", placeholderImage: UIImage(named: "profile_Img-1"), runImageTransitionIfCached: true, completion: nil)
        }
        
        logoNameImg.layer.cornerRadius = logoNameImg.frame.height / 2
        logoNameImg.layer.masksToBounds = true
    }

}
