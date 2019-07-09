//
//  CouponDetailsWireframeInput.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol CouponDetailsWireframeInput: WireframeInput {
    func gotoCouponDetails(id:String, from:String)
    func openSuccessPopUp(message:String)
}
