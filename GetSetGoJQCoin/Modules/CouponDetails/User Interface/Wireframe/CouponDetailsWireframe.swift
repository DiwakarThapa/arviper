//
//  CouponDetailsWireframe.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class CouponDetailsWireframe {
     weak var view: UIViewController!
     var couponId:String?
    var from:String?
}

extension CouponDetailsWireframe: CouponDetailsWireframeInput {
    
    
    
    
    var storyboardName: String {return "CouponDetails"}
    
    func getMainView() -> UIViewController {
        let service = CouponDetailsService()
        let interactor = CouponDetailsInteractor(service: service)
        interactor.couponId = self.couponId
        let presenter = CouponDetailsPresenter()
        let viewController = viewControllerFromStoryboard(of: CouponDetailsViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
    
    func gotoCouponDetails(id: String, from:String) {
        self.couponId = id
        self.from = from
    }
    
    func openSuccessPopUp(message: String) {
        let popup = RedeemSuccessPopup()
        popup.setup()
        popup.lblSuccess.text = message
        popup.present()
        popup.didClickOk = {
            popup.dissmiss()
            if self.from == "AR"{
                self.from = nil
                let vc = self.view.presentingViewController
                self.view.dismiss(animated: true, completion: {
                    vc?.dismiss(animated: true, completion: nil)
                    })
//                vc?.dismiss(animated: true, completion: {
//                    self.view.dismiss(animated: true, completion: nil)
//                })
                
//            self.view.dismissModalStack(animated: true, completion: nil)
            }
            else{
            self.view.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
