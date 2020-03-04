//
//  ExtColor.swift
//  CryptoSwift
//
//  Created by Muslin on 4/3/2563 BE.
//

import UIKit

public extension UIColor {
    
    static var color_text = UIColor(red: 59, green: 56, blue: 59)
    static var color_tabbar = UIColor(red: 190, green: 190, blue: 190).withAlphaComponent(0.05)
    static var color_brand = UIColor(red: 45, green: 192, blue: 213)
    static var color_button_disable = UIColor(red: 220, green: 220, blue: 220)
    static var color_brand_opa = UIColor(red: 134, green: 217, blue: 225)
    static var color_facebook = UIColor(red: 71, green: 89, blue: 147)
    static var color_gray = UIColor(red: 155, green: 155, blue: 155)
    static var color_gray100 = UIColor(red: 100, green: 100, blue: 100)
    static var color_pdf = UIColor(red: 208, green: 2, blue: 27)
    static var color_epub = UIColor(red: 133, green: 185, blue: 22)
    static var color_checkbox = UIColor(red: 0, green: 122, blue: 255)
    static var color_comment = UIColor(red: 234, green: 237, blue: 240)
    
    static var color_day_fg = UIColor(red: 80, green: 80, blue: 80)
    static var color_day_bg = UIColor.white
    static var color_sepia_fg = UIColor(red: 112, green: 66, blue: 20)
    static var color_sepia_bg = UIColor(red: 245, green: 245, blue: 220)
    static var color_blue_fg = UIColor(red: 200, green: 200, blue: 200)
    static var color_blue_bg = UIColor(red: 27, green: 40, blue: 54)
    static var color_night_fg = UIColor(red: 170, green: 170, blue: 170)
    static var color_night_bg = UIColor(red: 26, green: 26, blue: 26)
    
    static var color_bg: UIColor {
        return setColorTheme(light: .color_day_bg, dark: .color_night_bg)
    }
    static var color_fg: UIColor {
        return setColorTheme(light: .color_text, dark: UIColor(red: 200, green: 200, blue: 200))
    }
    static var color_bg_lighter: UIColor {
        return setColorTheme(light: UIColor(red: 240, green: 240, blue: 240), dark: UIColor(red: 40, green: 40, blue: 40))
    }
    static var color_fg_lighter: UIColor {
        return setColorTheme(light: UIColor(red: 155, green: 155, blue: 155), dark: UIColor(red: 130, green: 130, blue: 130))
    }
    static var color_disable: UIColor {
        return setColorTheme(light: UIColor(red: 200, green: 200, blue: 200), dark: UIColor(red: 55, green: 55, blue: 55))
    }
    static var color_error: UIColor {
        return setColorTheme(light: .red, dark: UIColor(red: 190, green: 0, blue: 0))
    }
    static var error: UIColor {
        return setColorTheme(light: UIColor(red: 255, green: 92, blue: 92).withAlphaComponent(0.5), dark: UIColor(red: 255, green: 0, blue: 0).withAlphaComponent(0.1))
    }
    static var bg_textfield: UIColor {
        if #available(iOS 13.0, *) {
            var darkmode = false
            if UserDefaults.standard.value(forKey: "darkmode") != nil {
                darkmode = UserDefaults.standard.value(forKey: "darkmode")! as! Bool
            }
            if UIApplication.topMostViewController()?.traitCollection.userInterfaceStyle == .dark {
                if darkmode == false {
                    return .color_bg_lighter
                }
            }
            else {
                if darkmode == true {
                    return .color_bg_lighter
                }
            }
            return .clear
        }
        return .clear
    }
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    class func setColorTheme(light: UIColor, dark: UIColor) -> UIColor {
        guard UserDefaults.standard.value(forKey: "darkmode") != nil else {
            UserDefaults.standard.set(false, forKey: "darkmode")
            return light
        }
        let darkmode = UserDefaults.standard.value(forKey: "darkmode") as! Bool
        if darkmode == true {
            return dark
        }
        return light
        
    }
}
