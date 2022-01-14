//
//  SLBeautifyViewController.swift
//  SLTabBarDemo
//
//  Created by SL on 2022/1/10.
//

import UIKit

class SLBeautifyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.blue
        self.navigationItem.title = "美化"
        let button = UIButton()
        button.addTarget(self, action: #selector(jumptoAction(sender: )), for: UIControl.Event.touchUpInside)
        button.setTitle("跳转到下一页面", for: UIControl.State.normal)
        button.backgroundColor = UIColor.green
        button.frame = CGRect(x: 0, y: 0, width: 180, height: 44)
        button.center = self.view.center
        self.view.addSubview(button)
    }

    @objc func jumptoAction(sender: UIButton) {
        
        self.navigationController?.pushViewController(SLBeutifyDetailController(), animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
