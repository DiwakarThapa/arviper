//
//  LoginPagePresenter.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//Copyright © 2562 ekbana. All rights reserved.
//

import Foundation

class LoginPagePresenter {
    
	// MARK: Properties
    
    weak var view: LoginPageViewInterface?
    var interactor: LoginPageInteractorInput?
    var wireframe: LoginPageWireframeInput?

    // MARK: Converting entities
}

 // MARK: LoginPage module interface

extension LoginPagePresenter: LoginPageModuleInterface {
    
    func facebookLogin() {
        self.interactor?.facebookLogin()
    }
    
    func lineLogin() {
        self.interactor?.lineLogin()
    }
    
    func login(username: String, password: String) {
        view?.showLoading()
        interactor?.loginAction(username: username, pass: password)
    }
    
    func signup() {
        
    }
    
    
}

// MARK: LoginPage interactor output interface

extension LoginPagePresenter: LoginPageInteractorOutput {
    func showLoading() {
        self.view?.showLoading()
    }
    
    func validationErrorObtained(error: String, type: String) {
        view?.hideLoading()
        view?.errorValidation(error: error, type: type)
    }
    
    func successObtained() {
        view?.hideLoading()
        wireframe?.gotoHomePage()
    }
    
    func errorObtained(error: Error) {
          view?.hideLoading()
            view?.error(error: error)
    }
    
   
    
    
}
