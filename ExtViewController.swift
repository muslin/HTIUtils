//
//  ExtViewController.swift
//  CryptoSwift
//
//  Created by Muslin on 4/3/2563 BE.
//

import UIKit

extension UIViewController {
    
    class func currentVC() -> UIViewController? {
    //var currentVC: UIViewController? {
        
        if(UIApplication.shared.keyWindow?.rootViewController?.isKind(of: UITabBarController.self))!{
            
            let tab:UITabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
            //debugPrint( tab.selectedViewController)
            return tab.selectedViewController!
        }
        else {
            
            guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return nil }
            return navigationController.viewControllers.last!
        }
    }

    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
}

extension UIApplication {
    class func topMostViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController()
    }
}

extension UICollectionView {
    func reloadDataComplete(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
    open override func awakeFromNib() {
        backgroundColor = .clear
    }
}
extension UICollectionViewCell {
    override open func awakeFromNib() {
        backgroundColor = .clear
    }
}
extension UITableView {
    func reloadDataComplete(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
    open override func awakeFromNib() {
        backgroundColor = .clear //UIColor.color_bg.withAlphaComponent(0.5) //.clear
        let darkmode = UserDefaults.standard.value(forKey: "darkmode") as! Bool
        if darkmode == true {
            separatorColor = UIColor.color_fg.withAlphaComponent(0.5)
        }
    }
}
extension UITableViewCell {
    override open func awakeFromNib() {
        backgroundColor = .clear
    }
}
extension UISwitch {
    open override func awakeFromNib() {
        onTintColor = UIColor.color_brand.withAlphaComponent(0.6)
        tintColor = UIColor.color_fg.withAlphaComponent(0.3)
    }
}

extension UITextField {
    open override func awakeFromNib() {
        textColor = UIColor.color_fg.withAlphaComponent(0.7)
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
}

extension UILabel {
    open override func awakeFromNib() {
        textColor = .color_fg
    }
}

extension UIToolbar {
    open override func awakeFromNib() {
    }
}
extension UIAlertController {
    
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.green
        
    }

    class func createAlert(title: String?, message: String? = nil) -> UIAlertController {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let popoverController = alertView.popoverPresentationController {
            let viewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        return alertView
    }
    class func createActionSheet(title: String?, message: String? = nil) -> UIAlertController {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        if let popoverController = alertView.popoverPresentationController {
            let viewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        return alertView
    }
}

extension UIAlertAction {
    class func createAction(title: String?, handle: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction
    {
        return UIAlertAction(title: title, style: .default, handler: { (alert) in
            let viewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            viewController.setNeedsStatusBarAppearanceUpdate()
            guard handle != nil else {
                return
            }
            handle!(alert)
        })
    }
    class func createCancel(handle: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction
    {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
            let viewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            viewController.setNeedsStatusBarAppearanceUpdate()
            guard handle != nil else {
                return
            }
            handle!(alert)
        })
    }
}
