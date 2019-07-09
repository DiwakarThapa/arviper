//
//  MyCouponsViewInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol MyCouponsViewInterface: class {
    func showLoading()
    func hideLoading()
    func success(coupons:[MyCouponsViewModel])
    func error(message:Error)
}
