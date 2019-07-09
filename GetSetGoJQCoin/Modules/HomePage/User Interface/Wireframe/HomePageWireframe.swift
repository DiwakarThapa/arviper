//
//  HomePageWireframe.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class HomePageWireframe {
     weak var view: UIViewController!
    lazy var login: LoginPageWireframeInput =  { LoginPageWireframe()}()
    lazy var arView: ARWireframeInput = {ARWireframe()}()
    lazy var myCouponsWireframe: MyCouponsWireframeInput = {MyCouponsWireframe()}()
    lazy var moreWireframe:MoreWireframeInput = {MoreWireframe()} ()
    
}

extension HomePageWireframe: HomePageWireframeInput {
   
   
  
    var storyboardName: String {return "HomePage"}
    
    func getMainView() -> UIViewController {
        let service = HomePageService()
        let interactor = HomePageInteractor(service: service)
        let presenter = HomePagePresenter()
        let viewController = viewControllerFromStoryboard(of: HomePageViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
    
    func gotoLogin() {
        let vc = UINavigationController(rootViewController: login.getMainView())
        self.view.present(vc, animated: true, completion: nil)
    }
    
    func gotoAr() {
        let arVc = UINavigationController(rootViewController: arView.getMainView())
        self.view.present(arVc, animated: true, completion: nil)
    }
    
    func openNormalCamera() {
     //   self.view.present(normalCamerWireframe.getMainView(), animated: true, completion: nil)
    }
    
    func openMyCoupons() {
        let myCouponVc = myCouponsWireframe.getMainView()
        self.view.navigationController?.pushViewController(myCouponVc, animated: true)
    }
    
    func openMore() {
        let moreVc = moreWireframe.getMainView()
        self.view.navigationController?.pushViewController(moreVc, animated: true)
    }
    
    
}
