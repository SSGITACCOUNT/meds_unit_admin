//
//  AddProductVC.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-28.
//

import UIKit

class AddProductVC: UIViewController {

    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var deseTxt: UITextField!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var productImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func updateUI() {
        productImg.layer.cornerRadius = 20
        productImg.layer.borderWidth = 0.6
        productImg.layer.borderColor = UIColor.lightGray.cgColor
        productImg.layer.masksToBounds = true
    }

    @IBAction func uploadAction(_ sender: Any) {
    }
    @IBAction func addAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
