//
//  MyAccountViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-30.
//

import UIKit

class MyAccountViewController: UIViewController {
    
    var delegate: RevealViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.2785687149, green: 0.2926630378, blue: 0.3059287369, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"),
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(moveSide)
        )
        
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        //화면 끝에서 다른 쪽으로 패닝하는 제스처를 정의(왼쪽에서 오른쪽으로)
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left //시작 모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft) //뷰에 제스처 객체를 등록
        //중간 위취에서 드래그하는 동작 즉 스와이프를 정의 한다.
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide))
        //방향은 왼쪽
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)
        
    }
    
    @objc func moveSide(_ sender: Any) {
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil)
            } else {
                self.delegate?.closeSideBar(nil)
            }
        }
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
     */
}

/*
extension UINavigationController: UIGestureRecognizerDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
*/
