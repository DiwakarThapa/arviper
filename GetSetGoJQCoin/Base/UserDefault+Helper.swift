//
//  UserDefault+Helper.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//  Copyright © 2562 ekbana. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setIsLoggedIn(value:Bool) {
     set(value, forKey: "LOGINSTATUS")
     synchronize()
    }

    func isLoggedIn() -> Bool{
        return bool(forKey: "LOGINSTATUS")
    }
    
    func setWalkthrough(value:Bool){
        set(value, forKey: "WALKTHROUGH")
    }
    
    func isWalkThrough() -> Bool{
         return bool(forKey: "WALKTHROUGH")
    }
    
    
    func setNotificationPage(page:String) {
        set(page, forKey: "NOTIFICATIONPAGENO")
        synchronize()
    }
    
    func getNotificationPage() -> String {
        return string(forKey: "NOTIFICATIONPAGENO") ?? ""
    }
    
    func setNotificationList(count:Int) {
        set(count, forKey: "NOTIFICATIONLISTCOUNT")
        synchronize()
    }
    
    func getNotificationListCount() -> Int {
        return integer(forKey: "NOTIFICATIONLISTCOUNT")
    }
    
    func setDefaultNotificationDate(date:String) {
        set(date, forKey: "SetDefaultNotification")
        synchronize()
    }
    
    func getDefaultNotificationDate() -> String {
        return string(forKey: "SetDefaultNotification") ?? ""
    }
    
    
    func setDefaultLanguage(language:String) {
        set(language, forKey: "SetDefaultLanguage")
        synchronize()
    }
    
    func getDefaultLanguage() -> String {
        return string(forKey: "SetDefaultLanguage") ?? ""
    }
    
    func setProfileUrl(image:String) {
        set(image, forKey: "SetPfofileUrl")
        synchronize()
    }
    
    func getProfileUrl() -> String {
        return string(forKey: "SetPfofileUrl") ?? ""
    }
    
    
}
