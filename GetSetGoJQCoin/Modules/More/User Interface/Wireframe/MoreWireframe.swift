//
//  MoreWireframe.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class MoreWireframe {
     weak var view: UIViewController!
    lazy var login: LoginPageWireframeInput =  { LoginPageWireframe()}()
    lazy var myCouponWireframe: MyCouponsWireframeInput =  { MyCouponsWireframe()}()
}

extension MoreWireframe: MoreWireframeInput {
   
    
    
    var storyboardName: String {return "More"}
    
    func getMainView() -> UIViewController {
        let service = MoreService()
        let interactor = MoreInteractor(service: service)
        let presenter = MorePresenter()
        let viewController = viewControllerFromStoryboard(of: MoreViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
    
    func openWebViewWith(title: String, url: String) {
        let webView = Router.shared.getWebviewPage()
        webView.titleText =  title
        webView.webUrl = url
        self.view.present(webView, animated: true, completion: nil)
    }
    
    func goToLogin() {
        let vc = UINavigationController(rootViewController: login.getMainView())
        self.view.present(vc, animated: true, completion: nil)
    }
    
    func goToMyCoupons() {
        let myCouponsVc = myCouponWireframe.getMainView()
        self.view.navigationController?.pushViewController(myCouponsVc, animated: true)
    }
    
    func openOnboardingPage() {
        let onboardingVc = Router.shared.getWalkThrough()
        onboardingVc.defaultOpeningSatus = .fromMore
        self.view.present(onboardingVc, animated: true, completion: nil)
    }
    
}
