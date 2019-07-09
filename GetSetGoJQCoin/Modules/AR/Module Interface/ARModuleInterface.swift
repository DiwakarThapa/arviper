//
//  ARModuleInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol ARModuleInterface: class {
    func fetchCoupon()
    func validateCoupon(id:String)
    func claimCoupon(id:String)
    func claimedCoupon(id:String)
}
