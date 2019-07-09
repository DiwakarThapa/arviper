//
//  ActiveCouponsTableViewCell.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/15/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class ActiveCouponsTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var model:[DashboardMycouponsViewModel]?{
        didSet{
            collectionView.reloadData()
           setup()
        }
    }
    var didSelectCoupon:((String) -> ())?
    
    struct Constants {
        static let couponCollectionViewCell = "CouponsCollectionViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(){
        registerCouponNib()
        collectionView.dataSource = self
        collectionView.delegate = self
//        self.lblTitle.text = "\(GlobalConstants.Localization.thereAre) \(model?.count ?? 0) \(GlobalConstants.Localization.activeCouponExpireAlert)"
    }
    
    private func registerCouponNib(){
        let nib = UINib.init(nibName: Constants.couponCollectionViewCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Constants.couponCollectionViewCell)
    }

}
extension ActiveCouponsTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.couponCollectionViewCell, for: indexPath) as! CouponsCollectionViewCell
        cell.setup()
        cell.model = self.model?[indexPath.row]
        return cell
    }
    
}

extension ActiveCouponsTableViewCell : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(self.collectionView.frame.width / 3) + 25, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CouponsCollectionViewCell
        self.didSelectCoupon?(cell.model?.id ?? "")
    }
    
}
