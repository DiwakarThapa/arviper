//
//  MapTableViewCell.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/15/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import GoogleMaps
class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var searchCouponBtn: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnAchievement: UIButton!
    
    var didTapOnMap:(() -> ())?
    var didTapOnArButton:(() -> ())?
    var didTapOnAchievement:(() -> ())?
    
    var zoomLevel:Float = 15
   
    
    var coupons:[DashboardCouponsViewModel]? {
        didSet {
            mapView.clear()
            setup()
            self.coupons?.forEach({
                self.mapView.setupBoundary(geoCoordinate: $0.geoCoordinate ?? "", radius: 50)
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "myLocation" {
            DispatchQueue.main.async {
                self.setup()
            }
            mapView.removeObserver(self, forKeyPath: "myLocation")
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.addObserver(self, forKeyPath: "myLocation", options: .new, context: nil)
    }
  
    func setup()
    {
        setMap()
        self.searchCouponBtn.setTitle(GlobalConstants.Localization.hunt, for: .normal)
        self.btnAchievement.setTitle(GlobalConstants.Localization.achievement, for: .normal)
        self.searchCouponBtn.layer.cornerRadius = self.searchCouponBtn.frame.height / 2
        self.animateCamera(location: self.mapView.myLocation ?? CLLocation(latitude: 0, longitude: 0))

    }
    
    // MARK: Setup map
    func setMap() {
        mapView.isUserInteractionEnabled = false
        mapView.isMyLocationEnabled = true
    }
    
    // MARK: Animate camera
    private func animateCamera(location: CLLocation) {
        let camera = GMSCameraPosition.camera(
            withLatitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            zoom: zoomLevel)
        
        let update = GMSCameraUpdate.setCamera(camera)
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
        mapView.animate(with: update)
    }
    
    @IBAction func buttonAchievement(_ sender: Any) {
        self.didTapOnAchievement?()
    }
    
    @IBAction func buttonMaximize(_ sender: Any) {
        self.didTapOnMap?()
    }
    
    @IBAction func buttonSearchCoupon(_ sender: Any) {
        self.didTapOnArButton?()
    }
}


