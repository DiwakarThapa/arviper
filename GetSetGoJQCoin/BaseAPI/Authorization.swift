//
//  Authorization.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//  Copyright © 2562 ekbana. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import Localize_Swift


enum Provider: String {
    case facebook = "facebookauth"
    case google = "googleauth"
    case pasword = "password"
    case refreshToken = "refresh_token"
    
    var appToken: String {
        switch self {
        case .facebook:
            return ""
        default:
            return ""
        }
    }
}

struct DeploymentMode: OptionSet {
    typealias RawValue = Int
    
    static func ==(lhs: DeploymentMode, rhs: DeploymentMode) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    var rawValue: DeploymentMode.RawValue
    static let dev: DeploymentMode = DeploymentMode(rawValue: 0)
    static let qa: DeploymentMode = DeploymentMode(rawValue: 1)
    static let uat: DeploymentMode = DeploymentMode(rawValue: 2)
    static let live: DeploymentMode = DeploymentMode(rawValue: 3)
    
}

struct Configuration {
    let clientId: Int
    let scope: String
    let clientSecret: String
    let apiKey: String
    let baseURL: String
    let authBaseURL: String
    let domain: String
    
    static var conf: Configuration {
        switch deploymentMode {
        case .dev:
            return Configuration(
                clientId: 1,
                scope: "",
                clientSecret: "YwVpTUjZGuEe7y5t",
                apiKey: "",
                baseURL: "https://getsetgo-dev.ekbana.co.jp/api/v1",
                authBaseURL: "https://getsetgo-dev.ekbana.co.jp/api/v1/auth/login",
                domain: "")
        case .qa:
            return Configuration(
                clientId: 1,
                scope: "",
                clientSecret: "YwVpTUjZGuEe7y5t",
                apiKey: "",
                baseURL: "https://dev.getsetgo.jqt01.com/api/v1",
                authBaseURL: "https://dev-api.jqt01.com/api/v1/auth/token",
                domain: "")
        case .uat:
            return Configuration(
                clientId: 1,
                scope: "",
                clientSecret: "YwVpTUjZGuEe7y5t",
                apiKey: "",
                baseURL: "https://uat.getsetgo.jqt01.com/api/v1",
                authBaseURL: "https://uat-api.jqt01.com/api/v1/auth/token",
                domain: "")
        case .live:
            return Configuration(
                clientId: 1,
                scope: "",
                clientSecret: "YwVpTUjZGuEe7y5t",
                apiKey: "",
                baseURL: "https://dev.getsetgo.jqt01.com/api/v1",
                authBaseURL: "https://dev-api.jqt01.com/api/v1/auth/token",
                domain: "")
        default:
            return Configuration(
                clientId: 1,
                scope: "",
                clientSecret: "YwVpTUjZGuEe7y5t",
                apiKey: "",
                baseURL: "https://dev.getsetgo.jqt01.com/api/v1",
                authBaseURL: "https://dev-api.jqt01.com/api/v1//auth/token",
                domain: "")
        }
    }
}

class Authorization: RealmPersistenceType {
    
    static let shared = Authorization()
    let baseUrl: String = {return Configuration.conf.baseURL}()
    
    var availableLang:String = ""
    
    var oAuth: AuthModel? {
        return self.fetch().first
    }
    
    func hasTokenExpired() -> Bool {
        let expiryTime = self.oAuth?.expiresIn ?? 0
        let currentTime = Date().timeIntervalSince1970
        return (Int(currentTime) > expiryTime)
    }
    
    @objc func onDidHandelLanguage(_ notification: Notification) {
        if let language = notification.userInfo?["jp"] as? String {
            self.availableLang = language
        }
        if let enlanguage = notification.userInfo?["en"] as? String {
            self.availableLang = enlanguage
        }
    }
    
