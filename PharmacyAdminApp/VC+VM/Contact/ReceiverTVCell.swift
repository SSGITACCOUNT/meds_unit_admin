//
//  ReceiverTVCell.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-08.
//

import UIKit

class ReceiverTVCell: UITableViewCell {

    @IBOutlet weak var receiverImg: UIImageView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var nameLetterLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) { }
    
    func setupUI() {
        receiverImg.layer.cornerRadius = 20
        receiverImg.clipsToBounds = true
    }
    
    func configCell(model: ChatModel) {
        messageLbl.text = model.message
        nameLetterLbl.text = "\((model.userName?.first ?? "M").uppercased())"
        dateLbl.text = "08 Mar 2024"
    }
}
