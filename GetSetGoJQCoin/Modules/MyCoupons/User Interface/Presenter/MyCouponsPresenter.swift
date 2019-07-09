//
//  MyCouponsPresenter.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class MyCouponsPresenter {
    
    // MARK: Properties
    
    weak var view: MyCouponsViewInterface?
    var interactor: MyCouponsInteractorInput?
    var wireframe: MyCouponsWireframeInput?
    
    // MARK: Converting entities
    func convert(model:[MyCouponsStructure]){
        let convertedCoupons = model.map({
            return MyCouponsViewModel(
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
                storeName:$0.storeName,
                batchCode:$0.batchCode
            )
        })
        self.view?.success(coupons: convertedCoupons)
    }
    
}

// MARK: MyCoupons module interface

extension MyCouponsPresenter: MyCouponsModuleInterface {
    
    func refreshMycoupon() {
         self.interactor?.fetchMycoupon()
    }
    
    func fetchMyCoupon(sortType: String) {
        self.view?.showLoading()
        self.interactor?.getMycoupon(sortBy: sortType)
    }
    
//    func fetchRedeemedCoupons() {
//        self.view?.showLoading()
//        self.interactor?.getRedeemedCooupons()
//    }
//
//    func fetchActiveCoupons() {
//        self.view?.showLoading()
//        self.interactor?.getActiveCoupons()
//    }
//
//    func fetchExpiredCoupons() {
//        self.view?.showLoading()
//        self.interactor?.getExpiredCoupons()
//    }
    
    func couponDetails(id: String) {
        self.wireframe?.goToCouponDetails(id: id)
    }
    
//    func fetchMyCoupon() {
//        self.view?.showLoading()
//        self.interactor?.getMycoupon()
//    }

}

// MARK: MyCoupons interactor output interface

extension MyCouponsPresenter: MyCouponsInteractorOutput {
    func obtained(coupons: [MyCouponsStructure]) {
        self.view?.hideLoading()
        self.convert(model: coupons)
    }
    
    
    func obtained(error: Error) {
        self.view?.hideLoading()
        self.view?.error(message: error)
    }
    
    
    
}
