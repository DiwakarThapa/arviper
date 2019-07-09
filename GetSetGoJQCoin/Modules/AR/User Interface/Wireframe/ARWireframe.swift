//
//  ARWireframe.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class ARWireframe {
     weak var view: UIViewController!
        var cameraViewType:Bool?
     lazy var couponDetailsWireframe:CouponDetailsWireframeInput = {CouponDetailsWireframe()}()
}

extension ARWireframe: ARWireframeInput {
    
    var storyboardName: String {return "AR"}
    
    func getMainView() -> UIViewController {
        let service = ARService()
        let interactor = ARInteractor(service: service)
        let presenter = ARPresenter()
        let viewController = viewControllerFromStoryboard(of: ARViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
    
    func couponDetails(id: String) {
        self.couponDetailsWireframe.gotoCouponDetails(id: id,  from:"AR")
        let couponDetailsVc = UINavigationController(rootViewController: couponDetailsWireframe.getMainView())
        self.view.present(couponDetailsVc, animated: true) {
            self.couponDetailsWireframe.view.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close11"), style: .plain, target: self, action: #selector(self.didTapClose))
        }
    }
    
    @objc func didTapClose() {
//        self.view.dismissModalStack(animated: true, completion: nil)
        self.view.presentingViewController?.dismiss(animated: true, completion: nil)
    }
   
}
