//
//  PastOrderTVCell.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

class PastOrderTVCell: UITableViewCell {

    @IBOutlet weak var logoNameImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var orderNoLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
