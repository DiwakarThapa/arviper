//
//  SortingPopup.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class SortingPopup: UIView {

    //@IBOutlet
    @IBOutlet var sortingPopUpView: UIView!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnExpired: UIButton!
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnRedeemed: UIButton!
    
    @IBOutlet var bgView: UIView!
    var didTapOnAll:(() -> ())?
    var didTapOnExpired:(() -> ())?
    var didTapOnActive:(() -> ())?
    var didTapOnRedeemed:(() -> ())?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        loadFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SortingPopup", bundle: bundle)
        if  let popup = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            popup.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            popup.frame = self.bounds
            addSubview(popup)
        }
    }
    
    //Functions
    func setup(){
        self.btnAll.setTitle(GlobalConstants.Localization.all, for: .normal)
        self.btnActive.setTitle(GlobalConstants.Localization.claimed, for: .normal)
        self.btnExpired.setTitle(GlobalConstants.Localization.expire, for: .normal)
        self.btnRedeemed.setTitle(GlobalConstants.Localization.redeemed, for: .normal)
        self.sortingPopUpView.cornerRadius(20)
        self.bgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dissmissPopup)))
    }
    
    @objc func dissmissPopup(){
        self.dissmiss()
    }
    
    //@IBAction
    @IBAction func buttonAll(_ sender: Any) {
        self.dissmiss()
        self.didTapOnAll?()
    }
    
    @IBAction func buttonExpired(_ sender: Any) {
         self.dissmiss()
        self.didTapOnExpired?()
    }
    
    @IBAction func buttonActive(_ sender: Any) {
         self.dissmiss()
        self.didTapOnActive?()
    }
    
    
    @IBAction func buttonRedeemed(_ sender: Any) {
        self.dissmiss()
        self.didTapOnRedeemed?()
    }
    
}

extension SortingPopup {
    
    func present() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        sortingPopUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        //self.alpha = 0
        appDelegate?.window?.addSubview(self)
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut, animations: {() -> Void in
            self.sortingPopUpView.transform = CGAffineTransform.identity
            //self.alpha = 1
        }, completion: { _ in
            self.setup()
        })
    }
    
    func dissmiss() {
        self.alpha = 1
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {() -> Void in
            self.sortingPopUpView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
}
