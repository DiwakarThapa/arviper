//
//  NotificationModel.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
class NotificationModel: Codable{
    var data:[NotificationDataList]?
    var count:Int?
    var page:String?
    
    enum CodingKeys:String, CodingKey {
        case data
        case count
        case page
    }
    
}
class NotificationDataList: Codable{
    
    var id:String?
    var title:String?
    var message:String?
    var image:String?
    var createdAt:String?
    
    
    enum CodingKeys:String, CodingKey {
        case id = "_id"
        case title
        case message
        case image
        case createdAt = "created_at"
    }
    
}
