//
//  LoginPageWireframe.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//Copyright © 2562 ekbana. All rights reserved.
//

import UIKit

class LoginPageWireframe {
     weak var view: UIViewController!
     lazy var homeWireframe: HomePageWireframeInput =  { HomePageWireframe()}()
     lazy var dashBoardWireframe: DashboardWireframeInput =  { DashboardWireframe()}()
}

extension LoginPageWireframe: LoginPageWireframeInput {
   
    
    var storyboardName: String {return "LoginPage"}
    
    func getMainView() -> UIViewController {
        let service = LoginPageService()
        let interactor = LoginPageInteractor(service: service)
        let presenter = LoginPagePresenter()
        let viewController = viewControllerFromStoryboard(of: LoginPageViewController.self)
        interactor.view = viewController
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
    
    func gotoHomePage() {
         // self.openHome(wireframe: self.homeWireframe)
        let vc = UINavigationController(rootViewController: dashBoardWireframe.getMainView())
        self.view.present(vc, animated: true, completion: nil)
    }
    
//    private func openHome(wireframe: HomePageWireframeInput) {
//        if let presentingVc = self.view?.presentingViewController {
//            self.view.dismiss(animated: false, completion: {
//
//            })
//            presentingVc.present(wireframe.getMainView(), animated: false, completion: nil)
//        }else {
//            if let window = self.window {
//                wireframe.openMainViewIn(window: window)
//            }
//        }
//    }
    
}
