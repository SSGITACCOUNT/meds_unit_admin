//
//  ProductVM.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-03-08.
//

import Foundation

class ProductVM {
    var productList: [ProductCategoryModel] = [
        ProductCategoryModel(productCategoryId: "1", categoryName: "Vitamins", product: [ProductModel(name: "5-Htp", price: "20 LKR", image: "", description: ""), ProductModel(name: "Echinacea", price: "100 LKR", image: "", description: ""),ProductModel(name: "Lemon Balm", price: "10 LKR", image: "", description: "")]),
        ProductCategoryModel(productCategoryId: "2", categoryName: "Antibiotics", product: [ProductModel(name: "amoxicillin", price: "1678 LKR", image: "", description: ""), ProductModel(name: "cephalexin", price: "1000 LKR", image: "", description: ""),ProductModel(name: "nitrofurantoin ", price: "1360 LKR", image: "", description: "")]),
        ProductCategoryModel(productCategoryId: "3", categoryName: "painkillers", product: [ProductModel(name: "Acetaminophen", price: "3456 LKR", image: "", description: ""), ProductModel(name: "Aspirin", price: "10 LKR", image: "", description: ""),ProductModel(name: "COX inhibitors", price: "670 LKR", image: "", description: "")]),
        ProductCategoryModel(productCategoryId: "4", categoryName: "Supplements", product: [ProductModel(name: "Casein Proteins", price: "1780 LKR", image: "", description: ""), ProductModel(name: "Collagen Protein", price: "680 LKR", image: "", description: ""),ProductModel(name: "Plant Protein", price: "600 LKR", image: "", description: "")])
    ]
}

struct ProductCategoryModel {
    var productCategoryId: String?
    var categoryName: String?
    var product: [ProductModel]?
}

struct ProductModel {
    var name: String?
    var price: String?
    var image: String?
    var description: String?
}
