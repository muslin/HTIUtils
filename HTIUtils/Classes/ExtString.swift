//
//  ExtString.swift
//  Hytexts_Swift
//
//  Created by Muslin on 28/9/2561 BE.
//  Copyright © 2561 Patana Pilukeruedej. All rights reserved.
//

import UIKit
import CryptoSwift

//public class ExtString {
//    let greet = "Hello"
//    public init() {}
//
//    public func hello(to whom: String) -> String {
//        return "\(greet) \(whom)"
//    }
//
//    public func hexString(color: CGColor) -> String {
//        let components: [Int] = {
//            let c = color.components!
//            let components = c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
//            return components.map { Int($0 * 255.0) }
//        }()
//        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
//    }
//}
public extension UIColor {
    
    /// SwifterSwift: https://github.com/SwifterSwift/SwifterSwift
    /// Hexadecimal value string (read-only).
    var hexString: String {
        let components: [Int] = {
            let c = cgColor.components!
            let components = c.count == 4 ? c : [c[0], c[0], c[0], c[1]]
            return components.map { Int($0 * 255.0) }
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
}

public extension String {
    static var deviceUUID = UIDevice.current.identifierForVendor!.uuidString
    static var deviceModel = UIDevice.current.localizedModel
    static var deviceName = UIDevice.current.name
    static var deviceIdiom = UIDevice.current.userInterfaceIdiom
    static var modelName = UIDevice.current.modelName

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

    var data:          Data  { return Data(utf8) }
    var base64Encoded: Data  { return data.base64EncodedData() }
    var base64Decoded: Data? { return Data(base64Encoded: self) }

    func aesEncrypt(key: String, iv: String) throws -> String {
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: key.bytes, blockMode: CTR(iv: iv.bytes), padding: .pkcs7).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }

    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self)!
        let decrypted = try! AES(key: key.bytes, blockMode: CTR(iv: iv.bytes), padding: .pkcs7).decrypt([UInt8](data))
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? ""
    }
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        if let message = String(data: data!, encoding: .nonLossyASCII){
            return message
        }
        return ""
    }

    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8)
        return text!
    }

    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }

    /*
     func toJSON(): Any? {
     guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
     return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
     }*/
    static var timestamp: String = String(Int64(Date().timeIntervalSince1970))

    func uppercaseFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)
    }
    func validEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func validMobile() -> Bool {
        let numberRegEx = "[0]{1}+[0-9-]{9}"
        let numberTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return numberTest.evaluate(with: self)
    }
    func setMobileFormat() -> String {
        let components = self.components(separatedBy: "-")
        return components.joined(separator: "")
    }

    func substring(start: Int, end: Int) -> String
    {
        if (start < 0 || start > self.lengthOfBytes(using: String.Encoding.utf8))
        {
            debugPrint("start index \(start) out of bounds")
            return ""
        }
        else if end < 0 || end > self.lengthOfBytes(using: String.Encoding.utf8)
        {
            debugPrint("end index \(end) out of bounds")
            return ""
        }
        let startIndex = self.utf8.index(self.startIndex, offsetBy: start)
        let endIndex = self.utf8.index(self.startIndex, offsetBy: end)
        let range = startIndex..<endIndex

        return String(self[range]) // substring(with: range) // swift 3
    }

    func substring(start: Int, location: Int) -> String
    {
        if (start < 0 || start > self.lengthOfBytes(using: String.Encoding.utf8))
        {
            debugPrint("start index \(start) out of bounds")
            return ""
        }
        else if location < 0 || start + location > self.lengthOfBytes(using: String.Encoding.utf8)
        {
            debugPrint("end index \(start + location) out of bounds")
            return ""
        }
        let startIndex = self.utf8.index(self.startIndex, offsetBy: start)
        let endIndex = self.utf8.index(self.startIndex, offsetBy: start + location)
        let range = startIndex..<endIndex

        return  String(self[range]) // substring(with: range) // swift 3
    }

    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }

    func attributedText(font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [NSAttributedString.Key.font: font])
        return attributedString
    }
}


public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        var identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        if identifier == "i386" || identifier == "x86_64" {
            identifier = self.modelIdentifier()
        }
        //debugPrint("identifier ---- ",identifier)
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
}
