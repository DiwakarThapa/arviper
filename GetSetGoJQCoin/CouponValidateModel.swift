//
//  CouponClaimModel.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/25/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class CouponValidateModel : Codable{
    var data:CouponValidateData?
    
    enum CodingKeys:String , CodingKey {
        case data = "data"
    }
    
   
}


class CouponValidateData: Codable {
    
    var message:String?
    var isValid:Bool?
    
    enum CodingKeys: String, CodingKey{
        case isValid = "isValid"
        case message = "message"
    }
    
}
