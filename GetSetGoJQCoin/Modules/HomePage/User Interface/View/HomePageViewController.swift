//
//  HomePageViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/17/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import GoogleMaps
import ARKit
import CoreLocation
import RealmSwift

class HomePageViewController: UIViewController {
    
    // MARK: Properties
    struct Constants {
        static let distance:Double = 200
        static let radius:Double = 20
    }
    
    var presenter: HomePageModuleInterface?
    var userLocation = LocationStructure()
    var currentLocation: CLLocation!
    var zoomLevel: Float = 15
    var mapView: GMSMapView!
    var locationManager = LocationManager.shared
    var didZoom = 0
    
    var coupons:[HomePageCouponViewModel]?{
        didSet{
            setupCouponCircle()
          //self.checkDistance(location: currentLocation)
        }
    }
    
    var displayCoupons:[HomePageCouponViewModel]?{
        didSet{
            //setupCouponCircle()
        }
    }
    
    // MARK: IBOutlets
    @IBOutlet weak var googleMapView: UIView!
    @IBOutlet weak var lblAchievements: UILabel!
    @IBOutlet weak var lblStartHunting: UILabel!
    @IBOutlet weak var lblBack: UILabel!
    
    // MARK: VC's Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        setMap()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // mapView.clear()
        self.locationManager.delegate = self
        self.locationManager.startLocationUpdate()
        self.title = "Map View"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.locationManager.stopLocationUpdate()
        self.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: IBActions
    
    @IBAction func buttonMinimize(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openArCamera(_ sender: Any) {
            presenter?.openAR()
    }
    
    @IBAction func buttonMyCoupons(_ sender: Any) {
        presenter?.didTapMyCoupon()
    }
    
    
    // MARK: Other Functions
    private func couponListing() {
        self.userLocation.latitude = currentLocation.coordinate.latitude
        self.userLocation.longitute = currentLocation.coordinate.longitude
        self.presenter?.callCouponListApi(location: userLocation)
    }
    
    private func setup() {
        // all setup should be done here
        setupNavigation()
        setupLocalization()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupLocalization  () {
        self.lblBack.text = GlobalConstants.Localization.back
        self.lblAchievements.text = GlobalConstants.Localization.achievement
        self.lblStartHunting.text = GlobalConstants.Localization.hunt
    }
    
    // MARK: Setup map
    private func setMap() {
        let mapView = GMSMapView.init(frame: self.googleMapView.bounds)//.map(withFrame: self.googleMapView.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mapView = mapView
        self.googleMapView.addSubview(mapView)
    }
    
    // MARK: Animate camera
    private func animateCamera(location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,longitude: location.coordinate.longitude, zoom: zoomLevel, bearing: 0,viewingAngle: 0)
        let update = GMSCameraUpdate.setCamera(camera)
        mapView.animate(with: update)
    }
    
    // MARK: setup circle coupons on map
    func setupCouponCircle(){
        coupons?.forEach({
            self.mapView.setupBoundary(geoCoordinate: $0.geoCoordinate ?? "")
        })
    }
    
    // MARK: setup Navigation
    private func setupNavigation(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(handelMoreAction))
    }
    
    @objc func handelMoreAction(){
        self.presenter?.didTapMore()
    }
    
    ///MARK: Checking Distance
    private func checkDistance(location: CLLocation) {
        if let couponData = self.coupons {
            let coupons = couponData.filter({
                let coordinates = $0.geoCoordinate?.components(separatedBy: ",")
                let latitude:Double = Double(coordinates?.first ?? "") ?? 0
                let longitude:Double  = Double(coordinates?.last ?? "") ?? 0
                let distance = location.distance(from: CLLocation.init(latitude: latitude, longitude: longitude))
                 print(distance)
                return distance < Constants.distance

            })
            
            if self.coupons?.count != 0{
            self.displayCoupons = coupons
            print(coupons.count)
            }
        }
        
        
    }
    
}

// MARK: HomePageViewInterface
extension HomePageViewController: HomePageViewInterface {
    
    func coupons(model: [HomePageCouponViewModel]) {
        self.coupons = model
    }
    
    func error(_ error: Error) {
        self.alert(message: error.localizedDescription)
    }
    
    func sucess() {
        self.alert(message: "Logout successful!")
    }
    
    
    func showLoading() {
        self.showProgressHud()
    }
    
    func hideLoading() {
        self.hideProgressHud()
    }

}



//MARK: CLLocationManagerDelegate
extension HomePageViewController: LocationDidUpdateDelegate , CLLocationManagerDelegate {
    
    func didUpdateLocationWithResult(location: CLLocation?, error: Error?) {
        let oldLocation = self.currentLocation
        self.currentLocation = location
        if oldLocation == nil{
            self.animateCamera(location: currentLocation)
            couponListing()
        }
        
    }
    
    func didUpdateLocationWithHeading(heading: CLHeading?, error: Error?) {
        
    }
    
    func locationAccessDenied() {
        
    }

}

extension UIViewController {
    
    func customBack() {
        let imgBackArrow = UIImage(named: "leftBack")
        navigationController?.navigationBar.backIndicatorImage = imgBackArrow
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBackArrow
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }

}


