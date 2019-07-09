//
//  HomePagePresenter.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class HomePagePresenter {
    
	// MARK: Properties
    
    weak var view: HomePageViewInterface?
    var interactor: HomePageInteractorInput?
    var wireframe: HomePageWireframeInput?

    // MARK: Converting entities
    
    func convert(model: [HomePageCouponStructure]){
        let coupons = model.map({
            return HomePageCouponViewModel(
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
        view?.coupons(model: coupons)
    }
}

 // MARK: HomePage module interface

extension HomePagePresenter: HomePageModuleInterface {
    func didTapMore() {
        self.wireframe?.openMore()
    }
    
    func didTapMyCoupon() {
        wireframe?.openMyCoupons()
    }
    
    func openNormalCamera() {
        self.wireframe?.openNormalCamera()
    }
    
    func callCouponListApi(location: LocationStructure) {
         interactor?.couponListingApi(location: location)
    }
    
    
    func openAR() {
    wireframe?.gotoAr()
    }
    
    

    
}

// MARK: HomePage interactor output interface

extension HomePagePresenter: HomePageInteractorOutput {
    
    func obtained(model: [HomePageCouponStructure]) {
        view?.hideLoading()
        self.convert(model: model)
    }
    
    func obtained(error: Error) {
        view?.hideLoading()
        view?.error(error)
    }
    
    func obtained() {
        
        view?.hideLoading()
//        view?.sucess()
        
    }
    
    
    
}
