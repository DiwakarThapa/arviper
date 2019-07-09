//
//  ErrorModel.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/30/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation


class ErrorModel: Codable {
    var status:String?
    var error:ErrorData?
    
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
    }
    
}

class ErrorData: Codable{
    
    var code:String?
    var domain:String?
    var message:String?
    var title:String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case domain
        case message
        case title
    }
    
}
