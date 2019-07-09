//
//  MoreWireframeInput.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

protocol MoreWireframeInput: WireframeInput {
    func openWebViewWith(title:String, url:String)
    func goToLogin()
    func goToMyCoupons()
    
    func openOnboardingPage()
}
