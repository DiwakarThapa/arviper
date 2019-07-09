//
//  MyCouponsTableViewCell.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import AlamofireImage

class DashboardMyCouponsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var expiryDate: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var logoBorderView: UIView!
    //@IBOutlet weak var couponHalfImage: UIImageView!
    
//    @IBOutlet weak var imgCrop: UIImageView!
    struct constants {
        
    }

    var model:DashboardCouponsViewModel?{
        didSet{
            setupCoupon()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup() {
        
//            self.imgCrop.isHidden = false
//            self.bgView.backgroundColor = UIColor.white
            self.expiryDate.textColor = UIColor.init(hex: "#4E45FD")
            expiryDate.text = "\(GlobalConstants.Localization.expired) \(model?.expiryDate?.convertDate() ?? "")"
       
        if model?.storeName == "" {
             self.title.text = "JQ Navi"
        }else{
            self.title.text = model?.storeName ?? "JQ Navi"
        }
        self.bgView.layer.cornerRadius = 14
        //setupShadow()
        //self.bgView.dropShadow(color:UIColor.gray, opacity: 10, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
        self.logo.rounded()
        self.offerImage.layer.cornerRadius = 8
        self.logoBorderView.layer.borderColor = UIColor.init(hex: "#E8E8E8").cgColor
        self.logoBorderView.layer.borderWidth = 1
        self.logoBorderView.layer.cornerRadius = self.logoBorderView.frame.height / 2
    }
    
    
    func setupShadow(){
    
        bgView.layer.cornerRadius = 10.0
        bgView.layer.masksToBounds = false
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0);
        bgView.layer.shadowOpacity = 0.3
        
    }
    
    func setupCoupon() {
        setup()
        
        if let url = URL.init(string: model?.image ?? "") {
            offerImage.af_setImage(withURL: url, placeholderImage: UIImage(named: "defaultLogo"))
        }else{
            offerImage.image = UIImage(named: "defaultLogo")
        }
        
        if let url = URL.init(string: model?.logo ?? "") {
             logo.af_setImage(withURL: url, placeholderImage: UIImage(named: "defaultLogo"))
        }else{
            logo.image = UIImage(named: "defaultLogo")
        }

        //title.text = model?.store
        subTitle.text = model?.subtitle
    }
    

}