//
//  CouponRedeemModel.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
class CouponRedeemModel: Codable {
    
    var data:CouponRedeemData?
    var status:String?
    var message:String?
    var code:Int?
    
    enum CodingKeys: String, CodingKey {
        case data
        case status
        case message
        case code
    }
    
}


class CouponRedeemData :Codable{

    var title:String?
    var subtitle:String?
    var logo:String?
    var image:String?
    var color:String?
    var geoCoordinate:String?
    var startDate:String?
    var userId:String?
    var storeName:String?
    var expiryDate:String?
    var status:String?
    var id:String?
    var code:String?
    var claimedDate:String?
    var redeemedDate:String?
    
    enum CodingKeys :String, CodingKey {
       case title
       case subtitle
       case logo
       case image
       case color
       case geoCoordinate = "geo_coordinate"
       case expiryDate = "expiry_date"
        case startDate = "start_date"
        case userId = "user_id"
    case storeName = "store_name"
       case status
       case id
       case code
       case claimedDate = "claimed_date"
       case redeemedDate = "redeemed_date"
    }

    func realmModel() -> MycouponsRealmModel{
        let model = MycouponsRealmModel()
        model.title = self.title ?? ""
        model.subtitle = self.subtitle ?? ""
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
        return model
    }
    
}
