//
//  RedeemSuccessPopup.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class RedeemSuccessPopup: UIView {

    @IBOutlet weak var imgCongratulation: UIImageView!
    @IBOutlet weak var popUpView: UIView!
   // @IBOutlet weak var succcessBgView: UIView!
   // @IBOutlet weak var InternalBgView: UIView!
    @IBOutlet weak var lblSuccess: UILabel!
   // @IBOutlet weak var btnOK: UIButton!
    var didClickOk:(() -> ())?
    
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
        let nib = UINib(nibName: "RedeemSuccessPopup", bundle: bundle)
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 20
        if  let popup = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            popup.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            popup.frame = self.bounds
            addSubview(popup)
        }
    }
    
    func setup(){
//        self.InternalBgView.backgroundColor = GlobalConstants.AppColor.primaryColor
//        self.succcessBgView.backgroundColor = GlobalConstants.AppColor.primaryColor
//        self.InternalBgView.cornerRadius(15)
//        self.InternalBgView.border(width: 2, color: UIColor.white)
//        self.succcessBgView.border(width: 2, color: UIColor.white)
//        self.succcessBgView.rounded()
//        self.btnOK.capsuled()
        
    }
    
    @IBAction func buttonOk(_ sender: Any) {
        self.dissmiss()
        self.didClickOk?()
        
    }
}
extension RedeemSuccessPopup {
    
    func present() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        //self.alpha = 0
        appDelegate?.window?.addSubview(self)
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut, animations: {() -> Void in
            self.popUpView.transform = CGAffineTransform.identity
            //self.alpha = 1
        }, completion: { _ in
            self.setup()
        })
    }
    
    func dissmiss() {
        self.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() -> Void in
            self.popUpView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.alpha = 0
            
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
}
