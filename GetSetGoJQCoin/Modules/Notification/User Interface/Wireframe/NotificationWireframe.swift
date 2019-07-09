//
//  NotificationWireframe.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class NotificationWireframe {
     weak var view: UIViewController!
}

extension NotificationWireframe: NotificationWireframeInput {
    
    var storyboardName: String {return "Notification"}
    
    func getMainView() -> UIViewController {
        let service = NotificationService()
        let interactor = NotificationInteractor(service: service)
        let presenter = NotificationPresenter()
        let viewController = viewControllerFromStoryboard(of: NotificationViewController.self)
        
        viewController.presenter = presenter
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        
        self.view = viewController
        return viewController
    }
}
