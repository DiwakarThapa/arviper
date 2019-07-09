//
//  AppDelegate.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import RealmSwift
import IQKeyboardManagerSwift
import Fabric
import Crashlytics
import Firebase
import FirebaseMessaging
import FBSDKCoreKit
import LineSDK
let deploymentMode: DeploymentMode = DeploymentMode.dev

var appDelegate: AppDelegate {
    return (UIApplication.shared.delegate as! AppDelegate)
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LogOutServiceType{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LoginManager.shared.setup(channelID: "1588850381", universalLinkURL: nil)
        Fabric.with([Crashlytics.self])
        FirebaseApp.configure()
        configureFCM()
        migrateRealm()
        checkUserStatus()
        setupNav()
        GMSServices.provideAPIKey("AIzaSyBSWneljjq050Pg8OtMx2OkI4xnBBuTZss")
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        IQKeyboardManager.shared.enable = true
        handelAuthTokenFailed()
        return true
      
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled: Bool = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])
        return  LoginManager.shared.application(app, open: url, options: options) || handled
    }
    
    
    private func migrateRealm() {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = 6
        config.migrationBlock = {_ , _   in }
        Realm.Configuration.defaultConfiguration = config
    }
    
//    private func migrateRealm() {
//        let config = Realm.Configuration(
//            schemaVersion: 2,
//            migrationBlock: { migration, schemaVersion in
//                if schemaVersion < 2 {
//                    //migration after change of JSON API
//                    migration.enumerateObjects(ofType: "AuthModel", { (oldObject, newObject) in
//                        newObject?["id"] = "\(oldObject?.value(forKey: "id") as? Int ?? 0)"
//                    })
//
//                    migration.enumerateObjects(ofType: "CouponRealmModel", { (old, new) in
//                        new?["id"] = "\(old?.value(forKey: "id") as? Int ?? 0)"
//                    })
//                }
//        })
//        Realm.Configuration.defaultConfiguration = config
//    }
    
    private func setupNav(){
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = GlobalConstants.AppColor.secondaryColor
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        if #available(iOS 11.0, *) {
            navBar.prefersLargeTitles = false
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    
    private func checkUserStatus(){
        
        if isLoggedIn(){
//            let homeWireframe = HomePageWireframe()
//            let mainVc = homeWireframe.getMainView()
             let mainVc = DashboardWireframe().getMainView()
            let vc = UINavigationController(rootViewController: mainVc)
            self.window?.rootViewController = vc
        }else{
            let loginVC = LoginPageWireframe().getMainView()
            let vc = UINavigationController(rootViewController: loginVC)
            self.window?.rootViewController = vc
//            checkWalkthrough()
        }


    }
    
    
    private func checkWalkthrough(){
        if isWalkthrough(){
            let homeWireframe = LoginPageWireframe()
            let mainVc = homeWireframe.getMainView()
            let vc = UINavigationController(rootViewController: mainVc)
            self.window?.rootViewController = vc
        }else {
            let walkThroughVC = Router.shared.getWalkThrough()
            walkThroughVC.defaultOpeningSatus = .firtTime
            let vc = UINavigationController(rootViewController: walkThroughVC)
            self.window?.rootViewController = vc
        }
    }
    
    
    fileprivate func isWalkthrough() -> Bool{
        return UserDefaults.standard.isWalkThrough()
    }
    
    fileprivate func isLoggedIn() -> Bool{
        return UserDefaults.standard.isLoggedIn()
    }
    
    
    // Refresh token failed handeling
    func handelAuthTokenFailed(){
        NotificationCenter.default.addObserver(self, selector: #selector(onDidHandelLogOut(_:)), name: Notification.Name.didHandelAuthToken, object:nil)
    }
    
    @objc func onDidHandelLogOut(_ notification: Notification){
        if let vc = UIApplication.topViewController() as? DashboardViewController {
            vc.alert(message: GlobalConstants.Errors.unAuthorized.localizedDescription, title: GlobalConstants.Localization.alert) {
                self.logout(success: {
                    UserDefaults.standard.setIsLoggedIn(value: false)
                    let loginWireFrame = LoginPageWireframe().getMainView()
                    let vc = UINavigationController(rootViewController: loginWireFrame)
                    self.window?.rootViewController = vc
                }, failure: { (error) in
                    print("Logout Error")
                })
            }
        }
    }
   
    func configureFCM() {
        let application = UIApplication.shared
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
    
    
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    
}

extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        FcmApiService().sendFcmData()
        print("Firebase registration token: \(fcmToken)")
        
    }
    
 
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    
}
