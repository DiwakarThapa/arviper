//
//  DashboardWireframe.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class DashboardWireframe {
    weak var view: UIViewController!
    lazy var arView: ARWireframeInput = {ARWireframe()}()
    lazy var myCouponsWireframe: MyCouponsWireframeInput = {MyCouponsWireframe()}()
    lazy var moreWireframe:MoreWireframeInput = {MoreWireframe()} ()
    lazy var mapWireframe:HomePageWireframeInput = {HomePageWireframe()} ()
    lazy var couponDetailsWireframe:CouponDetailsWireframeInput = {CouponDetailsWireframe()}()
    lazy var notificationWireframe:NotificationWireframeInput = {NotificationWireframe()}()
}

extension DashboardWireframe: DashboardWireframeInput {
    
    
    
    var storyboardName: String {return "Dashboard"}
    
    func getMainView() -> UIViewController {
        let service = DashboardService()
        let interactor = DashboardInteractor(service: service)
        let presenter = DashboardPresenter()
        let viewController = viewControllerFromStoryboard(of: DashboardViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
    
    func gotoMyCoupons() {
        let myCouponVc = myCouponsWireframe.getMainView()
        self.view.navigationController?.pushViewController(myCouponVc, animated: true)
    }
    
    func viewClaimedCoupons() {
        myCouponsWireframe.myCouponsSort(claimedOnly:true)
        let myCouponVc = myCouponsWireframe.getMainView()
        self.view.navigationController?.pushViewController(myCouponVc, animated: true)
    }
    
    
    func gotoArView() {
        let arVc = UINavigationController(rootViewController: arView.getMainView())
        self.view.present(arVc, animated: true, completion: nil)
    }
    
    func gotoMore() {
        let moreVc = moreWireframe.getMainView()
        self.view.navigationController?.pushViewController(moreVc, animated: true)
    }
    
    func gotoMapView() {
//        UIView.animate(withDuration: 0.2) {
          self.view.present(self.mapWireframe.getMainView(), animated: true, completion: nil)
//        }
//        let mapView = mapWireframe.getMainView()
//        self.view.navigationController?.pushViewController(mapView, animated: true)
    }
    
    func gotoCouponsDetails(id: String) {
        self.couponDetailsWireframe.gotoCouponDetails(id: id, from: "Dashboard")
        self.view.navigationController?.pushViewController(couponDetailsWireframe.getMainView(), animated: true)
    }
    
    func gotoNotification() {
        let vc = notificationWireframe.getMainView()
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
    
}
