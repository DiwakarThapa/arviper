//
//  ARInteractor.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class ARInteractor {
    
	// MARK: Properties
    
    weak var output: ARInteractorOutput?
    private let service: ARServiceType
    
    // MARK: Initialization
    
    init(service: ARServiceType) {
        self.service = service
    }

    // MARK: Converting entities
    
    private func convert(models:[CouponModel]){
        let couponList = models.map({
            return CouponStructure(
                title:$0.title,
                subtitle:$0.subtitle,
                logo:$0.logo,
                image:$0.image,
                color:$0.color,
                geoCoordinate:$0.geoCoordinate,
                expiryDate:$0.expiryDate,
                id:$0.id,
                isValid:$0.isValid
                
            )})
    self.output?.obtainedData(coupon:couponList)
    }
    
    
    private func convert(model:CouponClaimData){
        var structure = CouponClaimStructure()
        structure.claimedDate = model.claimedDate
        structure.color = model.color
        structure.expiryDate = model.expiryDate
        structure.geoCoordinate = model.geoCoordinate
        structure.id = model.id
        structure.image = model.image
        structure.logo = model.logo
        structure.title = model.title
        structure.subTitle = model.subTitle
        structure.status = model.status
        structure.code = model.code
        structure.batchCode = model.batchCode
        
        self.output?.obtained(successCoupon: structure)
    
    }


}

// MARK: AR interactor input interface

extension ARInteractor: ARInteractorInput {
    
    func claimCoupon(id: String) {
        service.claimCoupon(couponId: id, success: { (data) in
            self.convert(model: data)
        }) { (error) in
            self.output?.obtained(error: error)
        }
    }
    
    
    func validate(couponId: String) {
        self.service.couponValidate(couponId:couponId,success: { (status) in
            if status{
                self.output?.validated(couponId: couponId)
            }else{
                self.service.invalidate(couponId: couponId)
                self.output?.obtainedInvalidCoupon()
            }
        }) { (error) in
            self.output?.obtained(error: error)
        }
    }
    
    
    func getData() {
        let coupons = self.service.fetchCupons()
        self.convert(models: coupons)
    }
    
    
}
