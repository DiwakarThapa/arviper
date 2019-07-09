//
//  Router.swift
//  GetSetGo
//
//  Created by Namasang Yonzan on 28/03/18.
//  Copyright © 2018 Namasang Yonzan. All rights reserved.
//

import Foundation
import UIKit

struct StoryboardNames {
    static let webViewPage  = "WebviewPage"
    static let arViewPage = "AR"
    static let walkthrough = "Onboarding"
    static let login = "Login"
}

class Router {
    
    static let shared = Router()
    
    func getWalkThrough() -> WalkthroughViewController {
        return UIStoryboard.init(name: StoryboardNames.walkthrough, bundle: nil).instantiateViewController(withIdentifier: "WalkthroughViewController") as! WalkthroughViewController
    }
    
//    func getLoginPage() -> LoginViewController {
//        return UIStoryboard.init(name: StoryboardNames.login, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//    }
    
    func getWebviewPage() -> WebViewPageViewController {
        return UIStoryboard.init(name: StoryboardNames.webViewPage, bundle: nil).instantiateViewController(withIdentifier: "WebViewPageViewController") as! WebViewPageViewController
    }
    
    func getARViewController() -> ARViewController {
        return UIStoryboard.init(name: StoryboardNames.arViewPage, bundle: nil).instantiateViewController(withIdentifier: "ARViewController") as! ARViewController
    }
    
    func getARViewController() -> WalkthroughViewController {
        return UIStoryboard.init(name: StoryboardNames.walkthrough, bundle: nil).instantiateViewController(withIdentifier: "WalkthroughViewController") as! WalkthroughViewController
    }
    
}
