//
//  HomePageViewInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol HomePageViewInterface: class {
    func sucess()
    func error(_ error:Error)
    func showLoading()
    func hideLoading()
    func coupons(model: [HomePageCouponViewModel])
    
}
