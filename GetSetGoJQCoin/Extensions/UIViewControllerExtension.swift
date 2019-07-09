//
//  UIViewControllerExtension.swift
//  Sipradi
//
//  Created by bibek timalsina on 5/25/17.
//  Copyright © 2017 Ekbana. All rights reserved.
//

import UIKit
import MBProgressHUD


// MARK: Alerts

extension UIViewController {
    
    func feedbackAlert(title: String?, message: String?, textFieldTitles: [String], okTitle: String, cancelTitle: String, okCompletion: @escaping ([String?]) -> (), cancelAction: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        textFieldTitles.forEach { (textfieldTitle) in
            alert.addTextField(configurationHandler: { (textField) in
                textField.attributedPlaceholder = NSAttributedString(string: textfieldTitle)
                if textfieldTitle.lowercased() == "phone number" {
                    textField.keyboardType = .phonePad
                }
            })
        }
        
        let action = UIAlertAction(title: okTitle, style: .default) { [weak alert] (_) in
            let values = alert?.textFields?.map{$0.text}
            okCompletion(values ?? [])
        }
        alert.addAction(action)
        alert.addAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertWithTextField(title: String, message: String,placeHolder: String, okTitle: String, cancelTitle: String, okCompletion: @escaping (String)->(), cancelAction: (()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.attributedPlaceholder = NSAttributedString(string: placeHolder)
        }
        let action = UIAlertAction(title: okTitle, style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
                okCompletion(textField?.text ?? "")
            })
        
        alert.addAction(action)
        alert.addAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func confirmationAlert(title: String, message: String, confirmTitle: String, style: UIAlertAction.Style = .destructive, confirmAction: @escaping () -> Void) {
        let deleteActionSheetController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: confirmTitle, style: style) {
            action -> Void in
            confirmAction()
        }
        
        let cancelAction = UIAlertAction(title: "Alert".localizedUppercase, style: .cancel) { action -> Void in
            
        }
        
        deleteActionSheetController.addAction(deleteAction)
        deleteActionSheetController.addAction(cancelAction)
        
        self.present(deleteActionSheetController, animated: true, completion: nil)
    }
    
    func alert(message: String?, title: String? = "Alert".localizedUppercase, okAction: (()->())? = nil) {
        let alertController = getAlert(message: message, title: title)
        alertController.addAction(title: "OK".localizedLowercase, handler: okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertWithOkCancel(message: String?, title: String? = "Alert".localizedUppercase, okTitle: String? = "btn_okay".localizedLowercase, style: UIAlertController.Style? = .alert, cancelTitle: String? = "text_cancel".localizedLowercase, OkStyle: UIAlertAction.Style = .default, cancelStyle: UIAlertAction.Style = .default, okAction: (()->())? = nil, cancelAction: (()->())? = nil) {
        let alertController = getAlert(message: message, title: title, style: style)
        alertController.addAction(title: okTitle,style: OkStyle, handler: okAction)
        alertController.addAction(title: cancelTitle, style: cancelStyle, handler: cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func getAlert(message: String?, title: String?, style: UIAlertController.Style? = .alert) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
    }
    
    func present(_ alert: UIAlertController, asActionsheetInSourceView sourceView: Any) {
        if UI_USER_INTERFACE_IDIOM() == .pad {
            alert.modalPresentationStyle = .popover
            if let presenter = alert.popoverPresentationController {
                if sourceView is UIBarButtonItem {
                    presenter.barButtonItem = sourceView as? UIBarButtonItem
                }else if sourceView is UIView {
                    let view = sourceView as! UIView
                    presenter.sourceView = view
                    presenter.sourceRect = view.bounds
                }
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
}


extension UIAlertController {
    func addAction(title: String?, style: UIAlertAction.Style = .default, handler: (()->())? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: {_ in
            handler?()
        })
        self.addAction(action)
    }
}

struct Associate {
    static var hud: UInt8 = 0
    static var empty: UInt8 = 0
}

// MARK: HUD
extension UIViewController {
    
    private func setProgressHud() -> MBProgressHUD {
        let progressHud:  MBProgressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHud.tintColor = UIColor.darkGray
        progressHud.removeFromSuperViewOnHide = true
        objc_setAssociatedObject(self, &Associate.hud, progressHud, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return progressHud
    }
    
    var progressHud: MBProgressHUD {
        if let progressHud = objc_getAssociatedObject(self, &Associate.hud) as? MBProgressHUD {
            progressHud.isUserInteractionEnabled = true
            return progressHud
        }
        return setProgressHud()
    }
    
    var progressHudIsShowing: Bool {
        return self.progressHud.isHidden
    }
    
    func showProgressHud() {
        self.progressHud.show(animated: false)
    }
    
    func hideProgressHud() {
        self.progressHud.label.text = ""
        self.progressHud.completionBlock = {
            objc_setAssociatedObject(self, &Associate.hud, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        self.progressHud.hide(animated: false)
    }
}


@objc protocol Setup {
    @objc optional func setupTabItem()
}

//extension Setup where Self: UIViewController {
//    func setupTabItem() {
//        print("setup tab item")
//    }
//}

extension UIViewController: Setup {
    
    func setupTabItem() {
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 7, left: 0, bottom: -7, right: 0)
    }
    
}


