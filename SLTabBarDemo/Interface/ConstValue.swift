//
//  ConstValue.swift
//  SLTabBarDemo
//
//  Created by SL on 2022/1/14.
//

import UIKit


let kIs_iPhoneX: Bool =  UIScreen.main.bounds.size.width >= 360.0 &&  UIScreen.main.bounds.size.height >= 780.0 && UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
let kBottomSafeHeight: CGFloat  = kIs_iPhoneX ? 34.0 : 0.0
