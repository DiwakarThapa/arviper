//
//  DashboardInteractor.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class DashboardInteractor {
    
	// MARK: Properties
    
    weak var output: DashboardInteractorOutput?
    private let service: DashboardServiceType
    
    // MARK: Initialization
    
    init(service: DashboardServiceType) {
        self.service = service
    }

    // MARK: Converting entities
    
    func convert(model:[MyCouponsData]){
        let convertedCoupons = model.map({
            return DashboardMyCouponsStructure(
                title:$0.title,
                subtitle:$0.subtitle,
                logo:$0.logo,
                image:$0.image,
                color:$0.color,
                geoCoordinate:$0.geoCoordinate,
                expiryDate:$0.expiryDate,
                status:$0.status,
                userId:$0.userId,
                id:$0.id,
                claimedDate:$0.claimedDate,
                code:$0.code,
                redeemedDate:$0.redeemedDate,
                storeName:$0.storeName
            )
        })
        self.output?.obtained(myCoupons: convertedCoupons)
    }
    
    func convert(model:[CouponModel]){
        let coupons = model.map({
            return DashboardCouponsStructure(
                title:$0.title,
                subtitle:$0.subtitle,
                logo:$0.logo,
                image:$0.image,
                color:$0.color,
                storeName:$0.storeName,
                geoCoordinate:$0.geoCoordinate,
                startDate:$0.startDate, expiryDate:$0.expiryDate,
                status:$0.status, code:$0.code, id:$0.id
            )
        })
        self.output?.obtained(coupons: coupons)
    }
    
    
    
}

// MARK: Dashboard interactor input interface

extension DashboardInteractor: DashboardInteractorInput {
    
    func fetchMycouponFromRealm() {
        let coupons = service.fetchMyCupons()
        self.convert(model: coupons)
    }
    
    
    func fetchCurrentNotification() {
//        self.service.checkNotificationStatus(page: 1, limit: 1, success: { (notification) in
//            let count = notification.count
//            if count == 1{
//                self.output?.showNotification(status: true)
//            }else {
//                self.output?.showNotification(status: false)
//            }
//        }) { (error) in
//            self.output?.obtained(error: error)
//        }
    }
    
    
    func fetchNearestCoupons(location: LocationStructure) {
        self.service.fetchCoupon(model: location, success: { (data) in
          self.convert(model: data)
        }) { (error) in
        self.output?.obtained(error: error)
        }
    }
    
    func fetchMyCoupons() {
        self.service.fetchMyCoupons(success: { (myCoupons) in
             self.convert(model: myCoupons)
        }) { (error) in
            self.output?.obtained(error: error)
        }
    }
    
    
}
