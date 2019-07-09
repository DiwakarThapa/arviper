//
//  MorePresenter.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class MorePresenter {
    
	// MARK: Properties
    
    weak var view: MoreViewInterface?
    var interactor: MoreInteractorInput?
    var wireframe: MoreWireframeInput?

    // MARK: Converting entities
}

 // MARK: More module interface

extension MorePresenter: MoreModuleInterface {
    func getOnboardingPage() {
        wireframe?.openOnboardingPage()
    }
    
    func getLocalization() {
        
    }
    
    func getTermsAndContions() {
         self.wireframe?.openWebViewWith(title: GlobalConstants.Localization.termsAndCondition, url: GlobalConstants.WebUrl.termsAndCondition)
    }
    
    func getLogOut() {
        self.view?.showLoading()
        self.interactor?.logOutAction()
    }
    
    func getMyCoupons() {
      self.wireframe?.goToMyCoupons()
    }

    
    func getDislaimer() {
        self.wireframe?.openWebViewWith(title: GlobalConstants.Localization.disclaimer, url: GlobalConstants.WebUrl.disclaimer)
    }
    
    func getPrivacyPolicy() {
        self.wireframe?.openWebViewWith(title: GlobalConstants.Localization.privacyPolicy, url: GlobalConstants.WebUrl.privacyPolicy)
    }
    
    
}

// MARK: More interactor output interface

extension MorePresenter: MoreInteractorOutput {
    
    func obtained() {
        self.view?.hideLoading()
        self.wireframe?.goToLogin()
    }
    
    func obtained(error: Error) {
       self.view?.hideLoading()
        self.view?.obtained(error: error)
    }
    
    
}
