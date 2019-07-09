//
//  HomePageInteractor.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class HomePageInteractor {
    
	// MARK: Properties
    
    weak var output: HomePageInteractorOutput?
    private let service: HomePageServiceType
    
    // MARK: Initialization
    
    init(service: HomePageServiceType) {
        self.service = service
    }
    // MARK: Converting entities
    
    func convert(model:[CouponModel]){
        let coupons = model.map({
            return HomePageCouponStructure(
                title:$0.title,
                subtitle:$0.subtitle,
                logo:$0.logo,
                image:$0.image,
                color:$0.color,
                geoCoordinate:$0.geoCoordinate,
                startDate:$0.startDate, expiryDate:$0.expiryDate,
                status:$0.status, code:$0.code, id:$0.id
            )
        })
        self.output?.obtained(model: coupons)
    }
    
}

// MARK: HomePage interactor input interface

extension HomePageInteractor: HomePageInteractorInput {
   

    func couponListingApi(location: LocationStructure) {
        let coupons = self.service.fetchCupons()
        self.convert(model: coupons)
//        service.fetchCoupon(model: location, success: { data in
//            self.convert(model: data)
//        }) { (error) in
//            self.output?.obtained(error: error)
//        }
    }
    
   
    
    
}
