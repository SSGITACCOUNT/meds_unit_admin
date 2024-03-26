//
//  ReceiverChatImageTVCell.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-26.
//

import UIKit

class ReceiverChatImageTVCell: UITableViewCell {
    
    @IBOutlet weak var receiverImg: UIImageView!    
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    func configCell(model: MessageFireData) {
        if let url = URL(string: model.message ?? "") {
            receiverImg.af.setImage(withURL: url, cacheKey: model.message ?? "", placeholderImage: UIImage(named: "profile_Img-1"), runImageTransitionIfCached: true, completion: nil)
        }
        dateLbl.text = dateFormater.string(from: FirestoreHelper.shared.utcDateFormater.date(from: model.timestamp ?? "") ?? Date())
        
        receiverImg.layer.cornerRadius = 12
        receiverImg.layer.masksToBounds = true
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
