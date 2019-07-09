//
//  NotificationViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/20/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: NotificationModuleInterface?
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var bgView: UIView!
    
    var totalCount:Int?
    var fullyLoaded = false
    
    var models:[NotificationViewModel] = [NotificationViewModel](){
        didSet{
            if models.count != 0{
              lblNoDataAvailable.isHidden = true
            }else{
            lblNoDataAvailable.isHidden = false
            }
        }
    }

    
    // MARK: IBOutlets
    
    @IBOutlet weak var lblNoDataAvailable: UILabel!
    // MARK: VC's Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.getNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.models.removeAll()
        super.viewWillDisappear(animated)
        UserDefaults.standard.setNotificationPage(page: "0")
    }
    
    // MARK: IBActions
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: Other Functions
    
    private func setup() {
        // all setup should be done here
        self.navigationController?.isNavigationBarHidden = true
        self.title = GlobalConstants.Localization.notifications
        activityView.isHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAllData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshAllData(_ sender: Any) {
        UserDefaults.standard.setNotificationPage(page: "0")
        fullyLoaded = false
        self.presenter?.getNotification()
    }
    
}

// MARK: NotificationViewInterface
extension NotificationViewController: NotificationViewInterface {
    func showLoading() {
        self.showProgressHud()
    }
    
    func hideLoading() {
        self.hideProgressHud()
    }
    
    func obtained(error: Error) {
        self.alert(message: error.localizedDescription)
    }
    
    func notificationData(model: [NotificationViewModel]) {
        if activityView.isAnimating {
            activityView.stopAnimating()
            if model.isEmpty {
               
                fullyLoaded = true
            }else {
                models += model
                tableView.reloadData()
            }
        }else {
            models = model
          
            tableView.isHidden = model.isEmpty
            activityView.isHidden = model.isEmpty
           
            tableView.reloadData()
            
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
    }
    
    
}

extension NotificationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.setupDesign()
        cell.model = self.models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastSectionIndex = tableView.numberOfSections - 1
//        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
//        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
//            self.didPaginate = true
//            activityView.isHidden = false
//            activityView.startAnimating()
//        }
        if !fullyLoaded && !refreshControl.isRefreshing && !activityView.isAnimating {
            let isLastIndex = indexPath.row == models.count - 1
            if isLastIndex {
                activityView.isHidden = false
                activityView.startAnimating()
                presenter?.getNotification()
            }
        }
    }
    
}

extension NotificationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

