//
//  SuccessPopUp.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AlamofireImage
class SuccessPopUp: UIView {

 // MARK: IBOutlets
    @IBOutlet weak var PopupView: UIView!
    @IBOutlet weak var OfferImage: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var couponValidLabel: UILabel!
    @IBOutlet weak var lblCouponCode: UILabel!
    @IBOutlet weak var lblOfferDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOfferText: UILabel!
    
    //@IBOutlet weak var couponBgView: UIView!
    //@IBOutlet weak var btnOk: UIButton!
    //@IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var couponBackground: UIImageView!
    @IBOutlet weak var couponCodeTitle: UILabel!
   // @IBOutlet weak var couponSubBg: UIView!
    
    @IBOutlet weak var couponRightView: UIView!
    @IBOutlet weak var couponLeftView: UIView!
    @IBOutlet weak var couponCodeBg: UIView!
    
    
    @IBOutlet weak var lblCouponTitle: UILabel!
    @IBOutlet weak var descBgView: UIView!
    
    
    var didTapOk:(() -> ())?
    var didTapClose:(() -> ())?
    
    var model:CouponClaimedViewModel?{
        didSet{
            setupSuccess()
        }
    }
    
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
        let nib = UINib(nibName: "SuccessPopUp", bundle: bundle)
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20
        if  let popup = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            popup.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            popup.frame = self.bounds
            addSubview(popup)
        }
    }
    
    // MARK: IBActions
    @IBAction func buttonClose(_ sender: Any) {
        self.didTapClose?()
    }
    
    @IBAction func buttonOk(_ sender: Any) {
        self.didTapOk?()
    }

    //MARK: Functions
    func setup(){
        self.couponCodeTitle.text = GlobalConstants.Localization.couponCode
        self.descBgView.border(width: 1.5, color: .white)
//        self.btnOk.setTitle(GlobalConstants.Localization.couponDetails, for: .normal)
//        btnOk.layer.cornerRadius = self.btnOk.frame.height / 2
//        self.bgView.cornerRadius = 15
//        self.couponBgView.cornerRadius = 15
//        self.couponSubBg.dropShadow(color: UIColor.gray, opacity: 10, offSet:CGSize(width: -1, height: 1), radius: 3, scale: true)
        self.couponCodeBg.setGradientBackground(colorTop: UIColor.init(hex: "#6F67FD"), colorBottom: UIColor.init(hex: "#B745F0"))
        self.couponCodeBg.cornerRadius(self.couponCodeBg.frame.height / 2)
    }
    
    func setupSuccess(){
        if let color = model?.color{
            self.couponBackground.tintColor = UIColor.init(hex:"\(color)")
//            self.couponLeftView.backgroundColor = UIColor.init(hex:"\(color)")
//            self.lblOfferText.textColor = UIColor.init(hex:"\(color)")
        }
//            else {
//            self.couponRightView.backgroundColor = GlobalConstants.AppColor.primaryColor
//            self.couponLeftView.backgroundColor = GlobalConstants.AppColor.primaryColor
//            self.lblOfferText.textColor = GlobalConstants.AppColor.primaryColor
//        }
        self.lblCouponTitle.text = model?.title
        self.lblOfferText.text = model?.subTitle
        self.lblDate.text = "Valid Till:\(model?.expiryDate?.convertDate(withFormat: GlobalConstants.DateFormats.couponsDateFormat) ?? "")"
        self.lblCouponCode.text = model?.batchCode
        
        if let logoUrl = URL.init(string: "\(model?.logo ?? "")")
        {
            self.logo.af_setImage(withURL: logoUrl)
        }else{
            self.logo.image = UIImage(named: "defaultLogo")
        }
        
        if let imageUrl = URL.init(string: "\(model?.image ?? "")")
        {
            self.OfferImage.af_setImage(withURL: imageUrl)
        }else{
            self.OfferImage.image = UIImage(named: "defaultLogo")
        }
        
        self.lblOfferDesc.text = model?.subTitle
        self.couponValidLabel.text = "\(GlobalConstants.Localization.expired) \(model?.expiryDate?.convertDate(withFormat: GlobalConstants.DateFormats.couponsDateFormat) ?? "")"
    }
    
}

extension SuccessPopUp {
    
    func present() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        PopupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        //self.alpha = 0
        appDelegate?.window?.addSubview(self)
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut, animations: {() -> Void in
            self.PopupView.transform = CGAffineTransform.identity
            //self.alpha = 1
        }, completion: { _ in
           self.setup()
        })
    }
    
    func dissmiss() {
        self.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() -> Void in
            self.PopupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
}
