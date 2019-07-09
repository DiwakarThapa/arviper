//
//  NotificationPresenter.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

class NotificationPresenter {
    
	// MARK: Properties
    
    weak var view: NotificationViewInterface?
    var interactor: NotificationInteractorInput?
    var wireframe: NotificationWireframeInput?

    // MARK: Converting entities
    func convert(model:[NotificationStructure]){
        let notification = model.map({
            return NotificationViewModel(
                id:$0.id,
                title:$0.title,
                message:$0.message,
                image:$0.image,
                createdAt:$0.createdAt
            )
        })
        self.view?.notificationData(model: notification)
    }
}

 // MARK: Notification module interface

extension NotificationPresenter: NotificationModuleInterface {
    func getNotification() {
        interactor?.fetchNotification()
    }

}

// MARK: Notification interactor output interface

extension NotificationPresenter: NotificationInteractorOutput {
    
    func obtained(success: [NotificationStructure]) {
        self.convert(model: success)
    }
    
    func obtained(error: Error) {
        self.view?.obtained(error: error)
    }
    
    
}
