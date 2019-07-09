//
//  HomePageInteractorIO.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol HomePageInteractorInput: class {
    func couponListingApi(location:LocationStructure)
}

protocol HomePageInteractorOutput: class {
    
    func obtained(model: [HomePageCouponStructure])
    func obtained()
    func obtained(error:Error)
    
}
