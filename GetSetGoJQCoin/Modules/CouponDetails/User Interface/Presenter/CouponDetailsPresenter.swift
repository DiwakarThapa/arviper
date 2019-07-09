//
//  CouponDetailsPresenter.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class CouponDetailsPresenter {
    
	// MARK: Properties
    
    weak var view: CouponDetailsViewInterface?
    var interactor: CouponDetailsInteractorInput?
    var wireframe: CouponDetailsWireframeInput?

    // MARK: Converting entities
    
    func convert(model:CoouponDetailsStructure){
        var viewModel = CouponDetailsViewModel()
       // viewModel.address = model.address
        viewModel.title = model.title
        viewModel.subtitle = model.subtitle
        viewModel.logo = model.logo
        viewModel.image = model.image
        viewModel.color = model.color
        viewModel.geoCoordinate = model.geoCoordinate
        viewModel.expiryDate = model.expiryDate
        viewModel.status = model.status
        viewModel.store = model.storeName
        viewModel.redeemedDate = model.redeemedDate
        viewModel.id = model.id
        viewModel.claimedDate = model.claimedDate
        viewModel.code = model.code
        viewModel.batchCode = model.batchCode
        
        self.view?.success(model: viewModel)
    }
}

 // MARK: CouponDetails module interface

extension CouponDetailsPresenter: CouponDetailsModuleInterface {
   
    func successPopup(message: String) {
        self.wireframe?.openSuccessPopUp(message: message)
    }
    
    func couponRedeem(id: String,shopCode: String) {
        self.view?.showLoading()
        self.interactor?.couponRedeem(id: id, code: shopCode)
    }
    
    
    func fetchCouponDetails() {
        self.view?.showLoading()
        self.interactor?.getCouponDetails()
    }

    
    
}

// MARK: CouponDetails interactor output interface

extension CouponDetailsPresenter: CouponDetailsInteractorOutput {
    func obtained(message: String) {
        self.view?.hideLoading()
        self.view?.success(message: message)
        
    }
    
    func obtained(coupon: CoouponDetailsStructure) {
        self.view?.hideLoading()
        self.convert(model: coupon)
    }
    
    
    func obtained(error: Error) {
        self.view?.hideLoading()
        self.view?.show(error: error)
    }
    

    
    
}
