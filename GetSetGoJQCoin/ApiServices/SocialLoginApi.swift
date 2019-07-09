//
//  SocialLoginApi.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 6/18/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import Alamofire

struct LoginRequierdData {
    
    var displayName:String?
    var id:String?
    var image:String?
    var email:String?
    var username:String?
    var provider:String?
}

protocol SocialLoginApi:ApiServiceType,RealmPersistenceType {
    func loginSocialApi(model:LoginRequierdData, success: @escaping () -> (), failure: @escaping (Error) -> ())
    
}

extension SocialLoginApi{
    
    func loginSocialApi(model:LoginRequierdData, success: @escaping () -> (), failure: @escaping (Error) -> () ) {
        let url = Configuration.conf.authBaseURL
        let param:[String:Any] = [
            "user": [
                "displayName":model.displayName ?? "",
                "id": model.id ?? "",
                "image": model.image ?? "",
                "email":model.email ?? "",
                "username":model.username ?? ""
            ],
            "provider": model.provider ?? ""
        ]

        apiManager.apiRequest(url: url, method: .post, parameters: param, encoding: JSONEncoding.default, header: nil, completion: { (response) in
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(LoginModel.self, from: response)
                if model.accessToken != "" {
                    self.save(models: [model.toRealmModal()])
                    success()
                    return
                }
            
            } catch let error {
                failure(error)
            }
            
            
        }) { (error) in
            failure(error)
        }
        
    }
}
