//
//  CouponPopup.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/26/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import AlamofireImage
class CouponPopup:UIView {

    
    @IBOutlet weak var descBg: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var imgBackground: UIImageView!
    var didClickOnCoupon:(() -> ())?
    
    var model:CouponViewModel?{
        didSet{
             self.setup()
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
        let nib = UINib(nibName: "CouponPopup", bundle: bundle)
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20
        if  let popup = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            popup.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            popup.frame = self.bounds
            addSubview(popup)
        }
    }

    @IBAction func buttonClose(_ sender: Any) {
        self.dissmiss()
    }
    
    func setup(){
        popupView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapCouponView)))
        setUpCoupon()
    }
    
    func setUpCoupon(){
        lblDesc.text = model?.subtitle
        if let color = model?.color {
            self.imgBackground.tintColor = UIColor.init(hex: "\(color)")
            
        }else{
             self.imgBackground.tintColor = GlobalConstants.AppColor.primaryColor
        }
        
        
        if let url = URL.init(string: model?.image ?? ""){
            self.imgOffer.af_setImage(withURL: url)
        }
        
        if let url = URL.init(string: model?.logo ?? ""){
            self.imgLogo.af_setImage(withURL: url)
        }
        self.lblTitle.text = self.model?.title
        self.lblDate.text = "\(GlobalConstants.Localization.expired) \(self.model?.expiryDate?.convertDate() ?? "")"
        self.descBg.border(width: 1, color: .white)
    }
    
    @objc func didTapCouponView(){
        self.dissmiss()
        self.didClickOnCoupon?()
    }
    
    @IBAction func ButtonOk(_ sender: Any) {
        self.dissmiss()
    }
    
}
extension CouponPopup {
    
    func present() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        popupView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        //self.alpha = 0
        appDelegate?.window?.addSubview(self)
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut, animations: {() -> Void in
            self.popupView.transform = CGAffineTransform.identity
            //self.alpha = 1
        }, completion: { _ in
           
        })
    }
    
    func dissmiss() {
        self.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() -> Void in
            self.popupView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.alpha = 0
            
        }, completion: { _ in
            self.viewContainingController()?.dismiss(animated: true, completion: nil)
            self.removeFromSuperview()
        })
    }
    
}