    func refresh(success: @escaping ()->(), failure: @escaping (Error)->()) {
        
        if  self.hasTokenExpired() {
            guard let refreshToken = self.oAuth?.refreshToken else {return}
            
            let header = [
                "Content-Type":"application/json",
                "Accept-Language":self.availableLang
            ]
            
            let params:[String:Any] = [
                "client_id":Configuration.conf.clientId,
                "client_secret":Configuration.conf.clientSecret,
                "grant_type":Provider.refreshToken.rawValue,
                "refresh_token":refreshToken
            ]
            
            self.genericApiRequest(url: Configuration.conf.authBaseURL, method: .post, parameters: params, encoding: JSONEncoding.default, header: header, completion: { (model:LoginModel) in
                if model.accessToken != "" {
                    //deleting old model
                    let oldModels: [AuthModel] = self.fetch()
                    self.delete(models: oldModels)
                    
                    //saving new model
                    self.save(models: [model.toRealmModal()])
                    success()
                    return
                }
            }) { (error) in
                failure(error)
            }
            
        }else{
            success()
        }
        
    }
    
    
    //MARK:  ApiRequest
    func apiRequest(url: String, method: HTTPMethod, parameters: [String:Any]?, encoding: ParameterEncoding, header: [String:Any]?, completion: @escaping (Data) -> () , failure: @escaping (Error) -> ()) {
        if NetworkReachabilityManager()?.isReachable == true {
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default, headers: [String:String]()).responseJSON { (resp) in
                let statusCode = resp.response?.statusCode ?? 500
                
                switch resp.result{
                case  .success( _):
                    if (400 ... 499).contains(statusCode) {
                        if let error = resp.value as? [String:Any] {
                            let errorData = NSError(domain: "LOGIN_ERROR", code: resp.response?.statusCode ?? 0, userInfo: [NSLocalizedDescriptionKey : (error["message"] as? String) ?? "Error"])
                            failure(errorData)
                            
                        }
                    }
                    else if statusCode == 500{
                        let error = GlobalConstants.Errors.oops
                        failure(error)
                    }
                    else if ((resp.value as? [String:Any] ?? [:])["status"] as? String ?? "") == "error" {
                        if let error = resp.value as? [String:Any] {
                            let errorData = NSError(domain: "LOGIN_ERROR", code: resp.response?.statusCode ?? 0, userInfo: [NSLocalizedDescriptionKey : (error["message"] as? String) ?? "Error"])
                            failure(errorData)
                        }
                    } else if (200..<300).contains(statusCode) {
                        if let data = resp.data {
                            completion(data)
                        }
                    }else {
                        if let data = resp.data {
                            completion(data)
                        }
                    }
                case  .failure(let error):
                    failure(error)
                }
            }
        } else{
            let error = GlobalConstants.Errors.internetConnectionOffline
            failure(error)
        }
        
    }
    
    //MARK : generic decodable api request function
    func genericApiRequest<T: Decodable>(url: String, method: HTTPMethod, parameters: [String:Any]?, encoding: ParameterEncoding,header: [String:Any]?, completion: @escaping (T) -> (), failure: @escaping (Error) -> ()) {
        if NetworkReachabilityManager()?.isReachable == true {
            let defaultLanguage = UserDefaults.standard.getDefaultLanguage()
            let authHeader = [
                "Authorization":"Bearer \(oAuth?.accessToken ?? "")",
                "Accept-Language":defaultLanguage
                ]as [String:String]
            
            Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: authHeader)
                .response { response in
                    
                    let statusCode = response.response?.statusCode ?? 500
                    guard let data = response.data else {return}
                    if (402 ... 499).contains(statusCode) || statusCode == 400{
                        do{
                            let errorData = try JSONDecoder().decode(ErrorModel.self, from: data)
                            let error = NSError(domain: "Coupon_Claim_Error", code: 22, userInfo: [NSLocalizedDescriptionKey: errorData.error?.message ?? ""])
                            failure(error as Error)
                        }catch {
                            print(error)
                        }
                    }else if statusCode == 401{
                        NotificationCenter.default.post(name: Notification.Name.didHandelAuthToken, object: nil)
                    } else if statusCode == 500{
                        let error = GlobalConstants.Errors.oops
                        failure(error)
                    }
                    else{
                        if let data = response.data {
                            do {
                                let model = try JSONDecoder().decode(T.self, from: data)
                                completion(model)
                                
                            } catch let jsonErr {
                                failure(jsonErr)
                            }
                        }else {
                            return
                        }
                    }
            }
            
        }else {
            let error = GlobalConstants.Errors.internetConnectionOffline
            failure(error)
        }
    }
    
    
    // MARK : login API
    func login(username: String, password: String, success: @escaping ()->(), failure: @escaping (Error)->()) {
        
        var authHeader:[String:Any]?
        let defaultLanguage = UserDefaults.standard.getDefaultLanguage()
        authHeader = [
            "Content-Type":"application/json",
            "Accept-Language":defaultLanguage
        ]
        
        let params:[String:Any] = [
            "client_id": Configuration.conf.clientId,
            "grant_type": Provider.pasword.rawValue,
            "client_secret" : Configuration.conf.clientSecret,
            "email": username,
            "password": password,
            ]
        
        self.apiRequest(url: Configuration.conf.authBaseURL, method: .post, parameters: params, encoding: JSONEncoding.default, header: authHeader as! HTTPHeaders, completion: { (response) in
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(LoginModel.self, from: response)
                if model.accessToken != nil {
                    success()
                    self.save(models: [model.toRealmModal()])
                    
                    return
                }
                
            } catch let error {
                failure(error)
            }
            print("Api Error 001")
        }) { (error) in
            failure(error)
        }
    }
}


