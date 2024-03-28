//
//  ChatImageVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-28.
//

import UIKit

class ChatImageVC: UIViewController {

    @IBOutlet weak var orderImg: UIImageView!
    @IBOutlet weak var closeAction: UIButton!
    
    var model: MessageFireData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let model = model else {
            return
        }
        if let url = URL(string: model.message ?? "") {
            orderImg.af.setImage(withURL: url, cacheKey: model.message ?? "", placeholderImage: UIImage(named: "profile_Img-1"), runImageTransitionIfCached: true, completion: nil)
        }
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
