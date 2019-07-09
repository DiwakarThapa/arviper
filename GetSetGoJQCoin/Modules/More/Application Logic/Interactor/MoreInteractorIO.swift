//
//  MoreInteractorIO.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

protocol MoreInteractorInput: class {

    func logOutAction()
    
}

protocol MoreInteractorOutput: class {
    
    func obtained()
    func obtained(error:Error)

}

