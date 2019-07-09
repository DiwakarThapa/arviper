//
//  NotificationTableViewCell.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var imgNotification: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model:NotificationViewModel?{
        didSet{
            setupData()
        }
    }
    
    func setupData(){
        lblTitle.text = model?.title
        lblDate.text = model?.createdAt?.getElapsedInterval()
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        let date = dateFormatter.date(from:model?.createdAt ?? "")!
////        let seconds = date.timeIntervalSince1970
//
//        let date2 = Date(timeIntervalSinceNow: -180)
//        print("Time ago :", date2.getElapsedInterval())
        
        lblSubTitle.text = model?.message
        if let url = URL.init(string: model?.image ?? "") {
            self.imgNotification.af_setImage(withURL: url, placeholderImage: UIImage(named: "defaultLogo"))
        } else {
            self.imgNotification.image = UIImage(named: "defaultLogo")
        }
        
    }
    
    
    func setupDesign(){
    self.imgNotification.layer.cornerRadius = 7
    bgView.layer.cornerRadius = 14
    }



}
