//
//  NotificationApiService.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import Alamofire

protocol NotificationApiService: ApiServiceType, RealmPersistenceType{
    func fetchNotification(page:Int?,limit:Int?,success: @escaping ([NotificationDataList]) -> (), failure: @escaping (Error) -> () )
    func checkNotificationStatus(page:Int?,limit:Int?,success: @escaping ([NotificationDataList]) -> (), failure: @escaping (Error) -> () )
}

extension NotificationApiService{
    
    func fetchNotification(page:Int?, limit:Int?, success: @escaping ([NotificationDataList]) -> (), failure: @escaping (Error) -> () ) {
//        self.apiManager.refresh(success: {
            let url = Configuration.conf.baseURL + "/notifications"
            
            let param:[String:Any] = [
                "page":page ?? 1,
                "limit":limit ?? 15
            ]
            
            self.apiManager.genericApiRequest(url: url, method: .get, parameters: param, encoding: URLEncoding.default, header: nil, completion: { (model: NotificationModel) in
                
                if let data = model.data {
                    UserDefaults.standard.setDefaultNotificationDate(date: data.first?.createdAt ?? "")
                }
                success(model.data ?? [])
                UserDefaults.standard.setNotificationPage(page: model.page ?? "")
                UserDefaults.standard.setNotificationList(count: model.count ?? 0)
                
               
                
            }) { (error) in
                failure(error)
            }
//        }) { (error) in
//            failure(error)
//        }
        
    }
    
    func checkNotificationStatus(page:Int?,limit:Int?,success: @escaping ([NotificationDataList]) -> (), failure: @escaping (Error) -> () ){
//        self.apiManager.refresh(success: {
            let url = Configuration.conf.baseURL + "/notifications"
            
            let defaultDate = UserDefaults.standard.getDefaultNotificationDate()
            let param:[String:Any] = [
                "page":page ?? 1,
                "limit":limit ?? 1,
                "filterDate": defaultDate
            ]
            
            self.apiManager.genericApiRequest(url: url, method: .get, parameters: param, encoding: URLEncoding.default, header: nil, completion: { (model: NotificationModel) in
                success(model.data ?? [])
            }) { (error) in
                failure(error)
            }
//        }) { (error) in
//            failure(error)
//        }
    }
    
    
    
    
    
}
