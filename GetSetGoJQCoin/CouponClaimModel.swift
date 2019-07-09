//
//  CouponClaimModel.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/26/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class CouponClaimModel:Codable {
    var data:CouponClaimData?
    var status:String?
    var message:String?
    var code:Int?
    
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
        case message = "message"
        case code = "code"
    }
}


class CouponClaimData: Codable {

    var title:String?
    var subTitle:String?
    var startDate:String?
    var userId:String?
    var redeemedDate:String?
    var logo:String?
    var image:String?
    var color:String?
    var geoCoordinate:String?
    var expiryDate:String?
    var status:String?
    var id:String?
    var claimedDate:String?
    var code:String?
    var storeName:String?
    var batchCode:String?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case subTitle = "subtitle"
        case startDate = ""
        case userId = "user_id"
        case redeemedDate = "redeemed_date"
        case logo = "logo"
        case image = "image"
        case color = "color"
        case geoCoordinate = "geo_coordinate"
        case expiryDate = "expiry_date"
        case status = "status"
        case id = "id"
        case claimedDate = "claimed_date"
        case code
        case storeName = "store_name"
        case batchCode = "batch_code"
    }
    
    func realmModel() -> MycouponsRealmModel {
        let model = MycouponsRealmModel()
        model.title = self.title ?? ""
        model.subtitle = self.subTitle ?? ""
        model.logo = self.logo ?? ""
        model.image = self.image ?? ""
        model.color = self.color ?? ""
        model.geoCoordinate = self.geoCoordinate ?? ""
        model.startDate = self.startDate ?? ""
        model.expiryDate = self.expiryDate ?? ""
        model.status = self.status ?? ""
        model.userId = self.userId ?? ""
        model.id = self.id ?? ""
        model.claimedDate = self.claimedDate ?? ""
        model.redeemedDate = self.redeemedDate ?? ""
        model.storeName = self.storeName ?? ""
        model.code = self.code ?? ""
        model.batchCode = self.batchCode ?? ""
        return model
    }

}
