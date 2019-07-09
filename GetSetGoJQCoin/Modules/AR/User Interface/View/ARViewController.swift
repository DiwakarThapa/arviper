//
//  ARViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 4/19/19.
//Copyright © 2019 ekbana. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import GoogleMaps
import CoreLocation
import AVFoundation

enum deviceSupportedType{
    case arSupported
    case arNotSupported
}
var defaultSupportedType:deviceSupportedType = .arSupported

class ARViewController: UIViewController {
    
    struct Constants {
        static let distance:Double = 50
        static let couponDistance:Double = 60
    }
    
    enum couponStatus{
        case couponRendering
        case couponClaimed
    }
    var defaultCouponStatus:couponStatus = .couponClaimed
    
    // MARK: Properties
    var presenter: ARModuleInterface?
    var currentLocation: CLLocation?
    let manager = LocationManager.shared
    var couponNode:SCNNode?
    var cameraNode: SCNNode?
    
    var displayCoupon:[CouponViewModel]?{
        didSet{
            self.showCoupon()
        }
    }
    
    var selectedCoupon:CouponViewModel?
    
    var couponModel:[CouponViewModel]?{
        didSet{
            refreshLocation()
        }
    }
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var config = ARWorldTrackingConfiguration()
    // MARK: IBOutlets
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var normalCameraView: UIView!
    
    @IBOutlet weak var couponPosition: UILabel!
    @IBOutlet weak var couponDistance: UILabel!
    
    // MARK: VC's Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager.delegate = self
        self.manager.startLocationUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.manager.stopLocationUpdate()
        self.manager.delegate = nil
        sceneView.session.pause()
    }
    
    // MARK: IBActions
    @IBAction func buttonClose(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.subviews.filter({$0 is CouponPopup}).first?.removeFromSuperview()
        self.dismiss(animated: true, completion: nil)
        self.resetNode()
        
    }
    
    // MARK: Other Functions
    private func setup() {
        self.navigationController?.isNavigationBarHidden = true
        checkArSupport()
        fetchCoupon()
        registerGestureRecognizers()
    }
    
    //MARK: check AR Support
    func checkArSupport() {
        if ARConfiguration.isSupported {
//            self.setUpNoramalCamera()
            self.setupAR()
        }else{
            self.setUpNoramalCamera()
        }
    }
    
    // MARK: setupAR Configuration
    func setupAR(){
    DispatchQueue.main.async {
        self.sceneView.delegate = self
        self.config.worldAlignment = .gravityAndHeading
        self.sceneView.session.run(self.config, options: [.resetTracking, .removeExistingAnchors])
        defaultSupportedType = .arSupported
        self.sceneView.isHidden = false
        self.normalCameraView.isHidden = true
        self.sceneView.showsStatistics = false
        self.sceneView.session.run(self.config)
        }
    }
    
    //MARK : fetch Coupon
    func fetchCoupon(){
        presenter?.fetchCoupon()
    }
    
    //MARK: Scene
    func setupArscene(coupon:UIImage) {
        self.sceneView.delegate = self
        defaultCouponStatus = .couponRendering
        guard let couponScene = SCNScene(named: "art.scnassets/coupon2.dae") else {
            fatalError("Unable to find coupon node")
        }
        guard let baseNode = couponScene.rootNode.childNode(withName: "baseNode", recursively: true) else {
            fatalError("Unable to find baseNode")
        }

        guard let couponNode = baseNode.childNode(withName: "without_rough_edges", recursively: true) else {
            return
        }

        let couponMaterial = SCNMaterial()
        couponMaterial.lightingModel = .physicallyBased
        couponMaterial.diffuse.contents = coupon
        couponNode.geometry?.firstMaterial = couponMaterial
        self.couponNode = couponNode


        if let cameraMatrix = sceneView.pointOfView?.transform{
            couponNode.position = SCNVector3Make(0.0, 0.0, -0.4)
            let couponMatrix = couponNode.transform
            let newCouponMatrix = SCNMatrix4Mult(couponMatrix, cameraMatrix)
            couponNode.transform = newCouponMatrix
        }
        sceneView.scene.rootNode.addChildNode(couponNode)
    }
    
    //MARK : Gesture
    private func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: AR Object Tapped
    @objc func tapped(recognizer :UITapGestureRecognizer) {
        let sceneView = recognizer.view as! ARSCNView
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: [:])
        if !hitResults.isEmpty {
            // this means the node has been touched
            if let _ = hitResults.first {
                let couponId = self.selectedCoupon?.id
                self.presenter?.claimCoupon(id: couponId ?? "")
            }
        }
    }
    
    //MARK: Checking Distance
    private func checkDistance(location: CLLocation) {
        if self.couponModel?.count ?? 0 > 0 {
            let coupons = couponModel?.filter({
                let coordinates = $0.geoCoordinate?.components(separatedBy: ",")
                let latitude:Double = Double(coordinates?.first ?? "") ?? 0
                let longitude:Double  = Double(coordinates?.last ?? "") ?? 0
                let distance = location.distance(from: CLLocation.init(latitude: latitude, longitude: longitude))
                print(distance)
                return distance < Constants.distance
                
            })
            
            if coupons?.count != 0{
                self.displayCoupon = coupons
            }
            print("Nearest Coupons:\(coupons?.count ?? 0)")
        }
        
    }
    
    //MARK: Checking User and Coupon Distance
    func checkDistanceOfCoupon(location:CLLocation){
        let cordinates = selectedCoupon?.geoCoordinate?.components(separatedBy: ",")
        let latitude:Double = Double(cordinates?.first ?? "") ?? 0
        let longitude:Double = Double(cordinates?.last ?? "") ?? 0
        let distance = location.distance(from: CLLocation.init(latitude: latitude, longitude: longitude))
        // self.couponDistance.text = "Coupon Distance\(distance)"
        if distance > Constants.couponDistance{
            self.resetNode()
        }
    }
    
    
    //MARK : select random one coupon for validate
    private func showCoupon(){
        let ramdomNumber = Int.random(in: 0..<(displayCoupon?.count ?? 0))
        let couponId = self.displayCoupon?[ramdomNumber].id ?? ""
        self.selectedCoupon = self.displayCoupon?[ramdomNumber]
        presenter?.validateCoupon(id: couponId)
    }
    
    //MARK refresh current location
    func refreshLocation(){
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] (timer) in
            guard let self = self else {
                timer.invalidate()
                return
            }
            self.manager.startLocationUpdate()
        }
    }
    
    /// MARK: Setup Normal Camera view
    func setUpNoramalCamera(){
        defaultSupportedType = .arNotSupported
        self.normalCameraView.isHidden = false
        self.sceneView.isHidden = true
        fetchCoupon()
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device:captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            normalCameraView.layer.addSublayer(videoPreviewLayer!)
            captureSession?.startRunning()
        } catch {
            print(error)
        }
    }
    
    //MARK: Normal Camera PopupView
    func setupNormalPopup(){
        // self.alert(message: "Normal Coupon PopUp")
        let coupon = CouponPopup(frame: CGRect(x: 0, y: self.view.center.y -  (self.view.frame.width / 2) / 2, width: self.view.frame.width, height: self.view.frame.width / 2))
        coupon.model = self.selectedCoupon
        coupon.didClickOnCoupon = {
            let couponId = self.selectedCoupon?.id
            self.presenter?.claimCoupon(id: couponId ?? "")
        }
        
        coupon.present()
    }
    
    
    
    // MARK: Reset Node
    func resetNode(){
        self.couponNode?.removeFromParentNode()
        self.couponNode = nil
        self.selectedCoupon = nil
    }
    
    func restartSessionWithoutDelete() {
        // Restart session with a different worldAlignment - prevents bug from crashing app
        self.sceneView.session.pause()
        
        self.sceneView.session.run(config, options: [
            .resetTracking,
            .removeExistingAnchors])
    }
    
    
}


