//
//  MyCouponsWireframeInput.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol MyCouponsWireframeInput: WireframeInput {
    func myCouponsSort(claimedOnly: Bool)
    func goToCouponDetails(id:String)
}
