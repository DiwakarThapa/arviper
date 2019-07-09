//
//  ResponseMessage.swift
//  Sipradi
//
//  Created by bibek timalsina on 6/2/17.
//  Copyright © 2017 Ekbana. All rights reserved.
//

import Foundation


struct ResponseMessage: Codable {
    var error: Bool?
    var message: String?
    var status : String?

}
