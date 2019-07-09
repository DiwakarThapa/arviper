//
//  LoginPageInteractorIO.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//Copyright © 2562 ekbana. All rights reserved.
//

protocol LoginPageInteractorInput: class {
    func loginAction(username:String, pass:String)
    func lineLogin()
    func facebookLogin()
}

protocol LoginPageInteractorOutput: class {
    func showLoading()
    func successObtained()
    func errorObtained(error:Error)
    func validationErrorObtained(error:String, type:String)

}
