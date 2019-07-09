//
//  MyCouponsInteractor.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class MyCouponsInteractor {
    
	// MARK: Properties
    var claimedOnly:Bool?
    weak var output: MyCouponsInteractorOutput?
    private let service: MyCouponsServiceType
    
    // MARK: Initialization
    
    init(service: MyCouponsServiceType) {
        self.service = service
    }

    // MARK: Converting entities\
    func convert(model:[MyCouponsData]){
        let convertedCoupons = model.map({
            return MyCouponsStructure(
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
        self.output?.obtained(coupons: convertedCoupons)
    }
    
    
}

// MARK: MyCoupons interactor input interface

extension MyCouponsInteractor: MyCouponsInteractorInput {

    func fetchMycoupon() {
        service.fetchMyCoupons(success: { (myCoupons) in
            self.convert(model: myCoupons)
        }) { (error) in
            self.output?.obtained(error: error)
        }
    }
    
    func getMycoupon(sortBy: String) {
        let  coupons = service.fetchMyCupons()
        if claimedOnly ?? false {
            let activeCoupons = coupons.filter{
                return $0.status == "CLAIMED"
            }
             self.claimedOnly = false
            self.convert(model: activeCoupons)
        }else{
            switch sortBy {
            case "claimed":
                let activeCoupons = coupons.filter{
                    return $0.status == "CLAIMED"
                }
                self.convert(model: activeCoupons)
                break
            case "redeemed":
                let redeemedCoupons = coupons.filter{
                    return $0.status == "REDEEMED"
                }
                self.convert(model: redeemedCoupons)
            case "expire":
                let expiredCoupons = coupons.filter{
                    return $0.status == "EXPIRED"
                }
                self.convert(model: expiredCoupons)
            case "all":
                self.convert(model: coupons)
            default:
                self.convert(model: coupons)
            }
        }
        
//         if claimedOnly ?? false {
//            self.service.fetchMyCoupons(success: { (coupons) in
//                self.convert(model: coupons)
//            }) { (error) in
//                self.output?.obtained(error: error)
//            }
//         }else{
//            self.service.fetchMyCoupons(success: { (coupons) in
//                self.convert(model: coupons)
//            }) { (error) in
//                self.output?.obtained(error: error)
//            }
//        }
    }
    
//    func getRedeemedCooupons() {
//        self.service.fetchRedeemedCoupons(success: { (coupons) in
//            self.convert(model: coupons)
//        }) { (error) in
//            self.output?.obtained(error: error)
//        }
//    }
//    
//    func getActiveCoupons() {
//        self.service.fetchActiveCoupons(success: { (coupons) in
//            self.convert(model: coupons)
//        }) { (error) in
//            self.output?.obtained(error: error)
//        }
//    }
//    
//    
//    func getExpiredCoupons() {
//        self.service.fetchExpiredCoupons(success: { (coupons) in
//            self.convert(model: coupons)
//        }) { (error) in
//            self.output?.obtained(error: error)
//        }
//    }
//    
//    
//    func getMycoupon() {
//        if claimedOnly ?? false {
//            self.service.fetchActiveCoupons(success: { (coupons) in
//                self.convert(model: coupons)
//                self.claimedOnly = false
//            }) { (error) in
//                self.output?.obtained(error: error)
//            }
//        }else{
//            service.fetchMyCoupons(success: { (coupons) in
//                self.convert(model: coupons)
//            }) { (error) in
//                self.output?.obtained(error: error)
//            }
//        }
//        
//    }
    
    
}
//switch sortBy {
//case "All":
//    getMycoupon()
//case "Claimed":
//    getActiveCoupons()
//case "Redeemed":
//    getRedeemedCooupons()
//case "Expired":
//    getExpiredCoupons()
//default:
//    getMycoupon()
//}
