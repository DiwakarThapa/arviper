//
//  ARPresenter.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class ARPresenter {
    
	// MARK: Properties
    
    weak var view: ARViewInterface?
    var interactor: ARInteractorInput?
    var wireframe: ARWireframeInput?

    // MARK: Converting entities
    
    private func convert(models:[CouponStructure]){
        let couponData = models.map({return CouponViewModel(
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
        view?.couponData(model: couponData)
    }
    
    
    private func convert(model:CouponClaimStructure)
    {
        var viewModel = CouponClaimedViewModel()
        viewModel.claimedDate = model.claimedDate
        viewModel.color = model.color
        viewModel.expiryDate = model.expiryDate
        viewModel.geoCoordinate = model.geoCoordinate
        viewModel.id = model.id
        viewModel.logo = model.logo
        viewModel.image = model.image
        viewModel.status = model.status
        viewModel.subTitle = model.subTitle
        viewModel.title = model.title
        viewModel.code = model.code
        viewModel.batchCode = model.batchCode
        self.view?.couponClaimSuccess(model: viewModel)
    }
    
    
}

 // MARK: AR module interface

extension ARPresenter: ARModuleInterface {
    func claimedCoupon(id: String) {
        wireframe?.couponDetails(id: id)
    }
    
    func claimCoupon(id: String) {
        interactor?.claimCoupon(id: id)
    }
    
    func validateCoupon(id: String) {
        interactor?.validate(couponId: id)
    }
    
    
    func fetchCoupon() {
        self.interactor?.getData()
    }
    
    
}

// MARK: AR interactor output interface

extension ARPresenter: ARInteractorOutput {
    
    func obtained(successCoupon: CouponClaimStructure) {
        self.convert(model: successCoupon)
    }
    
    
    func obtained(message: String) {
        self.view?.hideLoading()
        
    }
    
    
    func obtainedInvalidCoupon() {
        view?.loadNextCoupon()
    }
    
    
    func validated(couponId: String) {
    
        view?.successCoupon(id: couponId)
    }
    
    
    func obtainedData(coupon: [CouponStructure]) {
        self.convert(models: coupon)
    }
    
    func obtained() {
        
    }
    
    func obtained(error: Error) {
        view?.show(error: error)
    }
    
    
}
