//
//  ApiServiceType.swift
//  Sipradi
//
//  Created by Dari on 6/14/17.
//  Copyright © 2017 Ekbana. All rights reserved.
//

import Foundation
protocol ApiServiceType {
    var apiManager: Authorization {get}
    var baseUrl: String {get}
}

extension ApiServiceType {
    var apiManager: Authorization {return Authorization.shared}
    var baseUrl: String {return apiManager.baseUrl}
}
