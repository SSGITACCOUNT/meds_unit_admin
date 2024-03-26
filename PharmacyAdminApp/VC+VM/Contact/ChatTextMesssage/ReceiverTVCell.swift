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
    
    func configCell(model: MessageFireData) {
        messageLbl.text = model.message
        nameLetterLbl.text = "\((model.receiver?.name?.first ?? "M").uppercased())"
        dateLbl.text = dateFormater.string(from: FirestoreHelper.shared.utcDateFormater.date(from: model.timestamp ?? "") ?? Date())
    }
    
    private var dateFormater: DateFormatter {
        get {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "MMM dd, YYYY h:mm a"
            formatter.timeZone = TimeZone.current
            return formatter
        }
    }
}
