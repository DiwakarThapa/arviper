//
//  AuthModel.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/18/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import RealmSwift

class AuthModel: Object, Codable {
    
    @objc dynamic var id = ""
    @objc dynamic var accessToken: String = ""
    @objc dynamic var expiresIn: Int = 0
    @objc dynamic var refreshToken: String = ""
    @objc dynamic var message:String = ""
    @objc dynamic var data:LoginDataRealmModel?
    @objc dynamic var tokenType:String = ""
    

    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case data
        case message
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
    
    
}


class LoginDataRealmModel : Object, Codable {
    
    @objc dynamic var image:String = ""
    @objc dynamic var status:String = ""
    @objc dynamic var socialId:String = ""
    @objc dynamic var provider:String = ""
    @objc dynamic var token:String = ""
    @objc dynamic var id:String = ""
    @objc dynamic var fullName:String = ""
    @objc dynamic var username:String = ""
    @objc dynamic var email:String = ""
    @objc dynamic var created:String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
    enum CodingKeys: String, CodingKey {
        case socialId = "social_id"
        case fullName = "full_name"
        case image
        case status
        case provider
        case token
        case username
        case email
        case created
    }
    
    
}


struct LoginModel: Codable {
    
    var accessToken: String = ""
    var expiresIn: Int = 0
    var refreshToken: String = ""
    var message:String = ""
    var data:LoginNormalData?
    var tokenType:String = ""
    
//    "message": "Logged in Successfully",
//    "data": {
//    "image": "imagesrc",
//    "status": "active",
//    "social_id": "line/fb id",
//    "provider": "facebook",
//    "token": "",
//    "_id": "5d0caa60f65f14620272420d",
//    "full_name": "Prajwal Bati",
//    "username": "line/fb username",
//    "email": "prajwasadflbati23@gmail.com",
//    "created": "2019-06-21T09:58:56.156Z",
//    "__v": 0
//    },
//    "access_token": "JZhJYGsqN12biSDu5AVuCL9Oh2bGWShQxS1JmdnZQDEw5ViYf5v05thS1VcwgGDdbS1U9Rhdp80HsjCUOjkEvQmwPnbhSf6gYfA9qB8PPQkm0uckfpxwYkA6fDxh89viaCIEQvsGsxpuowOfWUw5niWiCq2BJV6IP1higAVp0NdZTLME0TijeCjAqGJRNgX72348VtxlrHifdA5iwMhMkCAQJV3yrhX1OVAmb9EravxoJj5vn6ascgS0bMEvj0tXehbYoq4wY1xak0AVAaOfjvC9vneq352pP4T4YAlz9WKbj2mFOi4sVFV058hLalNPoBbGWnDXMplB8tIcIpcWq9wNQYR41TLjylHgrsHgSOy3MDbeXHs8gCTQqKAv9VudmpzBQHBPlLavjp2H",
//    "refresh_token": "nyBR5VDXJQVf3brZsSU42jjvMT27p5M09lUYqTlYDmhjZqGQpHMhuZPzzE8JryJF9zkIVC6NrKMv5W9YFMbSHnX7w2gxz1Yb01ad3b3eZnW322DSG8Dw7XGdt6U4zFETNOzvUxct1fQbyzq9eVixdm1Gi018zJ4psN0Kvz0BdQXuAeNmH38vYdIIGT06HSlBGRzfpvrUpsSpi8It9XorpUMdId1QuDrYWPr8nD56zpLWS6WSxnLcKHKbgmE7fCbIpqFMGKIj8BZF4N88O2dxbc2U3iwPJlI7v3GbtMg9yyxP36t3Z1htTBrEOUuyvAlVOwpXSivs7e7JiBzOZQ7EPlqTtJglTWJkkSazyQrjmCtvqiROsPEMKLIb47A5EB3sh7F8lJxIw5JggAE4",
//    "expires_in": 5184000,
//    "token_type": "Bearer"
    
    
    enum CodingKeys: String, CodingKey {
        case data
        case message
        case tokenType = "token_type"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
    
    func toRealmModal() -> AuthModel {
        //let currentTime = Date()
        
        let authModal = AuthModel()
        authModal.message = self.message
        authModal.data = self.data?.realmModel()
        authModal.accessToken = self.accessToken
//        authModal.expiresIn =  Int(currentTime.timeIntervalSince1970 + Double(self.expiresIn))
        authModal.expiresIn =  self.expiresIn
        authModal.refreshToken = self.refreshToken
    
        return authModal
    }
    
    
}

struct LoginNormalData: Codable {
    
    var image:String = ""
    var status:String = ""
    var socialId:String = ""
    var provider:String = ""
    var token:String = ""
    var id:String = ""
    var fullName:String = ""
    var username:String = ""
    var email:String = ""
    var created:String = ""
    
     enum CodingKeys: String, CodingKey {
        case socialId = "social_id"
        case fullName = "full_name"
        case image
        case status
        case provider
        case token
        case username
        case email
        case created
    }
    
    func realmModel() -> LoginDataRealmModel {
        
        let loginData = LoginDataRealmModel()
        loginData.image = self.image
        loginData.status = self.status
        loginData.socialId = self.socialId
        loginData.provider = self.provider
        loginData.token = self.token
        loginData.id = self.id
        loginData.fullName = self.fullName
        loginData.username = self.username
        loginData.email = self.email
        loginData.created = self.created
        return loginData
    }
}

