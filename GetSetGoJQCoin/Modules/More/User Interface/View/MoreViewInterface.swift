//
//  MoreViewInterface.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol MoreViewInterface: class {
    func showLoading()
    func hideLoading()
    func obtained(error:Error)
    func success()
}
