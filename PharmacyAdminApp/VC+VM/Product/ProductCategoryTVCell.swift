//
//  ProductCategoryTVCell.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-08.
//

import UIKit

class ProductCategoryTVCell: UITableViewCell {

    @IBOutlet weak var productItemCollectionView: UICollectionView!
    @IBOutlet weak var categeryNameLbl: UILabel!
    
    var itemList: [ProductModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productItemCollectionView.delegate = self
        productItemCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    func configCell(model: ProductCategoryModel) {
        self.categeryNameLbl.text = model.categoryName
        self.itemList = model.product
    }
}

extension ProductCategoryTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryCVCell", for: indexPath)
        if let _cell = cell as? ProductCategoryCVCell, let model = itemList?[indexPath.row]  {
            _cell.configCell(model: model)
            _cell.delegate = self
        }
        return cell
    }
}

extension ProductCategoryTVCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 32) / 2
        return CGSize(width: width, height: 160)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension ProductCategoryTVCell: ProductCategoryDelegate {
    func addItem(itemCount: Int) {
    }
    
    func removeItem(itemCount: Int) {
    }
}
