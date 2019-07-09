//
//  LoginPageViewInterface.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//Copyright © 2562 ekbana. All rights reserved.
//

protocol LoginPageViewInterface: class {
    func showLoading()
    func hideLoading()
    func sucess()
    func error(error:Error)
    func errorValidation(error:String, type:String)
}
