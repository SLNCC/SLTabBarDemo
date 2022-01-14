//
//  SLTabBar.swift
//  SLTabBarDemo
//
//  Created by SL on 2022/1/10.
//

import UIKit
import Lottie

protocol SLTabBarDelegate: NSObjectProtocol {
    func tabBar(_ tabBar: SLTabBar, didSelect index: Int)
}

class SLTabBarItem {
    var title: String = ""
    var dataFile: String = ""
    init(title: String, dataFile: String) {
        self.title = title
        self.dataFile = dataFile
    }
}

class SLTabBarButton: UIView {
    
    let animationView = AnimationView()
    let titleLabel = UILabel()
    lazy var redLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = UIColor(red: 1.0, green: 71/255.0, blue: 75/255.0, alpha: 1.0)
        titleLabel.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        titleLabel.layer.cornerRadius = 8.0
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.borderWidth = 1.5
        titleLabel.layer.borderColor = UIColor.white.cgColor
        self.addSubview(titleLabel)
        return titleLabel
    }()
    
    init(tabBarItem: SLTabBarItem) {
        super.init(frame: .zero)
        
        let animation = Animation.named(tabBarItem.dataFile)
        animationView.animation = animation
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit
        titleLabel.text = tabBarItem.title
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        self.addSubview(animationView)
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maxW = self.bounds.size.width
        animationView.frame = CGRect(x: 0, y: 0, width: maxW, height: 32)
        titleLabel.frame = CGRect(x: 0, y: animationView.frame.maxY, width: maxW, height: 17)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTiteColor(color: UIColor?) {
        guard color != titleLabel.textColor else {
            return
        }
        titleLabel.textColor = color
    }
    
    func rePlay() {
        guard !animationView.isAnimationPlaying else {
            return
        }
        currentProgress(0)
        animationView.play()
    }
    
    func currentProgress(_ currentProgress: AnimationProgressTime = 0) {
        animationView.currentProgress = currentProgress
    }
    
    func selectedTitleColor() {
        setTiteColor(color: UIColor(red: 23/255.0, green: 133/255.0, blue: 1.0, alpha: 1.0))
    }
    
    func normalTitleColor() {
        setTiteColor(color: UIColor(red: 81/255.0, green: 81/255.0, blue: 84/255.0, alpha:1.0))
    }
}

class SLTabBar: UIView {
    
    private var tabBarItems: [SLTabBarItem] = []
    weak var mTabBarDelegate: SLTabBarDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(badgeValueAction(noti:)), name: NSNotification.Name("kBadgeAttributeKey"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setTabBarItems(_ items: [SLTabBarItem]) {
        self.tabBarItems = items
        var index = 0
        for item in items {
            let view = SLTabBarButton(tabBarItem: item)
            view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(gr:)))
            view.tag = index
            index += 1
            view.addGestureRecognizer(tap)
            self.addSubview(view)
            self.bringSubviewToFront(view)
        }
    }
    
    @objc func tapAction(gr: UITapGestureRecognizer) {
        guard let aniView = gr.view as? SLTabBarButton else {
            return
        }
        let views = self.getTabBarButtons()
        playAnimation(views: views,seletedTabBarButton: aniView)
        self.mTabBarDelegate?.tabBar(self, didSelect: aniView.tag)
    }
    
    func selectedIndex(index: Int) {
        let views = self.getTabBarButtons()
        guard views.count > 0, views.count > index, index >= 0 else {
            return
        }
        playAnimation(views: views, seletedTabBarButton: views[index])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let views = self.getTabBarButtons()
        guard views.count > 0 else {
            return
        }
        let width: CGFloat = self.frame.size.width / CGFloat(views.count)
        let  height: CGFloat = self.frame.size.height
        for i in  0..<views.count {
            let view = views[i]
            view.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
            
        }
    }
    
    private func getTabBarButtons() -> [SLTabBarButton] {
        return self.subviews.filter({$0 is SLTabBarButton}) as? [SLTabBarButton] ?? []
    }
    
    private func playAnimation(views: [UIView], seletedTabBarButton: SLTabBarButton) {
        for view in views {
            if let tabBarButton = view as? SLTabBarButton {
                if tabBarButton == seletedTabBarButton {
                    tabBarButton.rePlay()
                    tabBarButton.selectedTitleColor()
                }else {
                    tabBarButton.currentProgress(0)
                    tabBarButton.normalTitleColor()
                }
            }
        }
    }
    
    @objc func badgeValueAction(noti: Notification) {
        guard let tabBarItem = noti.object as? UITabBarItem, let index = self.tabBarItems.firstIndex(where: {$0.title == tabBarItem.title}) else {
            return
        }
        executeOnMainThread { [weak self] in
            guard let tabBarButtons = self?.getTabBarButtons() else {
                return
            }
            let range: Range = 0..<tabBarButtons.count
            guard range.contains(index) else {
                return
            }
            let tabBarButton = tabBarButtons[index]
            let redLabel = tabBarButton.redLabel
            guard let badgeValue = tabBarItem.badgeValue, badgeValue.count > 0, badgeValue.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else {
                redLabel.text = nil
                redLabel.isHidden = true
                return
            }
            redLabel.isHidden = false
            let text = ((Int(badgeValue) ?? 0) > 99) ? "99+" : badgeValue
            redLabel.text = text
            var width: CGFloat = redLabel.frame.height
            if text.count == 2 {
                width = 23
            }else if text.count == 3 {
                width = 29
            }
            let centerX: CGFloat = tabBarButton.frame == .zero ? UIScreen.main.bounds.size.width / CGFloat(tabBarButtons.count * 2) : tabBarButton.animationView.centerX
            
            guard centerX != redLabel.frame.minX, width != redLabel.frame.width else {
                return
            }
            redLabel.frame = CGRect(x: centerX + 3.5, y: 4.5, width: width, height: redLabel.frame.height)
        }
    }
    
    private func executeOnMainThread(block: @escaping (() -> Void)) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async(execute: block)
        }
    }
}


struct SLAssociatedKeys {
    static var kBadgeValueKey = "kBadgeValueKey"
    static var kSMViewControllerTitleKey = "kSMViewControllerTitleKey"
}

//MARK: --添加角标
extension UITabBarItem {
    public var badgeValue: String? {
        set {
            objc_setAssociatedObject(self, &SLAssociatedKeys.kBadgeValueKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            NotificationCenter.default.post(name: NSNotification.Name("kBadgeAttributeKey"), object: self)
        }
        get {
            return objc_getAssociatedObject(self, &SLAssociatedKeys.kBadgeValueKey) as? String
        }
    }
    
}

//MARK: -- title
extension UIViewController {
    var title: String? {
        set {
            objc_setAssociatedObject(self, &SLAssociatedKeys.kSMViewControllerTitleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            self.navigationItem.title = newValue
        }
        get {
            return objc_getAssociatedObject(self, &SLAssociatedKeys.kSMViewControllerTitleKey) as? String
        }
    }
}
