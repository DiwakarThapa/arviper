//
//  Utilities.swift
//  Sipradi
//
//  Created by bibek timalsina on 5/26/17.
//  Copyright © 2017 Ekbana. All rights reserved.
//

import Foundation

var loggerEnabled: Bool = true

func logger(_ items: Any...) {
    if loggerEnabled {
        print(items)
    }
}


struct AppUtility {
    
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
//
//        if let delegate = UIApplication.shared.delegate as? AppDelegate {
//            delegate.orientationLock = orientation
//        }
//    }
//
//    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
//
//        self.lockOrientation(orientation)
//
//        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
//    }
    
}
