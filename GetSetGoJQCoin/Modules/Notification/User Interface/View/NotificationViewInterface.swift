//
//  NotificationViewInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol NotificationViewInterface: class {
    func notificationData(model:[NotificationViewModel])
    func obtained(error:Error)
    func showLoading()
    func hideLoading()
    
}
