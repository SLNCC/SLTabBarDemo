//
//  SLNewsViewController.swift
//  SLTabBarDemo
//
//  Created by SL on 2022/1/10.
//

import UIKit

class SLNewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.red
        self.title = "kk头条"
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "DoubleClickTabbarItemNotification"), object: nil, queue: OperationQueue.main) { _ in
            print("DoubleClickTabbarItemNotification")
        }
        
        let button = UIButton()
        button.addTarget(self, action: #selector(jumptoAction(sender: )), for: UIControl.Event.touchUpInside)
        button.setTitle("跳转到下一页面", for: UIControl.State.normal)
        button.backgroundColor = UIColor.green
        button.frame = CGRect(x: 0, y: 0, width: 180, height: 44)
        button.center = self.view.center
        self.view.addSubview(button)
    }

    @objc func jumptoAction(sender: UIButton) {
        
        self.navigationController?.pushViewController(SLNewDetailController(), animated: true)
    }
    
}

