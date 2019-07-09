//
//  DashboardModuleInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//
import Foundation

protocol DashboardModuleInterface: class {
    func getMycoupons(showLoading:Bool)
    func getMycouponFromRealm()
    func getNearestCoupons(showLoading:Bool,currentLocation:LocationStructure)
    func didTapMore()
    func didTapOnMap()
    func didTapOnArButton()
    func didTapOnCoupon(id:String)
    func didTapOnViewAll()
    func didTapMyCoupons()
    func didTapNotification()
    func checkCurrentNotification()
}

