//
//  Texture.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/7/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import AlamofireImage
class Texture: UIView {

    @IBOutlet weak var backExpBgView: UIView!
    @IBOutlet weak var lblBackExpDate: UILabel!
    @IBOutlet weak var backTitle: UILabel!
    @IBOutlet weak var expDate: UILabel!
    @IBOutlet weak var offierTitle: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet var couponBgView: UIView!
    
    @IBOutlet weak var subTitleBorder: UIView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var expBgView: UIView!
    
    @IBOutlet weak var imgCropedBG: UIImageView!
    var didCouponCreated:((UIImage) -> ())?
    var coupon:UIImage = UIImage()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init() {
        super.init(frame: UIScreen.main.bounds)
        loadFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func loadFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Texture", bundle: bundle)
        if  let popup = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            popup.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            popup.frame = self.bounds
            addSubview(popup)
        }
    }
    
    var model:CouponViewModel?{
        didSet{
            setupCoupon()
        }
    }
    
    private func setupCoupon(){
        
        if let color = model?.color {
            self.couponBgView.backgroundColor = UIColor.init(hex: "\(color)")
//            self.offierTitle.textColor = UIColor.init(hex: "\(color)")
            self.imgCropedBG.tintColor = UIColor.init(hex: "\(color)")
            
        }else {
            self.couponBgView.backgroundColor = GlobalConstants.AppColor.primaryColor

        }
        subTitleBorder.border(width: 2, color: .white)
        self.lblSubTitle.text = model?.subtitle
        self.offierTitle.textColor = .white
        self.offierTitle.text = model?.title
        self.backTitle.text = self.model?.subtitle
        self.lblBackExpDate.text = "Valid Till: \(self.model?.expiryDate?.convertDate(withFormat: GlobalConstants.DateFormats.couponsDateFormat) ?? "")"
        self.expDate.text =  "Valid Till: \(self.model?.expiryDate?.convertDate(withFormat: GlobalConstants.DateFormats.couponsDateFormat) ?? "")"
        
        if let url = URL.init(string: model?.image ?? "") {
            self.offerImage.af_setImage(withURL: url) { (response) in
                if let url = URL.init(string: self.model?.logo ?? "") {
                    self.logo.af_setImage(withURL: url) { (response) in
                        self.drawCoupon()
                    }
                }else{
                     self.logo.image = UIImage(named: "defaultLogo")
                    self.drawCoupon()
                }
            }
        }else{
            self.logo.image = UIImage(named: "defaultLogo")
            self.offerImage.image = UIImage(named: "defaultLogo")
            drawCoupon()
        }
        
    }
    
    func drawCoupon(){
//        self.coupon.imageWithView(view: self.couponBgView) { (image) in
//            DispatchQueue.main.async {
//                self.didCouponCreated?(image ?? UIImage())
//            }
//        }
        if let couponImage = self.coupon.imageWithView(view: self.couponBgView){
                self.didCouponCreated?(couponImage)
        }
    }
    
}