// MARK: ARViewInterface
extension ARViewController: ARViewInterface {
    
    func loadNextCoupon() {
        selectedCoupon = nil
        self.manager.startLocationUpdate()
    }
    
    func couponClaimSuccess(model: CouponClaimedViewModel) {
        self.manager.stopLocationUpdate()
        defaultCouponStatus = .couponClaimed
        let popUp = SuccessPopUp()
        popUp.model = model
        popUp.setup()
        popUp.didTapClose = {
            popUp.dissmiss()
            self.dismiss(animated: true, completion: {
                self.resetNode()
            })
            
        }
        popUp.present()
        popUp.didTapOk = {
            popUp.dissmiss()
            self.presenter?.claimedCoupon(id: model.id ?? "")
            self.resetNode()
        }
        
    }
    
    func successCoupon(id: String) {
        if defaultSupportedType == .arSupported{
            let couponTextureView = Texture(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
            couponTextureView.didCouponCreated = { [weak self] coupon in
                self?.setupArscene(coupon: coupon)
            }
           couponTextureView.model = self.selectedCoupon
            
        }else{
            self.setupNormalPopup()
        }
    }
    
    func show(error: Error) {
        self.alert(message: error.localizedDescription, title: GlobalConstants.Localization.alert) {
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func showLoading() {
        self.showProgressHud()
    }
    
    func hideLoading() {
        self.hideProgressHud()
    }
    
    func couponData(model: [CouponViewModel]) {
        self.couponModel = model
    }
    
}

extension ARViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print("Session failed. Changing worldAlignment property.")
        print(error.localizedDescription)
        
        if let arError = error as? ARError {
            switch arError.errorCode {
            case 102:
                config.worldAlignment = .gravity
                restartSessionWithoutDelete()
            default:
                restartSessionWithoutDelete()
            }
        }
    }
    
}


extension ARViewController: LocationDidUpdateDelegate , CLLocationManagerDelegate  {
    
    func didUpdateLocationWithResult(location: CLLocation?, error: Error?) {
        if let location = location {
            self.currentLocation = location
            
            if self.selectedCoupon != nil{
                if defaultCouponStatus == .couponRendering{
                    checkDistanceOfCoupon(location: currentLocation ?? CLLocation(latitude: 0, longitude: 0))
                }else{
                    return
                }
            }else{
                checkDistance(location: currentLocation ?? CLLocation(latitude: 0, longitude: 0))
            }
            print("Found user's location: \(location)")
            //            manager.stopUpdatingLocation()
        }
    }
    
    func didUpdateLocationWithHeading(heading: CLHeading?, error: Error?) {
        if(heading?.trueHeading == -1){
//            self.alert(message: "Please On your Compass Calibration.")
        }
    }
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    func locationAccessDenied() {
        
    }
    
    
    
   
    
}

