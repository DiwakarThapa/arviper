//
//  SuccessResponse.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/7/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class SuccessResponse: Codable {
    var data:SuccessData?
}

class SuccessData: Codable {
    var message:String?
    var isValid:Bool?
}
