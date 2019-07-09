//
//  MoreInteractor.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class MoreInteractor {
    
	// MARK: Properties
    
    weak var output: MoreInteractorOutput?
    private let service: MoreServiceType
    
    // MARK: Initialization
    
    init(service: MoreServiceType) {
        self.service = service
    }

    // MARK: Converting entities
}

// MARK: More interactor input interface

extension MoreInteractor: MoreInteractorInput {
    func logOutAction() {
        self.service.logout(success: {
            UserDefaults.standard.setIsLoggedIn(value: false)
            self.output?.obtained()
        }) { (error) in
            self.output?.obtained(error: error)
        }
    }
    
    
}
