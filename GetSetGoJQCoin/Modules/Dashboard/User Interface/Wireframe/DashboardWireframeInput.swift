//
//  DashboardWireframeInput.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol DashboardWireframeInput: WireframeInput {
    func gotoMyCoupons()
    func gotoArView()
    func gotoMore()
    func gotoMapView()
    func gotoCouponsDetails(id:String)
    func gotoNotification()
    func viewClaimedCoupons()
}
