//
//  SLNavigationController.swift
//  SLTabBarDemo
//
//  Created by SL on 2022/1/11.
//

import UIKit

class SLNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNaviBarBack()
        self.interactivePopGestureRecognizer?.delegate = self
    }

    func setNaviBarBack() {
        let titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19), NSAttributedString.Key.foregroundColor: UIColor.black]
        let backImage = UIImage(named: "icon_back1")
        let shadowImage = UIImage.imageWithColor(UIColor(hex: "#DDDEE3")!,size: CGSize(width: 0.5, height: 0.5))
        if #available(iOS 15.0, *) {
            let app = UINavigationBarAppearance()
            app.backgroundColor = .white
            app.shadowImage = shadowImage
            app.backButtonAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
            app.titleTextAttributes = titleTextAttributes
            app.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
            self.navigationBar.scrollEdgeAppearance = app
            self.navigationBar.standardAppearance = app
        } else {
            self.navigationBar.backIndicatorImage = backImage
            self.navigationBar.backIndicatorTransitionMaskImage = backImage
            self.navigationBar.titleTextAttributes = titleTextAttributes
            self.navigationBar.backItem?.title = ""
            self.navigationBar.shadowImage = shadowImage
        }
        self.navigationBar.tintColor = .black
        self.navigationBar.isTranslucent = false
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if self.children.count == 1 {
            return false
        }
        return true
    }
    
}
