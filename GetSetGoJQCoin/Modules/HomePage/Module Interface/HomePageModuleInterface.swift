//
//  HomePageModuleInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol HomePageModuleInterface: class {

    func openAR()
    func openNormalCamera()
    func callCouponListApi(location:LocationStructure)
    func didTapMyCoupon()
    func didTapMore()
}
