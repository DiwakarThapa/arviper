//
//  DashboardViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/9/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import GoogleMaps
import RealmSwift
import Localize_Swift
class DashboardViewController: UIViewController {
    
    // MARK: Properties
    struct Constants {
        static let mapTableViewCell = "MapTableViewCell"
        static let activityTableViewCell = "ActiveCouponsTableViewCell"
        static let mycouponsTableViewCell = "DashboardMyCouponsTableViewCell"
        static let sectionHeaderCell = "SectionHeaderTableViewCell"
        static let viewAllCell = "ViewAllCouponsTableViewCell"
//        static let sectionHeaderTitle = [GlobalConstants.Localization.nearByCoupons,"\(GlobalConstants.Localization.thereAre) \(GlobalConstants.Localization.validCouponsLeft)"]
    }
    
    private let refreshControl = UIRefreshControl()
    var presenter: DashboardModuleInterface?
    var userLocation = LocationStructure()
    var currentLocation:CLLocation?
    var locationManager = LocationManager.shared
    var mapCell:MapTableViewCell?
    var notificationStatus:Bool = false
    var profileClick: Bool = false
    
    var myCoupons:[DashboardMycouponsViewModel]?{
        didSet{
            self.refreshControl.endRefreshing()
//            getClaimedCoupons()
            getExpiryCoupons()
            tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
//            tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
        }
    }
    
    var coupons:[DashboardCouponsViewModel]?{
        didSet{
            self.refreshControl.endRefreshing()
             tableView.reloadSections(IndexSet(arrayLiteral: 0,2), with: .automatic)
            self.getNearest(location: currentLocation!)
        }
    }
    
    var claimedCoupons:[DashboardMycouponsViewModel]?
    var expiryCoupons:[DashboardMycouponsViewModel]?
    
    var nearestCoupons:[DashboardCouponsViewModel]?{
        didSet{
            tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
        }
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIButton!
    
    @IBOutlet weak var floatingButtonContainer: UIView!
    @IBOutlet weak var floatingBg: UIView!
    @IBOutlet weak var myCouponBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    
    
    // MARK: VC's Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.title = GlobalConstants.Localization.dashboard
        self.presenter?.getMycouponFromRealm()
        self.couponListing(showLoading: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    // MARK: IBActions
    
    
    @IBAction func profileToggle(_ sender: Any) {
        if profileClick == false{
            profileShowAnimation()
            self.profileClick = true
        }else {
            profileHideAnimation()
            self.profileClick = false
        }
    }
    
    
    @IBAction func buttonMyCoupon(_ sender: Any) {
        self.presenter?.didTapMyCoupons()
    }
    
    
    @IBAction func buttonNotification(_ sender: Any) {
        self.presenter?.didTapNotification()
    }
    
    
    @IBAction func buttonMore(_ sender: Any) {
          self.presenter?.didTapMore()
    }
    
    // MARK: Other Functions
    private func setup() {
        setupProfile()
        
        self.presenter?.checkCurrentNotification()
        // all setup should be done here
        locationManager.delegate = self
        locationManager.startLocationUpdate()
        tableView.dataSource = self
        tableView.delegate = self
        self.registerMapTableViewCell()
        self.registerActiveCouponsCell()
        self.registerMyCouponsCell()
        self.registerViewAllCell()
        self.registerSectionHeader()
        couponListing(showLoading: true)
        presenter?.getMycoupons(showLoading: true)
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
       // setupNavigation()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAllData(_:)), for: .valueChanged)
    }
    
    func setupFloatingButton(){
        floatingBg.cornerRadius(self.floatingBg.frame.width / 2)
    }
    
    
    func setupProfile(){
        self.floatingButtonContainer.isHidden = true
        self.profileImage.layer.borderWidth = 3
        self.profileImage.layer.borderColor = UIColor.init(hex: "#A000F0").cgColor
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
        self.floatingButtonContainer.radiusShadow(color: .gray)
       let profile = UserDefaults.standard.getProfileUrl()
        if let url = URL.init(string: profile){
            self.profileImage.af_setImage(for: .normal, url: url)
       }else {
            self.profileImage.setImage(UIImage(named: "profile"), for: .normal)
        }
        setupFloatingButton()
    }
    
    // profile click animation
    func profileShowAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, options:.transitionCurlDown, animations: {
             self.floatingButtonContainer.isHidden = false
        })
        
    }
    
