//
//  UIImage+extesion.swift
//  SLTabBarDemo
//
//  Created by SL on 2022/1/10.
//

import UIKit


extension UIImage {
    
    class func imageWithColor(_ color: UIColor ,size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size:size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
