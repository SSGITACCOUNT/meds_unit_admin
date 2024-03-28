//
//  SenderChatImageTVCell.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-26.
//

import UIKit

class SenderChatImageTVCell: UITableViewCell {

    @IBOutlet weak var senderImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLetterLbl: UILabel!
    
    var callback: CompletionHandlerWithData?
    var model: MessageFireData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    
    func configCell(model: MessageFireData) {
        self.model = model
        
        if let url = URL(string: model.message ?? "") {
            senderImg.af.setImage(withURL: url, cacheKey: model.message ?? "", placeholderImage: UIImage(named: "profile_Img-1"), runImageTransitionIfCached: true, completion: nil)
        }
        nameLetterLbl.text = "\((model.sender?.name?.first ?? "M").uppercased())"
        dateLbl.text = dateFormater.string(from: FirestoreHelper.shared.utcDateFormater.date(from: model.timestamp ?? "") ?? Date())
        
        senderImg.layer.cornerRadius = 12
        senderImg.layer.masksToBounds = true
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
    
    @IBAction func viewImgeAction(_ sender: Any) {
        self.callback?(true, "Ok", model)
    }
}
