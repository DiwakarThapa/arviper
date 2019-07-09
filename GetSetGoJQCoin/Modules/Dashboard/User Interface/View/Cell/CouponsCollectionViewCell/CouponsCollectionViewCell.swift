//
//  CouponsCollectionViewCell.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/15/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import AlamofireImage
class CouponsCollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet weak var bgView: UIView!
//    @IBOutlet weak var redeemedImage: UIImageView!
//    @IBOutlet weak var offerImage: UIImageView!
//    @IBOutlet weak var cropImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
//    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblExpDate: UILabel!
    @IBOutlet weak var logoBorderView: UIView!
    @IBOutlet weak var logo: UIImageView!
    
    var model:DashboardMycouponsViewModel?{
        didSet{
            setupData()
        }
    }
    
    func setup(){
     
        self.logo.rounded()
        setupShadow()
        self.logoBorderView.layer.borderColor = UIColor.init(hex: "#E8E8E8").cgColor
        self.logoBorderView.layer.borderWidth = 1
        self.logoBorderView.layer.cornerRadius = self.logoBorderView.frame.height / 2
    }
    
    func setupShadow(){
       
    }
    
    func setupData(){
        if model?.title != ""{
        self.lblTitle.text = model?.title ?? "JQ Navi"
        }else{
            self.lblTitle.text = "JQ Navi"
        }
        if let url = URL.init(string: model?.logo ?? ""){
            self.logo.af_setImage(withURL: url, placeholderImage: UIImage(named: "defaultLogo"))
        }else{
            logo.image = UIImage(named: "defaultLogo")
        }
        lblExpDate.text = "\(GlobalConstants.Localization.expired) \(model?.expiryDate?.convertDate() ?? "")"
    }
    

}
