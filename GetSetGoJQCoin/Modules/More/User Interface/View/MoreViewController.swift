//
//  MoreViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import Localize_Swift
class MoreViewController: UIViewController {
    
    // MARK: Properties
    struct Constants {
        static let version = "Version"
    }
    
    var menuIcons = [UIImage(named: "coupon"),UIImage(named: "disclaimer"),UIImage(named: "faq"),UIImage(named: "privacy"),UIImage(named: "lang")]
    var menuTitles:[String] = []
    var presenter: MoreModuleInterface?
    let availableLanguages = Localize.availableLanguages()
    //    let availableLanguages = [GlobalConstants.Localization.english,GlobalConstants.Localization.japanese]
    
    // MARK: IBOutlets
    @IBOutlet weak var appVersion: UILabel!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = GlobalConstants.Localization.more
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText(){
        
        self.menuTitles = [GlobalConstants.Localization.achievement,GlobalConstants.Localization.disclaimer,GlobalConstants.Localization.termsAndCondition,GlobalConstants.Localization.privacyPolicy,GlobalConstants.Localization.language]
        self.title = GlobalConstants.Localization.more
        buttonLogout.setTitle(GlobalConstants.Localization.logout, for: .normal)
        tableView.reloadData()
    }
    
    
    // MARK: IBActions
    
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        self.alertWithOkCancel(message: GlobalConstants.Localization.logoutAlert, title: GlobalConstants.Localization.alert, okTitle: GlobalConstants.Localization.logout, style:.alert, cancelTitle: GlobalConstants.Localization.cancel, OkStyle:.default, cancelStyle:.cancel, okAction: {
            self.presenter?.getLogOut()
        })
    }
    
    // MARK: Other Functions
    private func setup() {
        // all setup should be done here
        setText()
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.appVersion.text = currentAppVersion()
//        self.buttonLogout.layer.cornerRadius = self.buttonLogout.frame.height / 2
//        buttonLogout.backgroundColor = GlobalConstants.AppColor.primaryColor
    }
    
    func changeLanguage() {
        
        let actionSheet = UIAlertController(title: nil, message: GlobalConstants.Localization.chooseLanguage, preferredStyle: UIAlertController.Style.actionSheet)
        
        let japaneseAction = UIAlertAction(title: GlobalConstants.Localization.japanese, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            Localize.setCurrentLanguage("ja")
        
//            NotificationCenter.default.post(name: Notification.Name.didHandelAppLanguage, object: nil,userInfo:  ["jp":"Japanese"])
            UserDefaults.standard.setDefaultLanguage(language: "Japanese")
        })
        actionSheet.addAction(japaneseAction)
        let englishAction = UIAlertAction(title: GlobalConstants.Localization.english, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            Localize.setCurrentLanguage("en")
//            NotificationCenter.default.post(name: Notification.Name.didHandelAppLanguage, object:nil, userInfo:  ["en":"English"])
             UserDefaults.standard.setDefaultLanguage(language: "English")
        })
        
        actionSheet.addAction(englishAction)
        
        let cancelAction = UIAlertAction(title: GlobalConstants.Localization.cancel, style: UIAlertAction.Style.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

// MARK: MoreViewInterface
extension MoreViewController: MoreViewInterface {
    
    func showLoading() {
        self.showProgressHud()
    }
    
    func hideLoading() {
        self.hideProgressHud()
    }
    
    func obtained(error: Error) {
        self.alert(message: error.localizedDescription)
    }
    
    func success() {
        
    }
    
}

extension MoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuIcons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell") as! MoreTableViewCell
        cell.menuIcon.image = menuIcons[indexPath.row]
        cell.lblMenu.text = menuTitles[indexPath.row]
        return cell
    }
    
}

extension MoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presenter?.getMyCoupons()
        case 1:
            presenter?.getDislaimer()
        case 2:
            presenter?.getTermsAndContions()
        case 3:
            presenter?.getPrivacyPolicy()
        case 4:
            self.changeLanguage()
        case 5:
            break
//            self.presenter?.getOnboardingPage()
        default:
            break
        }
    }
    
}

extension MoreViewController {
    
    func currentAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "\(Constants.version) \(version)(\(build))"
    }
    
}
