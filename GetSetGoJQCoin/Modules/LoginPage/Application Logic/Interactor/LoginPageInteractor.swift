//
//  LoginPageInteractor.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//Copyright © 2562 ekbana. All rights reserved.
//

import Foundation

import FBSDKLoginKit
import FBSDKCoreKit

import LineSDK

class LoginPageInteractor {
    
	// MARK: Properties
    var view: LoginPageViewController?
    weak var output: LoginPageInteractorOutput?
    private let service: LoginPageServiceType
    
    // MARK: Initialization
    
    init(service: LoginPageServiceType) {
        self.service = service
    }

    // MARK: Converting entities
}

// MARK: LoginPage interactor input interface

extension LoginPageInteractor: LoginPageInteractorInput {
    
    func lineLogin() {
        LoginManager.shared.login(permissions: [.profile], in: LoginPageViewController()) { [weak self]
            result in
            switch result {
            case .success(let loginResult):
                 var structure = LoginRequierdData()
                 structure.displayName = loginResult.userProfile?.displayName ?? ""
                 structure.email = ""
                 structure.id = loginResult.userProfile?.userID
                 structure.image = loginResult.userProfile?.pictureURLSmall?.absoluteString
                 structure.username = loginResult.userProfile?.displayName ?? ""
                 structure.provider = "line"
                 self?.service.loginSocialApi(model: structure, success: {
                      UserDefaults.standard.setIsLoggedIn(value: true)
                       self?.output?.successObtained()
                 }, failure: { (error) in
                    self?.output?.errorObtained(error: error)
                 })
        
            case .failure(let error):
                self?.output?.errorObtained(error: error)
            }
        }
    }
    
    
    func facebookLogin() {
//        let fbLoginManager: LoginManager = LoginManager()
        LoginManager().logIn(permissions: ["email"], from: LoginPageViewController()) { [weak self] (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self?.getFBUserData()
                }
            }
        }
    }
    
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { [weak self] (connection, result, error) -> Void in
                if (error == nil){
    
                    let fbData = result as? [String: Any] ?? [:]
                    let id = fbData["id"] as? String ?? ""
                    let displayName = fbData["name"] as? String ?? ""
                    let url = ((fbData["picture"] as? [String: Any] ?? [:])["data"] as? [String: Any] ?? [:])["url"] as? String ?? ""
                    let email = fbData["email"] as? String ?? ""
                    UserDefaults.standard.setProfileUrl(image: url)
                    var structure = LoginRequierdData()
                    structure.displayName = displayName
                    structure.email = email
                    structure.id = id
                    structure.image = url
                    structure.username = email
                    structure.provider = "facebook"
                    self?.output?.showLoading()
                    self?.service.loginSocialApi(model: structure, success: {
                        UserDefaults.standard.setIsLoggedIn(value: true)
                        self?.output?.successObtained()
                    }, failure: { (error) in
                        self?.output?.errorObtained(error: error)
                    })
                    
                    
                }
            })
        }
    }
    
    func loginAction(username: String, pass: String) {
        validate(email: username, password: pass)
    }
    
    func validate(email: String, password: String) {
        do {
            let email = try email.validatedText(validationType: ValidatorType.email)
            let password = try password.validatedText(validationType: ValidatorType.password)
          
            Authorization.shared.login(username: email, password: password, success: {
                UserDefaults.standard.setIsLoggedIn(value: true)
                self.output?.successObtained()
            }) { (error) in
                self.output?.errorObtained(error: error)
            }
        } catch(let error) {
            self.output?.validationErrorObtained(error: (error as! ValidationError).message, type: (error as! ValidationError).type)
        }
    }
    
    
    
}
