//
//  RevealViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-30.
//

import UIKit

class RevealViewController: UIViewController {
    
    var contentVC: UIViewController?
    var sideVC: UIViewController?
    
    var loginInfo : LoginInfo?

    var isSideBarShowing = false
    
    let SLIDE_TIME = 0.3
    let SIDEBAR_WIDTH: CGFloat = 260
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeSelfView), name: NSNotification.Name(rawValue: "REMOVEVIEW"), object: nil)
    }
    
    @objc func removeSelfView() {
        /*
        self.view.removeFromSuperview()
        //self.navigationController?.viewControllers.removeAll()
        self.navigationController?.removeFromParent()
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
         */

        
        if (navigationController?.viewControllers.count)! > 2 {
            self.navigationController?.popToRootViewController(animated: false)
        } else {
            self.navigationController?.viewControllers.removeAll()
            self.navigationController?.removeFromParent()
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MNC") else {
                return
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
            
        }
    }
    
    func setupView() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MNVC") as? UINavigationController {
            self.contentVC = vc
            
            //각각 따로 등록 뷰 컨트롤러와 뷰끼리.
            self.addChild(vc)
            self.view.addSubview(vc.view)
            //_프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다.
            vc.didMove(toParent: self)
            //Navi의 첫번째 뷰 컨트롤러[0]를 불러온다.
            let frontVC = vc.viewControllers[0] as? MyAccountViewController
            frontVC?.delegate = self
        }
    }
    
    func getSideView() {
        if self.sideVC == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SBVC") {
                self.sideVC = vc
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if (shadow == true) {
            self.contentVC?.view.layer.cornerRadius = 10 //layer 그림자 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8 //그림자 투명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset) //그림자 크기
        } else {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width:0, height:0)
        }
    }
    //complete 매개변수는 사이드바가 열린 다음에 이어서 실행하고 싶은 구문.
    func openSideBar(_ complete: ( () -> Void)? ) {
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2)
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: { self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width:
            self.view.frame.width, height: self.view.frame.height)}, completion: { if $0 == true {
                self.isSideBarShowing = true
                complete?()
                }})
    }
    
    func closeSideBar(_ complete: ( () -> Void)? ) {
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: { self.contentVC?.view.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)}, completion: { if $0 == true {
            //sideVC 제거
            self.sideVC?.view.removeFromSuperview()
            self.sideVC = nil
            self.isSideBarShowing = false
            self.setShadowEffect(shadow: false, offset: 0)
            complete?()
            }})
    }

}