    func profileHideAnimation () {
        UIView.animate(withDuration: 0.5) {
            self.floatingButtonContainer.isHidden = true
        }
    }
    
    @objc private func refreshAllData(_ sender: Any) {
        // Fetch Coupons data
        couponListing(showLoading: false)
        presenter?.getMycoupons(showLoading: false)
        self.presenter?.checkCurrentNotification()
    }

    private func registerMapTableViewCell(){
        let nib = UINib.init(nibName: Constants.mapTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.mapTableViewCell)
    }
    
    private func registerActiveCouponsCell(){
        let nib = UINib.init(nibName:Constants.activityTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.activityTableViewCell)
    }
    
    private func registerMyCouponsCell(){
        let nib = UINib.init(nibName:Constants.mycouponsTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.mycouponsTableViewCell)
    }
    
    private func registerSectionHeader(){
        let nib = UINib.init(nibName:Constants.sectionHeaderCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.sectionHeaderCell)
    }
    private func registerViewAllCell(){
        let nib = UINib.init(nibName:Constants.viewAllCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.viewAllCell)
    }
    
    private func couponListing(showLoading:Bool) {
        self.currentLocation = self.locationManager.location
        self.userLocation.latitude = currentLocation?.coordinate.latitude
        self.userLocation.longitute = currentLocation?.coordinate.longitude
        self.presenter?.getNearestCoupons(showLoading: showLoading, currentLocation: userLocation)
    }
    
    // MARK: setup Navigation
    private func setupNavigation(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "coupon2"), style: .plain, target: self, action: #selector(handelMyCoupon))
        if notificationStatus{
        let more =  UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(handelMoreAction))
        let notification =  UIBarButtonItem(image: UIImage(named: "showNotification"), style: .plain, target: self, action: #selector(handelNotification))
             navigationItem.rightBarButtonItems = [more, notification]
        }else{
        let more =  UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(handelMoreAction))
        let notification =  UIBarButtonItem(image: UIImage(named: "notification"), style: .plain, target: self, action: #selector(handelNotification))
             navigationItem.rightBarButtonItems = [more, notification]
        }
       
    }
    
    @objc func handelNotification(){
  
    }
    
    @objc func handelMyCoupon(){
        
    }
    
    @objc func handelMoreAction(){
      
    }
    
    func getClaimedCoupons(){
        let filteredCoupons = myCoupons?.filter { $0.status == "CLAIMED" }
        self.claimedCoupons = filteredCoupons
    }
    
    func getDay() -> Int{
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return day
    }
    
    func getExpiryCoupons(){
       
        let expCoupons = myCoupons?.filter{
            let expString = $0.expiryDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let expDate = dateFormatter.date(from:expString ?? "")?.timeIntervalSince1970 ?? 0
            let dayInSecond:Double = 60*60*24
            let date = Date().timeIntervalSince1970 + (dayInSecond * 7)
            return (expDate <= date && $0.status == "CLAIMED")
        }
        self.expiryCoupons = expCoupons
    }
    
    ///MARK: Nearest Coupons
    func getNearest(location: CLLocation) {
        if var couponData = self.coupons {
            couponData = couponData.sorted(by: {
                let firstCoordinates = $0.geoCoordinate?.components(separatedBy: ",")
                let firstLatitude:Double = Double(firstCoordinates?.first ?? "") ?? 0
                let firstLongitude:Double  = Double(firstCoordinates?.last ?? "") ?? 0
                let firstDistance = location.distance(from: CLLocation.init(latitude: firstLatitude, longitude: firstLongitude))
                
                let lastCoordinates = $1.geoCoordinate?.components(separatedBy: ",")
                let lastLatitude:Double = Double(lastCoordinates?.first ?? "") ?? 0
                let lastLongitude:Double  = Double(lastCoordinates?.last ?? "") ?? 0
                let lastDistance = location.distance(from: CLLocation.init(latitude: lastLatitude, longitude: lastLongitude))
                
                return firstDistance < lastDistance
            })
            
            if couponData.count != 0{
                self.nearestCoupons = couponData
            }
        }
        
        
    }
    
    
}

// MARK: DashboardViewInterface
extension DashboardViewController: DashboardViewInterface {
    
    func notification(status: Bool) {
        self.notificationStatus = status
    }
    
