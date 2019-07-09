//
//  WalkthroughContentViewController.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 1/31/19.
//  Copyright © 2019 rozan. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var subHeadingLabel: UILabel! {
        didSet {
            subHeadingLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var gradientBgView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet var contentImageView: UIImageView!
    
    // MARK: - Properties
    
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
  
   
    func setupData(){
        self.backgroundImage.isHidden = true
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
        switch index {
        case 0,2,3:
            self.backgroundImage.isHidden = false
            self.gradientBgView.isHidden = true
//            addGradientToView(view: gradientBgView, colorTop: UIColor.init(hex: "#1479FB"), colorBottom: UIColor.init(hex: "#E5F0FF"))
           // self.gradientBgView.setGradientBackground(colorTop: UIColor.init(hex: "#1479FB"), colorBottom: UIColor.init(hex: "#E5F0FF"))
            self.backgroundImage.image = UIImage(named: "onboardBg")
        default:
            self.backgroundImage.isHidden = false
            self.gradientBgView.isHidden = true
            self.backgroundImage.image = UIImage(named: "onboardingBg")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientBgView.frame = self.view.bounds
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func addGradientToView(view: UIView, colorTop:UIColor, colorBottom: UIColor)
    {
        //gradient layer
        let gradientLayer = CAGradientLayer()
        
        //define colors
        gradientLayer.colors = [colorBottom.cgColor,    colorTop.cgColor]
        
        //define locations of colors as NSNumbers in range from 0.0 to 1.0
        //if locations not provided the colors will spread evenly
        gradientLayer.locations = [0.0, 1.0]
        
        //define frame
        gradientLayer.frame = view.bounds
        
        //insert the gradient layer to the view layer
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
