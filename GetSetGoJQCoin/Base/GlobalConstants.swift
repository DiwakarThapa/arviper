//
//  GlobalConstants.swift
//  Sipradi
//
//  Created by bibek timalsina on 6/10/17.
//  Copyright © 2017 Ekbana. All rights reserved.
//


import UIKit
// MARK: Constants
import Localize_Swift
struct GlobalConstants {
    
    struct UserDefaultKeys {
        static let userLastAttendedEmail: String = "USER_LAST_ATTENDED_EMAIL"
        static let appInfo: String = "APP_INFO_DATA"
        static let systemType: String = "systemType"
    }
    
    struct AppColor {
        static let primaryColor = UIColor.init(hex: "#FFB521")
        static let secondaryColor = UIColor.init(hex: "#1479FB")
    }
    
    struct WalkthroughColor {
        static let topColor = UIColor.init(hex: "#1479FB")
        static let bottomColor = UIColor.init(hex: "#E5F0FF")
    }
    
    struct WebUrl {
        static let faq:String = "https://eka.ekbana.info/privacy.html"
        static let aboutUs:String = "https://eka.ekbana.info/privacy.html"
        static let disclaimer:String = "https://projects.ekbana.info/getsetgoseed/disclaimer.php"
        static let privacyPolicy:String = "https://projects.ekbana.info/getsetgoseed/privacypolicy.php"
        static let signuUp:String = "https://qa.jqt01.com/register"
        static let forgotPassword:String = "https://qa.jqt01.com"
        static let termsAndCondition:String = "https://projects.ekbana.info/getsetgoseed/termsandconditions.php"
    }
    
    struct DateFormats {
        static let couponsDateFormat:String = "dd MMM yyyy"
    }
    
    struct FcmParam {
        static let token = "geeUtnQv9Sdn61R8InNJcoGET47t8Gh9"
        static let topic = "jqnavi"
        static let deviceID = NSUUID().uuidString
    }
    
    struct Localization {
        
        static var expiringSoon:String{return "expiringSoon".localized()}
        static var achievement:String{return "achievement".localized()}
        static var back:String{return "back".localized()}
        static var help:String{return "help".localized()}
        static var email:String{return "email".localized()}
        static var password:String{return "password".localized()}
        
        static var active:String{return "active".localized()}
        static var expire:String{return "expire".localized()}

        static var sessionAlert:String{return "alert_session_expired".localized()}
        static var internetConnectionAlert:String{return "alert_internet_connection".localized()}
        static var unsupportedArAlert:String{return "alert_unsupported_ar".localized()}
        static var userAndEmailEmptyAlert:String{return "alert_user_email_empty".localized()}
        static var passwordEmptyAlert:String{return "alert_password_empty".localized()}
        static var serverError:String{return "alert_opps".localized()}
        
        static var expiredOn:String{return "expiredOn".localized()}
        static var english:String{return "english".localized()}
        static var japanese:String{return "japanese".localized()}
        static var redeemedCouponOnStore:String{return "redeemCouponOnStore".localized()}
        static var haveClaimedIt:String{return "haveClaimedIt".localized()}
        static var getHunting:String{return "getHunting".localized()}
        static var viewAll:String{return "viewAll".localized()}
        static var hunt:String{return "hunt".localized()}
        static var startHunt:String{return "startHunt".localized()}
        static var dashboard:String{return "dashboard".localized()}
        static var loginTitle:String{return "login_title".localized()}
        static var forgotButton:String{return "forgot_button".localized()}
        static var doYouHaveAnAccount:String{return "doYouHaveAnAccount".localized()}
        static var signUp:String{return "signup".localized()}
        static var more:String{return "more".localized()}
        static var chooseLanguage:String{return "chooseLanguage".localized()}
        static var alert:String{return "alert".localized()}
        static var language:String{return "language".localized()}
        static var disclaimer:String{return "disclaimer".localized()}
        static var termsAndCondition:String{return "terms_and_conditions".localized()}
        static var privacyPolicy:String{return "privacy_policy".localized()}
        static var logout:String{return "logout".localized()}
        static var logoutAlert:String{return "alert_logout_message".localized()}
        static var cancel:String{return "cancel".localized()}
        static var myCoupons:String{return "my_coupons".localized()}
        static var redeemedOn:String{return  "redeemed_on".localized()}
        static var expired:String{return "expired".localized()}
        static var claimedOn:String{return  "claimed_on".localized()}
        static var redeemed:String{return "redeemed".localized()}
        static var claimed:String{return  "claimed".localized()}
        static var couponDetails:String{return  "coupon_details".localized()}
        static var redeemAlerMessage:String{return "redeem_alert_message".localized()}
        static var redeemCoupon:String{return "reedem_coupon".localized()}
        static var ok:String{return "ok".localized()}
        static var couponCode:String{return "coupon_code".localized()}
        static var thereAre:String{return  "there_are".localized()}
        static var activeCouponExpireAlert:String{return "active_coupons_that_will_expire_soon".localized()}
        static var nearByCoupons:String{return "nearby_coupons".localized()}
        static var validCouponsLeft:String{return "valid_coupons_left".localized()}
        static var viewAllActiveCoupons:String{return "view_all_active_coupons".localized()}
        static var notifications:String{return "notifications".localized()}
        
        static var day:String{return "day".localized()}
        static var days:String{return "days".localized()}
        
        static var ago:String{return "ago".localized()}
        
        static var minute:String{return "miture".localized()}
        static var minutes:String{return "minutes".localized()}
        
        static var hours:String{return "hours".localized()}
         static var hour:String{return "hour".localized()}
        
        static var month:String{return "month".localized()}
        static var months:String{return "months".localized()}
        
        static var year:String{return "year".localized()}
        static var years:String{return "years".localized()}
        
        static var second:String{return "second".localized()}
        static var seconds:String{return "seconds".localized()}
        static var moment:String{return "moment".localized()}
     
        static var viewTheDetails:String{return "view_the_details".localized()}
        static var all:String{return "all".localized()}
        static var expiringFirst:String{return "expiring_first".localized()}
        static var findCouponIntheWorld:String{return "find_coupons_in_the-world!".localized()}
        static var onboardingFirst:String{return "onboardding_first".localized()}
        static var onboardingSecond:String{return "onboardding_second".localized()}
        static var onboardingThird:String{return  "onboardding_third".localized()}
        static var onboardingFourth:String{return  "onboardding_forth".localized()}
        static var skip:String{return "skip".localized()}
        static var next:String{return "next".localized()}
        static var getStarted:String{return "get_started".localized()}

    }
    
    
    struct Errors {
        static let internetConnectionOffline = NSError.init(domain: "No_internet", code: 1234, userInfo: [NSLocalizedDescriptionKey: GlobalConstants.Localization.internetConnectionAlert])
        static let unAuthorized = NSError.init(domain: "unAuthorized", code: 133, userInfo: [NSLocalizedDescriptionKey: GlobalConstants.Localization.sessionAlert])
        static let oops = NSError.init(domain: "oops", code: 1235, userInfo: [NSLocalizedDescriptionKey: GlobalConstants.Localization.serverError])
    }
    
}

extension Notification.Name {
    static let didHandelAuthToken = Notification.Name("didHandelAuthToken")
     static let didHandelAppLanguage = Notification.Name("didHandelAppLanguage")

}
