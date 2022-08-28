//
//  MainNavigationController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-07-23.
//

import Foundation
import UIKit

class MainNavigationController : UINavigationController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupUI()
    }
    
    func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.2274509804, blue: 0.2392156863, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]

        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
    }
    
    override func viewDidLoad() {
    }
}

extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
    
//    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
//        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
//            popToViewController(vc, animated: animated)
//        }
//    }
}
