//
//  SideMenuTVCell.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-18.
//

import UIKit

class SideMenuTVCell: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
 
    func configCell(model: SideMenuModel) {
        iconImg.image = model.image
        nameLbl.text = model.name
    }
}
