//
//  CouponListModel.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/24/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import RealmSwift

class CouponListModel: Codable{
    var data:[CouponModel]
}


class CouponModel: Codable{

    var id:String?
    var title:String?
    var subtitle:String?
     var color:String?
    var startDate:String?
    var expiryDate:String?
    var status:String?
    var geoCoordinate:String?
    var code:String?
    var storeName:String?
    var image:String?
    var logo:String?
    var isValid:Bool = true
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case logo
        case image
        case storeName = "store_name"
        case color
        case startDate = "start_date"
        case geoCoordinate = "geo_coordinate"
        case expiryDate = "expiry_date"
        case status
        case code
        case id
    }
    
    
    func realmModel() -> CouponRealmModel {
        
        let model = CouponRealmModel()
        model.title = self.title ?? ""
        model.subtitle = self.subtitle ?? ""
        model.logo = self.logo  ?? ""
        model.image = self.image ?? ""
        model.color = self.color  ?? ""
        model.geoCoordinate = self.geoCoordinate  ?? ""
        model.expiryDate = self.expiryDate  ?? ""
        model.code = self.code  ?? ""
        model.storeName = self.storeName ?? ""
        model.startDate = self.startDate  ?? ""
        model.status = self.status  ?? ""
        model.id = self.id  ?? ""
        model.isValid = self.isValid 
        return model
    }
    
}


class CouponRealmModel: Object, Codable {
    
    @objc dynamic var title:String = ""
    @objc dynamic var subtitle:String = ""
    @objc dynamic var logo:String = ""
    @objc dynamic var image:String = ""
    @objc dynamic var color:String = ""
    @objc dynamic var geoCoordinate:String = ""
    @objc dynamic var expiryDate:String = ""
    @objc dynamic var startDate:String = ""
    @objc dynamic var status:String = ""
    @objc dynamic var code:String = ""
    @objc dynamic var id:String = ""
    @objc dynamic var storeName:String = ""
    @objc dynamic var isValid:Bool = true
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func normalModel () -> CouponModel{
        let model = CouponModel()
        model.title = self.title
        model.subtitle = self.subtitle
        model.logo = self.logo
        model.image = self.image
        model.color = self.color
        model.geoCoordinate = self.geoCoordinate
        model.expiryDate = self.expiryDate
        model.status = self.status
        model.code = self.code
        model.storeName = self.storeName
        model.startDate = self.startDate
        model.id = self.id
        
        return model
    }
    
    
}


