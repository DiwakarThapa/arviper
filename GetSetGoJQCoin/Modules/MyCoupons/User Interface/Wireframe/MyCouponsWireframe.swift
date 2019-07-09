//
//  MyCouponsWireframe.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class MyCouponsWireframe {
    weak var view: UIViewController!
    var claimedOnly:Bool?
    lazy var couponDetailsWireframe:CouponDetailsWireframeInput = {CouponDetailsWireframe()}()
    
}


extension MyCouponsWireframe: MyCouponsWireframeInput {

    var storyboardName: String {return "MyCoupons"}
    
    func getMainView() -> UIViewController {
        let service = MyCouponsService()
        let interactor = MyCouponsInteractor(service: service)
        interactor.claimedOnly = self.claimedOnly
        self.claimedOnly = false
        let presenter = MyCouponsPresenter()
        let viewController = viewControllerFromStoryboard(of: MyCouponsViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
    
    func myCouponsSort(claimedOnly: Bool) {
        self.claimedOnly = claimedOnly
    }
    
    func goToCouponDetails(id: String) {
        self.couponDetailsWireframe.gotoCouponDetails(id: id, from: "Mycoupon")
        self.view.navigationController?.pushViewController(couponDetailsWireframe.getMainView(), animated: true)
    }
}
