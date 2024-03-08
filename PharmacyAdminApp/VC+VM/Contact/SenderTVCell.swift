//
//  SenderTVCell.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-08.
//

import UIKit

class SenderTVCell: UITableViewCell {

    @IBOutlet weak var senderImg: UIImageView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var nameLetterLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    func setupUI() {
        senderImg.layer.cornerRadius = 20
        senderImg.clipsToBounds = true
    }
    
    func configCell(model: ChatModel) {
        messageLbl.text = model.message
        nameLetterLbl.text = "\((model.userName?.first ?? "M").uppercased())"
        dateLbl.text = "08 Mar 2024"
    }
}
