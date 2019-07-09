//
//  NotificationInteractorIO.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol NotificationInteractorInput: class {
    func fetchNotification()
}

protocol NotificationInteractorOutput: class {
    func obtained(success:[NotificationStructure])
    func obtained(error:Error)

}
