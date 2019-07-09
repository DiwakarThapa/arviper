//
//  UIImage+Extensions.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/8/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import  UIKit

extension UIImage {
    
    func imageWithView(view: UIView) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
//    func imageWithView(view: UIView, completion: @escaping (UIImage?) -> ()) {
//        let size = view.bounds.size
//        DispatchQueue.global().async {
//            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//            DispatchQueue.main.async {
//                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
//            }
//            let img = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            completion(img)
//        }
//    }
    
    func drawImage(startingImage: UIImage) -> UIImage {
        
        // Create a context of the starting image size and set it as the current one
        UIGraphicsBeginImageContext(startingImage.size)
        
        // Draw the starting image in the current context as background
        startingImage.draw(at: CGPoint.zero)
        
        // Get the current context
        let context = UIGraphicsGetCurrentContext()!
        
        // Draw a red line
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.move(to: CGPoint(x: 100, y: 100))
        context.addLine(to: CGPoint(x: 200, y: 200))
        context.strokePath()
        
        // Draw a transparent green Circle
        context.setStrokeColor(UIColor.green.cgColor)
        context.setAlpha(0.5)
        context.setLineWidth(10.0)
        context.addEllipse(in: CGRect(x: 100, y: 100, width: 100, height: 100))
        context.drawPath(using: .stroke) // or .fillStroke if need filling
        
        // Save the context as a new UIImage
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Return modified image
        return myImage ?? UIImage()
    }
}
