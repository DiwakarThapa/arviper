//
//  FcmApiService.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import FirebaseMessaging
import Alamofire

class FcmApiService{
    
    func sendFcmData(){
        guard let token  = Messaging.messaging().fcmToken else {return}
        let url  = "https://us-central1-getsetgojq.cloudfunctions.net/subscribeToTopic"
        let param:[String:Any] = [
            "fcmToken": token,
            "token": GlobalConstants.FcmParam.token,
            "topic": GlobalConstants.FcmParam.topic,
            "id": GlobalConstants.FcmParam.deviceID
        ]
        Authorization.shared.apiRequest(url: url, method: .post, parameters: param, encoding: JSONEncoding.default, header: nil, completion: { (response) in
            do{
                let decoder = JSONDecoder()
                let model = try decoder.decode(SuccessData.self, from: response)
                if model.message != "" {
                    print(model.message ?? "")
                    return
                }
            } catch let error {
            print(error.localizedDescription)
            }
        }) { (error) in

        }
      
    }
}
