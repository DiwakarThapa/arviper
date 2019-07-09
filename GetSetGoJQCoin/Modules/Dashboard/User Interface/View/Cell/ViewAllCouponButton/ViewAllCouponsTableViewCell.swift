//
//  ViewAllCouponsTableViewCell.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/15/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class ViewAllCouponsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnViewAll: UIButton!
    var didSelectViewAll:(() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(){
        self.btnViewAll.setTitle(GlobalConstants.Localization.viewAll, for: .normal)
        self.btnViewAll.layer.cornerRadius = self.btnViewAll.frame.height / 2
    }

    @IBAction func buttonViewAll(_ sender: Any) {
        didSelectViewAll?()
    }
}
