//
//  SLTabBarController.swift
//  SLTabBarDemo
//
//  Created by SL on 2022/1/10.
//

import UIKit

class SLTabBarController: UITabBarController, SLTabBarDelegate {

    private let mTabBar = SLTabBar()
    private var tabBarItems: [SLTabBarItem] = []
    ///阴影线
    let shadeImgeView = UIImageView(image: UIImage(named: "tabBar_shade_line"))
    
    override var selectedIndex: Int {
        didSet {
            mTabBar.selectedIndex(index: selectedIndex)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let standard = self.tabBar.standardAppearance
            standard.shadowColor = UIColor.clear
            standard.shadowImage = UIImage()
            self.tabBar.standardAppearance = standard
        } else {
            self.tabBar.backgroundImage = UIImage.imageWithColor(UIColor.white, size: CGSize(width: 0.5, height: 0.5))
            self.tabBar.shadowImage = UIImage()
        }
        // 添加子控制器
        addChildViewControllers()
        setupTabBar()
        self.selectedIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for subView in self.tabBar.subviews {
            if !(subView == mTabBar || shadeImgeView == subView) {
                subView.removeFromSuperview()
            }
        }
    }
    
    private func setupTabBar() {
        let frame = self.tabBar.frame
        shadeImgeView.frame = CGRect(x: 0, y: -12, width: frame.size.width, height: 12)
        mTabBar.addSubview(shadeImgeView)
        
        mTabBar.backgroundColor = UIColor.white
        mTabBar.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height + kBottomSafeHeight)
        mTabBar.setTabBarItems(tabBarItems)
        mTabBar.mTabBarDelegate = self
        self.tabBar.addSubview(mTabBar)
        self.tabBar.bringSubviewToFront(mTabBar)
    }
    
    /// 添加子控制器
    private func addChildViewControllers() {
        setChildViewController(SLNewsViewController(), title: "头条", dataFile: "new_data")
        setChildViewController(SLFunViewController(), title: "娱乐", dataFile: "fun_data")
        setChildViewController(SLBeautifyViewController(), title: "装饰", dataFile: "beautify_data")
        setChildViewController(SLMyViewController(), title: "我的", dataFile: "my_data")
    }
    
    /// 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, dataFile: String) {
        childController.title = title
        tabBarItems.append(SLTabBarItem(title: title, dataFile: dataFile))
        addChild(SLNavigationController(rootViewController: childController))
    }
    
    //SLTabBarDelegate
    func tabBar(_ tabBar: SLTabBar, didSelect index: Int) {
        if index == selectedIndex {
            if index == 0 {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "DoubleClickTabbarItemNotification")))
            }
        }
        self.selectedIndex = index
    }

}
