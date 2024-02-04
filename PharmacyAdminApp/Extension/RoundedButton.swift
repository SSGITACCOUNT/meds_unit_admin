//
//  RoundedButton.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-18.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
        self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }

}

@IBDesignable class RoundedView: UIView{
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
        self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }

}

//Rounded Corner
extension UIView {
    
    func roundViewCorners(corners: UIRectCorner, radius: CGFloat) {
        self.layer.masksToBounds = true
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundViewCornersWithShadow(corners: UIRectCorner, radius: CGFloat) {
        let roundedShapeLayer = CAShapeLayer()
        let roundedMaskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        roundedShapeLayer.frame = self.bounds
        roundedShapeLayer.fillColor = UIColor.white.cgColor
        roundedShapeLayer.path = roundedMaskPath.cgPath

        self.layer.insertSublayer(roundedShapeLayer, at: 0)
    }
}

extension UIImageView {
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}


extension UIButton {
    @discardableResult
    func addBorders(edges: UIRectEdge, color: UIColor, inset: CGFloat = 0.0, thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap { NSLayoutConstraint.constraints(withVisualFormat: $0, options: [], metrics: ["inset": inset, "thickness": thickness], views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
    
}


extension UIViewController {
    
    var sideMenuControllerInstance: SideMenuController? {
        return sideMenuControllerForViewController(self)
    }
    
    fileprivate func sideMenuControllerForViewController(_ controller : UIViewController) -> SideMenuController? {
        if let sideController = controller as? SideMenuController {
            return sideController
        }
        if let parent = controller.parent {
            return sideMenuControllerForViewController(parent)
        } else {
            return nil
        }
    }
}
