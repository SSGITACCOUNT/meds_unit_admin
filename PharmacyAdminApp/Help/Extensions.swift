//
//  Extensions.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-02-01.
//

import UIKit
import FirebaseFirestore

public extension UIViewController {
    //    var sideMenuControllerInstance: SideMenuController? {
    //        return sideMenuControllerForViewController(self)
    //    }
    //
    //    fileprivate func sideMenuControllerForViewController(_ controller : UIViewController) -> SideMenuController?{
    //        if let sideController = controller as? SideMenuController {
    //            return sideController
    //        }
    //        if let parent = controller.parent {
    //            return sideMenuControllerForViewController(parent)
    //        } else {
    //            return nil
    //        }
    //    }
    
}

public extension String {
    func trimLeadingTralingNewlineWhiteSpaces() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func removingAllWhitespaces() -> String {
        return removingCharacters(from: .whitespaces)
    }
    
    func removingCharacters(from set: CharacterSet) -> String {
        var newString = self
        newString.removeAll { char -> Bool in
            guard let scalar = char.unicodeScalars.first else { return false }
            return set.contains(scalar)
        }
        return newString
    }
    
    var queryParams: [String:String] {
        get {
            guard let url = URL(string: self) else { return [:] }
            return url.queryParams
        }
    }
    
    var urlPath: String {
        get {
            guard let url = URL(string: self) else { return "" }
            return url.urlPath
        }
    }
    
    func fullPhoneNumber(DialCode code: String?) -> String {
        let phone = (code ?? "") + self.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
        return phone
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func isValidEmailAddress() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: self) {
            return true
        }
        return false
    }
    
    func isAValidPhoneNumber() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidSLPhoneNumber() -> Bool {
        return self.count==10
    }
}

extension UIView {
    func addGradient(colors: [UIColor]) {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.locations = [ 0.0, 1.0]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addShadow(offSet: CGFloat = 2.0, color: UIColor = .lightGray) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offSet, height: offSet)
        self.layer.shadowOpacity = 0.5
        self.layer.shouldRasterize = false
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
    }
}

extension Double {
    var timeFormatter: String {
        get {
            let (h,m,s) = secondsToHoursMinutesSeconds()
            return "\(String(format: "%02d", h)):\(String(format: "%02d", m)):\(String(format: "%02d", s))"
        }
    }
    
    var timeFormatterWithLable: String {
        get {
            let (h,m,s) = secondsToHoursMinutesSeconds()
            var lableText = "\(s) sec"
            if m != 0 { lableText = "\(m) min \(lableText)" }
            if h != 0 { lableText = "\(h) hours \(lableText)" }
            return lableText
        }
    }
    
    var feeFormatter: String {
        get {
            let _value = Double(Int(100 * self)) / 100
            return String(format: "%.2f", _value)
        }
    }
    
    var feeFormatterWithCurrency: String {
        get {
            return "LKR \(self.feeFormatter)"
        }
    }
    
    var distanceKMFormatter: String {
        get {
            let _value = metersToKilometers
            return String(format: "%.1f", _value)
        }
    }
    
    var secondsToMinute: Double {
        get {
            return self / 60
        }
    }
    
    var metersToKilometers: Double {
        get {
            return Double(Int(self)) / 1000
        }
    }
    
    func secondsToHoursMinutesSeconds () -> (Int, Int, Int) {
        let seconds = Int(self)
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
extension URL {
    var queryParams: [String:String] {
        get {
            let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems
            let queryTuples: [(String, String)] = queryItems?.compactMap{
                guard let value = $0.value else { return nil }
                return ($0.name, value)
            } ?? []
            return Dictionary(uniqueKeysWithValues: queryTuples)
        }
    }
    
    var urlPath: String {
        get {
            return URLComponents(url: self, resolvingAgainstBaseURL: false)?.path ?? ""
        }
    }
}

extension UIButton {
    func underline() {
        guard let title = self.titleLabel else { return }
        guard let tittleText = title.text else { return }
        let attributedString = NSMutableAttributedString(string: (tittleText))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (tittleText.count)))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}

extension Encodable {
    func toJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(self)
            
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any]
        }
    }
}


private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
              prospectiveText.count > maxLength
        else {
            return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}

extension Decodable {
    /// Initialize from JSON Dictionary. Return nil on failure
    init?(dictionary value: [String:Any?]){
        
        guard JSONSerialization.isValidJSONObject(value) else { return nil }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) else { return nil }
        
        guard let newValue = try? JSONDecoder().decode(Self.self, from: jsonData) else { return nil }
        self = newValue
    }
}


/*
 * Copyright 2018 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import FirebaseFirestore

/**
 * A protocol describing the encodable properties of a GeoPoint.
 *
 * Note: this protocol exists as a workaround for the Swift compiler: if the GeoPoint class
 * was extended directly to conform to Codable, the methods implementing the protocol would be need
 * to be marked required but that can't be done in an extension. Declaring the extension on the
 * protocol sidesteps this issue.
 */
private protocol CodableGeoPoint: Codable {
    var latitude: Double { get }
    var longitude: Double { get }
    
    init(latitude: Double, longitude: Double)
}

/** The keys in a GeoPoint. Must match the properties of CodableGeoPoint. */
private enum GeoPointKeys: String, CodingKey {
    case Latitude
    case Longitude
}

/**
 * An extension of GeoPoint that implements the behavior of the Codable protocol.
 *
 * Note: this is implemented manually here because the Swift compiler can't synthesize these methods
 * when declaring an extension to conform to Codable.
 */
extension CodableGeoPoint {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GeoPointKeys.self)
        let latitude = try container.decode(Double.self, forKey: .Latitude)
        let longitude = try container.decode(Double.self, forKey: .Longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GeoPointKeys.self)
        try container.encode(latitude, forKey: .Latitude)
        try container.encode(longitude, forKey: .Longitude)
    }
}

/** Extends GeoPoint to conform to Codable. */
extension GeoPoint: CodableGeoPoint {}


extension NSData{
    
    var imageFormat: ImageFormat{
        var buffer = [UInt8](repeating: 0, count: 1)
        self.getBytes(&buffer, range: NSRange(location: 0,length: 1))
        if buffer == ImageHeaderData.PNG {
            return .PNG
        } else if buffer == ImageHeaderData.JPEG {
            return .JPEG
        } else if buffer == ImageHeaderData.GIF {
            return .GIF
        } else if buffer == ImageHeaderData.TIFF_01 || buffer == ImageHeaderData.TIFF_02 {
            return .TIFF
        } else{
            return .Unknown
        }
    }
}

enum ImageFormat: String {
    case Unknown = ""
    case PNG = "png"
    case JPEG = "jpeg"
    case GIF = "gif"
    case TIFF = "tiff"
}

struct ImageHeaderData {
    static var PNG: [UInt8] = [0x89]
    static var JPEG: [UInt8] = [0xFF]
    static var GIF: [UInt8] = [0x47]
    static var TIFF_01: [UInt8] = [0x49]
    static var TIFF_02: [UInt8] = [0x4D]
}
