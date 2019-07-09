//
//  WebViewPageViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class WebViewPageViewController: UIViewController {

    var titleText:String?
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var headerView: UIView!
    var isPresented = false
    var webUrl:String?
    
    @IBOutlet var closeView: UIView!
    @IBOutlet weak var weView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadaddress()
        self.lblTitle.text = titleText
        if isPresented {
            self.navigationItem.hidesBackButton = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action: #selector(self.dismiss(animated:completion:)))
        }
        closeView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(didTapClose)))
        
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func loadaddress(){

        if let url = URL(string: webUrl ?? ""){
                let request = URLRequest(url: url)
                weView.loadRequest(request)
        }
                
    }
    @objc func didTapClose(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension WebViewPageViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //activityIndicator.startAnimating()
        self.showProgressHud()
        NSLog("webview starting to load")
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideProgressHud()
        //activityIndicator.stopAnimating()
        NSLog("webview is done loading")
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        // activityIndicator.isHidden = true
        self.hideProgressHud()
    }
}
