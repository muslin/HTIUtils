//
//  ExtString.swift
//  HTIUtils
//
//  Created by Muslin on 4/3/2563 BE.
//

import Foundation

extension String {
    
    static var deviceUUID = UIDevice.current.identifierForVendor!.uuidString
    static var deviceModel = UIDevice.current.localizedModel
    static var deviceName = UIDevice.current.name
    static var deviceIdiom = UIDevice.current.userInterfaceIdiom
//    static var modelName = UIDevice.current.modelName

}
