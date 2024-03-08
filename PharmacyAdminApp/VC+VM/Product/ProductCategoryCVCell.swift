//
//  ProductCategoryCVCell.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-08.
//

import UIKit

protocol ProductCategoryDelegate {
    func addItem(itemCount: Int)
    func removeItem(itemCount: Int)
}

class ProductCategoryCVCell: UICollectionViewCell {
    
    @IBOutlet weak var mainVIew: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNamelbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productCountLbl: UILabel!
    @IBOutlet weak var cartView: UIView!
    
    var delegate: ProductCategoryDelegate?
    var itemCount = 0
    
    func configCell(model: ProductModel) {
        productImage.layer.cornerRadius = 12
        productImage.layer.masksToBounds = true
        
        cartView.layer.cornerRadius = 20
        
        mainVIew.layer.cornerRadius = 12
        mainVIew.layer.borderWidth = 1
        mainVIew.layer.borderColor = UIColor.systemGray5.cgColor
        
        productNamelbl.text = model.name
        productPriceLbl.text = model.price
        
    }
    
    
    @IBAction func increaseAction(_ sender: Any) {
        itemCount += 1
        delegate?.addItem(itemCount: itemCount)
        productCountLbl.text = "\(itemCount)"
    }
    
    @IBAction func decreseAction(_ sender: Any) {
        if itemCount > 0 {
            itemCount -= 1
            delegate?.removeItem(itemCount: itemCount)
            productCountLbl.text = "\(itemCount)"
        }
    }
}
