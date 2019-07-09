//
//  WireframeInput.swift
//  Sipradi
//
//  Created by bibek timalsina on 5/25/17.
//  Copyright © 2017 Ekbana. All rights reserved.
//

import UIKit

protocol WireframeInput {
    var window: UIWindow? {get}
    var view: UIViewController! {get}
    var storyboardName: String {get}
    func openMainView(source: UIViewController)
    func pushMainView(in source: UINavigationController)
    func getMainView() -> UIViewController
    func openMainViewIn(window: UIWindow)
    func openViewControllerWithNavigation(viewController: UIViewController, source: UIViewController)
}

extension WireframeInput {
    var window: UIWindow? {
        return (UIApplication.shared.delegate as! AppDelegate).window
    }
    
    func viewControllerFromStoryboard<T: UIViewController>(of type: T.Type) -> T {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    
    func openMainViewIn(window: UIWindow) {
        let view = self.getMainView()
        window.rootViewController = view
    }
    
    func openMainView(source: UIViewController) {
        let mainView = self.getMainView()
        source.present(mainView, animated: true, completion: nil)
    }
    
    func pushMainView(in source: UINavigationController) {
        let mainView = self.getMainView()
        source.pushViewController(mainView, animated: true)
    }
    
    func openViewControllerWithNavigation(viewController: UIViewController, source: UIViewController) {
        let nav = UINavigationController(rootViewController: viewController)
        source.present(nav, animated: true, completion: nil)
    }
    
}
