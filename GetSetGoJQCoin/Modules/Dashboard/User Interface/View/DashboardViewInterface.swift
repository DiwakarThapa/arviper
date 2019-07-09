//
//  DashboardViewInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol DashboardViewInterface: class {
    func showLoading()
    func hideLoading()
    func showError(error:Error)
    func success()
    func success(myCoupons:[DashboardMycouponsViewModel])
    func success(coupons:[DashboardCouponsViewModel])
    func notification(status:Bool)
    
}
