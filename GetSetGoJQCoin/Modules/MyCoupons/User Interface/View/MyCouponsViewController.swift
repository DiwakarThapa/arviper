//
//  MyCouponsViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/29/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit

class MyCouponsViewController: UIViewController {
    
    // MARK: Properties
    var presenter: MyCouponsModuleInterface?
    var dropDown: Bool = false
    var myCoupons:[MyCouponsViewModel]?{
        didSet{
            if myCoupons?.count != 0{
                self.noDataAvailable.isHidden = true
                setupNav()
                refreshControl.endRefreshing()
                setupNoDataFound()
                tableView.reloadData()
            }else{
               self.noDataAvailable.isHidden = false
            }
        }
    }
    
    enum SortingTypes:String {
        case all = "all"
        case claimed = "claimed"
        case redeemed = "redeemed"
        case expired = "expire"
    }
    var defaultSortingTypes:SortingTypes = .all
    private let refreshControl = UIRefreshControl()
    // MARK: IBOutlets
    
    @IBOutlet weak var dropIcon: UIImageView!
    @IBOutlet weak var noDataAvailable: UILabel!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNav()
        self.presenter?.fetchMyCoupon(sortType: defaultSortingTypes.rawValue)
        self.title = GlobalConstants.Localization.myCoupons
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    // MARK: IBActions
    
    @IBAction func buttonRedeemed(_ sender: Any) {
        self.defaultSortingTypes = .redeemed
        self.presenter?.fetchMyCoupon(sortType: SortingTypes.redeemed.rawValue)
        self.filterBtn.setTitle("Redeemed", for: .normal)
      hideDropDown()
    }
    @IBAction func buttonExpired(_ sender: Any) {
        self.defaultSortingTypes = .expired
        self.presenter?.fetchMyCoupon(sortType: SortingTypes.expired.rawValue)
          self.filterBtn.setTitle("Expired", for: .normal)
        hideDropDown()
    }
    @IBAction func buttonActive(_ sender: Any) {
        self.defaultSortingTypes = .claimed
        self.presenter?.fetchMyCoupon(sortType: SortingTypes.claimed.rawValue)
        self.filterBtn.setTitle("Claimed", for: .normal)
        hideDropDown()
    }
    @IBAction func buttonAll(_ sender: Any) {
        self.defaultSortingTypes = .all
        self.presenter?.fetchMyCoupon(sortType: SortingTypes.all.rawValue)
        self.filterBtn.setTitle("All", for: .normal)
        hideDropDown()
    }
    
    @IBAction func buttonFilter(_ sender: Any) {
        if dropDown == false {
            showDropDown()
        }else{
            hideDropDown()
        }
    }
    
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Other Functions
    private func setup() {
        // all setup should be done here
       self.navigationController?.isNavigationBarHidden = true
        self.dropDownView.isHidden = true
        setupDropDown()
        self.filterBtn.setTitle("My Coupon", for: .normal)
        self.filterBtn.cornerRadius(self.filterBtn.frame.height / 2)
        self.filterBtn.setGradientBackground(colorTop: UIColor.init(hex: "#A000F0"), colorBottom: UIColor.init(hex: "#6F67FD"))

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerTableCell()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAllData(_:)), for: .valueChanged)
        //self.tableView.estimatedRowHeight = 150
    }
    
    func showDropDown() {
        self.filterBtn.backgroundColor = UIColor.clear
         self.dropDownView.isHidden = false
        self.dropDown = true
        self.dropIcon.image = UIImage(named: "dropUp")
      
    }
    func setupDropDown(){
        self.dropDownView.layer.cornerRadius = 20
        self.dropDownView.setGradientBackground(colorTop:  UIColor.init(hex: "#A000F0"), colorBottom: UIColor.init(hex: "#6F67FD"))
    }
    
    func hideDropDown() {
        self.filterBtn.setGradientBackground(colorTop: UIColor.init(hex: "#A000F0"), colorBottom: UIColor.init(hex: "#6F67FD"))
        self.dropDownView.isHidden = true
        self.dropDown = false
        self.dropIcon.image = UIImage(named: "dropDown")
        
    }
    
    @objc private func refreshAllData(_ sender: Any) {
        defaultSortingTypes = .all
        self.filterBtn.setTitle("All", for: .normal)
       presenter?.refreshMycoupon()
    }
    
    private func setupNoDataFound(){
        if myCoupons?.count == 0{
        self.tableView.isHidden = true
        }else {
        self.tableView.isHidden = false
        }
    }
    
    private func registerTableCell() {
        let nib = UINib.init(nibName: "MyCouponsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MyCouponsTableViewCell")
    }
    
    private func setupNav(){
        self.setTitle("\(GlobalConstants.Localization.myCoupons) (\(defaultSortingTypes.rawValue.localized()))", andImage: UIImage(named: "sorticon") ?? UIImage())
    }
    
}

// MARK: MyCouponsViewInterface
extension MyCouponsViewController: MyCouponsViewInterface {
    
    func success(coupons: [MyCouponsViewModel]) {
        self.myCoupons = coupons
    }
    
    func showLoading() {
        self.showProgressHud()
    }
    
    func hideLoading() {
        self.hideProgressHud()
    }
    
    func error(message: Error) {
        self.alert(message: message.localizedDescription)
    }

}

extension MyCouponsViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return filteredCoupons == nil ? myCoupons?.count ?? 0 : filteredCoupons?.count ?? 0
        return myCoupons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCouponsTableViewCell") as! MyCouponsTableViewCell
        //cell.setup()
        cell.model = self.myCoupons?[indexPath.row]
        return cell
    }
    
}

extension MyCouponsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MyCouponsTableViewCell
        self.presenter?.couponDetails(id: cell.model?.id ?? "")
    }
    
}

extension MyCouponsViewController {
    
    func setTitle(_ title: String, andImage image: UIImage) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)

        let button =  UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        button.setImage(UIImage(named: "sorticon"), for: .normal)
        button.addTarget(self, action: #selector(sortbutton), for: .touchUpInside)
        
        let titleView = UIStackView(arrangedSubviews: [titleLbl,button])
        titleView.axis = .horizontal
        titleView.spacing = 12.0
        let tap = UITapGestureRecognizer(target: self, action: #selector(sortbutton))
        titleView.addGestureRecognizer(tap)
        navigationItem.titleView = titleView
    }
    
    
    @objc func sortbutton(){
        let sortPoup = SortingPopup()
        sortPoup.setup()
        sortPoup.present()
        
        sortPoup.didTapOnAll = { [weak self] in
            self?.defaultSortingTypes = .all
            self?.presenter?.fetchMyCoupon(sortType: SortingTypes.all.rawValue)
            self?.setupNav()
        }
        
        sortPoup.didTapOnActive = { [weak self] in
            self?.defaultSortingTypes = .claimed
            self?.presenter?.fetchMyCoupon(sortType: SortingTypes.claimed.rawValue)
            self?.setupNav()
        }
        
        sortPoup.didTapOnExpired = { [weak self] in
            self?.defaultSortingTypes = .expired
            self?.presenter?.fetchMyCoupon(sortType: SortingTypes.expired.rawValue)
            self?.setupNav()
        }
        sortPoup.didTapOnRedeemed = { [weak self] in
            self?.defaultSortingTypes = .redeemed
            self?.presenter?.fetchMyCoupon(sortType: SortingTypes.redeemed.rawValue)
            self?.setupNav()
        }
    }
}
