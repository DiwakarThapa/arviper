//
//  LoginPageModuleInterface.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//Copyright © 2562 ekbana. All rights reserved.
//

protocol LoginPageModuleInterface: class {
    func login(username:String, password:String)
    func signup()
    func facebookLogin()
    func lineLogin()
}
