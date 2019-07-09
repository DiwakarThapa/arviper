//
//  DashboardPresenter.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class DashboardPresenter {
    
	// MARK: Properties
    
    weak var view: DashboardViewInterface?
    var interactor: DashboardInteractorInput?
    var wireframe: DashboardWireframeInput?

    // MARK: Converting entities
    func convert(model:[DashboardMyCouponsStructure]){
        let convertedCoupons = model.map({
            return DashboardMycouponsViewModel(
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
        self.view?.success(myCoupons: convertedCoupons)
    }
    
    func convert(model:[DashboardCouponsStructure]){
        let coupons = model.map({
            return DashboardCouponsViewModel(
                title:$0.title,
                subtitle:$0.subtitle,
                logo:$0.logo,
                image:$0.image,
                color:$0.color,
                geoCoordinate:$0.geoCoordinate,
                startDate:$0.startDate,
                expiryDate:$0.expiryDate,
                status:$0.status, code:$0.code,
                storeName:$0.storeName,
                id:$0.id
            )
        })
        self.view?.success(coupons: coupons)
        
    }
    
}

 // MARK: Dashboard module interface

extension DashboardPresenter: DashboardModuleInterface {
    
    func getMycouponFromRealm() {
        interactor?.fetchMycouponFromRealm()
    }
    
    
    func checkCurrentNotification() {
        self.interactor?.fetchCurrentNotification()
    }
    
    
    func getNearestCoupons(showLoading: Bool, currentLocation: LocationStructure) {
        if showLoading{
             self.view?.showLoading()
            interactor?.fetchNearestCoupons(location: currentLocation)
        }else{
            interactor?.fetchNearestCoupons(location: currentLocation)
        }
    }
    
    func didTapMyCoupons() {
        wireframe?.gotoMyCoupons()
    }
    
    
    func didTapNotification() {
        wireframe?.gotoNotification()
    }
    
    func getMycoupons(showLoading: Bool) {
        if showLoading {
            self.view?.showLoading()
            interactor?.fetchMyCoupons()
        }else{
        interactor?.fetchMyCoupons()
        }
    }
    
    func didTapOnViewAll() {
        wireframe?.viewClaimedCoupons()
    }
    
    func didTapOnCoupon(id: String) {
    self.wireframe?.gotoCouponsDetails(id: id)
    }
    
    func didTapOnMap() {
    self.wireframe?.gotoMapView()
    }
    
    func didTapOnArButton() {
        self.wireframe?.gotoArView()
    }
    
    
    func didTapMore() {
        self.wireframe?.gotoMore()
    }
}

// MARK: Dashboard interactor output interface

extension DashboardPresenter: DashboardInteractorOutput {
    
    func showNotification(status: Bool) {
        self.view?.notification(status: status)
    }
    
    
    func obtained(coupons: [DashboardCouponsStructure]) {
        self.view?.hideLoading()
        self.convert(model: coupons)
    }
    func obtained(myCoupons : [DashboardMyCouponsStructure]) {
        self.view?.hideLoading()
        self.convert(model: myCoupons)
    }
    
    func obtained(error: Error) {
        self.view?.hideLoading()
        self.view?.showError(error: error)
    }
  
}
