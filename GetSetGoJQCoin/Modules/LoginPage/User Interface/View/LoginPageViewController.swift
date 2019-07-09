//
//  LoginPageViewController.swift
//  GetSetGoJQCoin
//
//  Created by Rojan on 23/4/2562 BE.
//Copyright © 2562 ekbana. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Localize_Swift

class LoginPageViewController: UIViewController {
    
    // MARK: Properties
    var style:UIStatusBarStyle = .default
    @IBOutlet weak var loginVIew: UIView!
    var presenter: LoginPageModuleInterface?
    
    // MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordBgView: UIView!
    @IBOutlet weak var usernameBgView: UIView!
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var doYouHaveAnAccount: UILabel!
    @IBOutlet weak var lblPrivacyPolicy: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtUsername: UITextField!
    
    @IBOutlet weak var apiValidationView: UIView!
    @IBOutlet weak var apiValidationLabel: UILabel!
    
    @IBOutlet weak var emailValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
//      self.txtUsername.text = "rozan.shrestha@ekbana.info"
//      self.txtPassword.text = "Rojan123$"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
    
    // MARK: IBActions
    @IBAction func buttonLogin(_ sender: Any) {
        guard let username = txtUsername.text else {return}
        guard let passwword = txtPassword.text else {return}
        presenter?.login(username: username, password: passwword)
    }
    
    @IBAction func buttonForgotPassword(_ sender: Any) {
        guard let url = URL(string: GlobalConstants.WebUrl.forgotPassword) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func buttonSignUp(_ sender: Any) {
        guard let url = URL(string: GlobalConstants.WebUrl.signuUp) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func buttonPrivacyPolicy(_ sender: Any) {
        let policyVc = Router.shared.getWebviewPage()
        policyVc.webUrl = GlobalConstants.WebUrl.privacyPolicy
        policyVc.titleText = GlobalConstants.Localization.privacyPolicy
        self.present(policyVc, animated: true, completion: nil)
    }
    
    // MARK: Other Functions
    private func setup() {
        // all setup should be done here
         setText()
        self.style = .lightContent
        navigationController?.isNavigationBarHidden = true
//        self.usernameBgView.setupCornerRadius()
//        self.passwordBgView.setupCornerRadius()
//        self.loginVIew.layer.cornerRadius = 9
//        self.txtUsername.keyboardType = .emailAddress
//        self.txtUsername.placeholder = GlobalConstants.Localization.email
//        self.txtPassword.placeholder = GlobalConstants.Localization.password
//        self.loginVIew.backgroundColor = GlobalConstants.AppColor.primaryColor
//        self.txtPassword.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked(_:)))
//        scrollView.keyboardDismissMode = .onDrag
    }
    
    @objc func setText() {
        
//        // button signup setup
//        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.foregroundColor: UIColor.white] as [NSAttributedString.Key : Any]
//        let underlineAttributedString = NSAttributedString(string: GlobalConstants.Localization.signUp, attributes: underlineAttribute)
//        btnSignup.setAttributedTitle(underlineAttributedString, for: .normal)
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        buttonLogin(sender)
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        presenter?.facebookLogin()
        
    }
    
    @IBAction func lineLogin(_ sender: Any) {
        presenter?.lineLogin()
    }
    
}

// MARK: LoginPageViewInterface
extension LoginPageViewController: LoginPageViewInterface {
    
    func errorValidation(error: String, type: String) {
        if type == "email"{
            self.emailValidationLabel.isHidden = false
            self.apiValidationLabel.isHidden = true
            self.passwordValidationLabel.isHidden = true
            self.emailValidationLabel.text = error
        }else if type == "password"{
            self.apiValidationLabel.isHidden = true
            self.passwordValidationLabel.isHidden = false
            self.emailValidationLabel.isHidden = true
            self.passwordValidationLabel.text = error
        }else{
            self.apiValidationLabel.isHidden = false
            self.apiValidationLabel.text = error
        }
      //  self.alert(message: error)
    }
    
    func showLoading() {
        self.showProgressHud()
    }
    
    func hideLoading() {
        self.hideProgressHud()
    }
    
    func sucess() {
        
    }
    
    func error(error: Error) {
        
//        self.apiValidationLabel.isHidden = false
//        self.passwordValidationLabel.isHidden = true
//        self.emailValidationLabel.isHidden = true
//        self.apiValidationLabel.text = error.localizedDescription
        self.alert(message: error.localizedDescription)
    }

}

extension LoginPageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonLogin(1)
        return true
    }
    
}
