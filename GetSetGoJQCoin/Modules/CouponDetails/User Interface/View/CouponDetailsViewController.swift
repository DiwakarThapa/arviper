//
//  CouponDetailsViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/2/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import AlamofireImage
class CouponDetailsViewController: UIViewController {
    
    // MARK: Properties
    var presenter: CouponDetailsModuleInterface?
    
    var model:CouponDetailsViewModel?{
        didSet{
//            setupNav()
            setupCouponBgColor()
            setupCouponDetailsData()
        }
    }
    
    // MARK: IBOutlets
    
    
    @IBOutlet weak var btnRedeem: UIButton!
    @IBOutlet weak var changeColor2: UIImageView!
    @IBOutlet weak var changeColor1: UIImageView!
    //  @IBOutlet weak var doyouWantRedeem: UIButton!
    @IBOutlet weak var couponCodeTitle: UILabel!
    
    @IBOutlet weak var lblCompanyTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
//    @IBOutlet weak var logoBgView: UIView!
    
    @IBOutlet weak var imgCoupon: UIImageView!
//    @IBOutlet weak var couponDetailsView: UIView!
    
    
    @IBOutlet weak var lblOfferTitle: UILabel!
    @IBOutlet weak var lblOfferSubTitle: UILabel!
    @IBOutlet weak var lblExpDate: UILabel!
    
    
//    @IBOutlet weak var couponBgView: UIView!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var lblCoupon: UILabel!
    
//    @IBOutlet weak var redeemStackView: UIStackView!
//    @IBOutlet weak var btnRedeem: UIButton!
    
    
//    @IBOutlet weak var btnShowRedeem: UIButton!
    
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaultNav()
    }
    
    // MARK: IBActions
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonRedeem(_ sender: Any) {
        
        self.alertWithTextField(title: "Alert", message: "Please enter shop code",placeHolder: "shop code", okTitle: "OK", cancelTitle: "Cancel", okCompletion: { (code) in
            self.presenter?.couponRedeem(id: self.model?.code ?? "",shopCode: code)
        })
        
        
    }

    @IBAction func showHideRedeemButton(_ sender: Any) {
        UIView.animate(withDuration: 0.2) {
//           self.redeemStackView.isHidden = false
        }
    }
    
    // MARK: Other Functions
    private func setup() {
        // all setup should be done here
     setupCouponBgColor()
        self.navigationController?.isNavigationBarHidden = true
//        self.btnRedeem.setTitle(GlobalConstants.Localization.redeemCoupon, for: .normal)
//        self.doyouWantRedeem.setTitle(GlobalConstants.Localization.redeemAlerMessage, for: .normal)
        self.couponCodeTitle.text = GlobalConstants.Localization.couponCode
//        self.redeemStackView.isHidden = true
//        self.btnRedeem.backgroundColor = GlobalConstants.AppColor.primaryColor
        self.presenter?.fetchCouponDetails()
//        self.couponBgView.cornerRadius(9)
        self.imgCoupon.cornerRadius(14)
//        self.couponDetailsView.cornerRadius(14)
//        self.btnRedeem.capsuled()
        self.imgLogo.rounded()
        self.imgLogo.layer.borderWidth = 1
        self.imgLogo.layer.borderColor = UIColor.init(hex: "#E8E8E8").cgColor
        
    }
    
    func setupCouponDetailsData(){
        
        if let url = URL.init(string: self.model?.image ?? "") {
            self.imgCoupon.af_setImage(withURL: url, placeholderImage:UIImage(named: "defaultLogo"))
        }else{
            self.imgCoupon.image = UIImage(named: "defaultLogo")
        }
        
        if let url = URL.init(string: self.model?.logo ?? "") {
            self.imgLogo.af_setImage(withURL: url, placeholderImage:UIImage(named: "defaultLogo"))
        }else{
            self.imgLogo.image = UIImage(named: "defaultLogo")
        }
        
        self.lblOfferTitle.text = model?.title
        self.lblCoupon.text = model?.batchCode
        if model?.store == ""{
            self.lblCompanyTitle.text = "JQ Navi"
        }else{
             self.lblCompanyTitle.text = model?.store ?? "JQ Navi"
        }
        self.lblOfferSubTitle.text = model?.subtitle
        self.qrCodeImageView.image = model?.code?.qrCode
        
        if  self.model?.status == "REDEEMED" {
            self.lblExpDate.text = "\(GlobalConstants.Localization.redeemedOn) \(model?.redeemedDate?.convertDate() ?? "")"
            self.lblExpDate.textColor = UIColor.init(hex: "#27B844")
            self.btnRedeem.isHidden = true
        
        }else if self.model?.status == "EXPIRED"{
            self.lblExpDate.text = "\(GlobalConstants.Localization.expiredOn) \(model?.expiryDate?.convertDate() ?? "")"
            self.lblExpDate.textColor = UIColor.red
             self.btnRedeem.isHidden = true
        }else{
             self.lblExpDate.text = "\(GlobalConstants.Localization.expired) \(model?.expiryDate?.convertDate() ?? "")"
             self.btnRedeem.isHidden = false
             self.lblExpDate.textColor = UIColor.init(hex: "#4E45FD")
        }
        
    }
    
    func setupCouponBgColor(){
        self.title = GlobalConstants.Localization.couponDetails
        if let color = model?.color{
            self.changeColor1.tintColor = UIColor.init(hex: color)
            self.changeColor2.tintColor = UIColor.init(hex: color)
        }
    }
    
    func defaultNav(){
        self.navigationController?.navigationBar.barTintColor = GlobalConstants.AppColor.secondaryColor
    }
    
}

// MARK: CouponDetailsViewInterface
extension CouponDetailsViewController: CouponDetailsViewInterface {
    
    func success(message: String) {
        self.presenter?.successPopup(message: message)
    }
    
    func success(model: CouponDetailsViewModel) {
        self.model = model
    }
    
    func showLoading() {
        self.showProgressHud()
    }
    
    func hideLoading() {
        self.hideProgressHud()
    }
    
    func show(error: Error) {
        self.alert(message: error.localizedDescription)
    }

}




