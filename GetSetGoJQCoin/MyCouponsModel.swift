//
//  MyCouponsModel.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/30/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import RealmSwift

class MyCouponsModel: Codable {
    
    var data:[MyCouponsData]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
}


class MyCouponsData: Codable {
    
    var title:String?
    var subtitle:String?
    var logo:String?
    var image:String?
    var color:String?
    var geoCoordinate:String?
    var startDate:String?
    var expiryDate:String?
    var status:String?
    var userId:String?
    var id:String?
    var claimedDate:String?
    var redeemedDate:String?
    var storeName:String?
    var code:String?
    var batchCode:String?
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case subtitle = "subtitle"
        case logo = "logo"
        case image = "image"
        case geoCoordinate = "geo_coordinate"
        case startDate = "start_date"
        case expiryDate = "expiry_date"
        case userId = "user_id"
        case id = "id"
        case color = "color"
        case status = "status"
        case claimedDate = "claimed_date"
        case code = "code"
        case storeName = "store_name"
        case redeemedDate = "redeemed_date"
        case batchCode = "batch_code"
        
    }
    
    func realmModel() -> MycouponsRealmModel {
        
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
        model.batchCode = self.batchCode ?? ""
        return  model
        
    }
    
}


class MycouponsRealmModel: Object, Codable {
    
    @objc dynamic var title:String = ""
    @objc dynamic var subtitle:String = ""
    @objc dynamic var logo:String = ""
    @objc dynamic var image:String = ""
    @objc dynamic var color:String = ""
    @objc dynamic var geoCoordinate:String = ""
    @objc dynamic var startDate:String = ""
    @objc dynamic var expiryDate:String = ""
    @objc dynamic var status:String = ""
    @objc dynamic var userId:String = ""
    @objc dynamic var id:String = ""
    @objc dynamic var claimedDate:String = ""
    @objc dynamic var redeemedDate:String = ""
    @objc dynamic var storeName:String = ""
    @objc dynamic var code:String = ""
    @objc dynamic var batchCode:String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func normalModel() -> MyCouponsData {
        let model = MyCouponsData()
        model.title = self.title
        model.subtitle = self.subtitle
        model.logo = self.logo
        model.image = self.image
        model.color = self.color
        model.geoCoordinate = self.geoCoordinate
        model.startDate = self.startDate
        model.expiryDate = self.expiryDate
        model.status = self.status
        model.userId = self.userId
        model.id = self.id
        model.claimedDate = self.claimedDate
        model.redeemedDate = self.redeemedDate
        model.storeName = self.storeName
        model.code = self.code
        model.batchCode = self.batchCode
        return  model
        
    }
    
}





func modelDecoder(){
    let decoder = JSONDecoder.init()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
}
