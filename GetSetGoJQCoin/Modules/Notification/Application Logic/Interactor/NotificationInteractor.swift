//
//  NotificationInteractor.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class NotificationInteractor {
    
	// MARK: Properties
    
    weak var output: NotificationInteractorOutput?
    private let service: NotificationServiceType
    private var page = 0
    
    // MARK: Initialization
    
    init(service: NotificationServiceType) {
        self.service = service
    }

    // MARK: Converting entities
    
    func convert(model:[NotificationDataList]){
        let notification = model.map({
            return NotificationStructure(
                id:$0.id,
                title:$0.title,
                message:$0.message,
                image:$0.image,
                createdAt:$0.createdAt
            )
        })
        self.output?.obtained(success: notification)
    }
}

// MARK: Notification interactor input interface

extension NotificationInteractor: NotificationInteractorInput {
    
    func fetchNotification() {
        let pageNo = Int(UserDefaults.standard.getNotificationPage()) ?? 0
        let currentPage = 1 + pageNo
        self.service.fetchNotification(page: currentPage, limit: 15, success: { (notification) in
            self.convert(model: notification)
        }) { (error) in
            self.output?.obtained(error: error)
        }
    }

    
}