    func success(myCoupons: [DashboardMycouponsViewModel]) {
        self.myCoupons = myCoupons
    }
    
    func success(coupons: [DashboardCouponsViewModel]) {
        self.coupons = coupons
    }
    
    func showLoading() {
        self.showProgressHud()
    }
    
    func hideLoading() {
        self.hideProgressHud()
    }
    
    func showError(error: Error) {
        self.alert(message: error.localizedDescription)
    }
    
    func success() {

    }
    
    
}



extension DashboardViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return nearestCoupons?.count ?? 0 > 3 ? 3:0
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
           
            guard let cell = self.mapCell else {
                let mapViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.mapTableViewCell) as! MapTableViewCell
                print("Map Dequeued")
                mapViewCell.coupons = self.coupons
                locationManager.stopLocationUpdate()
                mapViewCell.didTapOnArButton = { [weak self] in
                    self?.presenter?.didTapOnArButton()
                }
                mapViewCell.didTapOnAchievement = { [weak self] in
                   self?.presenter?.didTapMyCoupons()
                }
                
                mapViewCell.didTapOnMap = { [weak self] in
                    self?.presenter?.didTapOnMap()
                }
                //                self.mapCell = mapViewCell
                return mapViewCell
            }
            print("Map Not Dequeued")
            cell.coupons = self.coupons
            cell.searchCouponBtn.setTitle(GlobalConstants.Localization.startHunt, for: .normal)
            return cell
        case 1:
           
            let activeCouponscell = tableView.dequeueReusableCell(withIdentifier: Constants.activityTableViewCell) as! ActiveCouponsTableViewCell
            activeCouponscell.setup()
            activeCouponscell.model = self.expiryCoupons
            activeCouponscell.didSelectCoupon = { [weak self] (couponId) in
                self?.presenter?.didTapOnCoupon(id: couponId)
            }
            return activeCouponscell
            

        case 2:
            let mycouponsCell = tableView.dequeueReusableCell(withIdentifier: Constants.mycouponsTableViewCell) as! DashboardMyCouponsTableViewCell
            mycouponsCell.model = self.nearestCoupons?[indexPath.row]

            return mycouponsCell
        case 3:
            let viewAllCell = tableView.dequeueReusableCell(withIdentifier: Constants.viewAllCell) as! ViewAllCouponsTableViewCell
            viewAllCell.setup()
            viewAllCell.didSelectViewAll = { [weak self] in
                self?.presenter?.didTapOnViewAll()
            }
            return viewAllCell
        default:
            break
        }
        return UITableViewCell()
    }
    
    
}
extension DashboardViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
             return 340
        case 1:
            return expiryCoupons?.count != 0 ? 120 : 0
        case 2:
            return nearestCoupons?.count != 0 ? 170 : 0
        case 3:
            return claimedCoupons?.count != 0 ? 70 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let view = tableView.dequeueReusableCell(withIdentifier: Constants.sectionHeaderCell) as! SectionHeaderTableViewCell
             view.lblSection.text = "\(expiryCoupons?.count ?? 0) \(GlobalConstants.Localization.expiringSoon)"
            return view.contentView
        case 2:
            let view = tableView.dequeueReusableCell(withIdentifier: Constants.sectionHeaderCell) as! SectionHeaderTableViewCell
            view.lblSection.text = "Nearby Coupons"
            return view.contentView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
             return expiryCoupons?.count != 0 ? 40 : 0
        case 2:
            return claimedCoupons?.count != 0 ? 40 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 2:
//            let cell = tableView.cellForRow(at: indexPath) as! DashboardMyCouponsTableViewCell
//            if let couponId = cell.model?.id {
//                self.presenter?.didTapOnCoupon(id:couponId)
//            }
//        case 3:
//            break
//        default:
//            break
//        }
    }

    
    
}

//MARK: CLLocationManagerDelegate
extension DashboardViewController: LocationDidUpdateDelegate , CLLocationManagerDelegate {
    
    func didUpdateLocationWithResult(location: CLLocation?, error: Error?) {
        self.currentLocation = location
        locationManager.stopLocationUpdate()
    }
    
    func didUpdateLocationWithHeading(heading: CLHeading?, error: Error?) {
        
    }
    
    func locationAccessDenied() {
        
    }
    
}
