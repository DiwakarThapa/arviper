//
//  WalkthroughViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 1/31/19.
//  Copyright © 2019 rozan. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
   
    @IBOutlet weak var continueButton: UIButton! {
        didSet{
            setupContinueBtn()
        }
    }
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet var skipButton: UIButton!
    
    // MARK: - Properties
    enum openingStatus{
        case firtTime
        case fromMore
    }
    var defaultOpeningSatus:openingStatus = .firtTime
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    // MARK: - Actions
    
    @IBAction func skipButtonTapped(sender: UIButton) {
        if defaultOpeningSatus == .firtTime{
        let login = LoginPageWireframe()
        let vc = UINavigationController(rootViewController: login.getMainView())
        self.present(vc, animated: true, completion: nil)
        }else{
              self.dismiss(animated: true, completion: nil)
        }

    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
    
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...2:
                walkthroughPageViewController?.forwardPage()
                
            case 3:
                switch sender.tag {
                case 2:
                    if defaultOpeningSatus == .firtTime{
                        UserDefaults.standard.setWalkthrough(value: true)
                        let login = LoginPageWireframe()
                        let vc = UINavigationController(rootViewController: login.getMainView())
                        self.present(vc, animated: true, completion: nil)
                    }else {
                        self.dismiss(animated: true, completion: nil)
                    }
                default:
                    break
                }
                
                
            default: break
            }
        }
        
        updateUI()
    }
    
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...2:
                nextButton.isHidden = false
                btnContinue.isHidden = true
                nextButton.setTitle(GlobalConstants.Localization.next, for: .normal)
                skipButton.setTitle(GlobalConstants.Localization.skip, for: .normal)
                skipButton.isHidden = false
                pageControl.isHidden = false
            
            case 3:
                setupContinueBtn() 
                nextButton.isHidden = true
                btnContinue.isHidden = false
                btnContinue.setTitle(GlobalConstants.Localization.getStarted, for: .normal)
                skipButton.isHidden = true
                pageControl.isHidden = true
                
            default: break
            }
            
            pageControl.currentPage = index
        }
    }
    func setupContinueBtn() {
        btnContinue.layer.cornerRadius = 8.0
        btnContinue.layer.borderWidth = 0.5
        btnContinue.layer.borderColor = UIColor.white.cgColor
        btnContinue.layer.masksToBounds = true
    }
    
    func setupNextButton() {
        nextButton.layer.cornerRadius = 0
        nextButton.layer.borderWidth = 0
        nextButton.layer.borderColor = nil
        nextButton.layer.masksToBounds = true
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    // MARK: - View controller life cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        checkUserStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.setTitle(GlobalConstants.Localization.next, for: .normal)
        skipButton.setTitle(GlobalConstants.Localization.skip, for: .normal)
        self.navigationController?.isNavigationBarHidden = true
    }
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
 

}
