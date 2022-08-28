//
//  MyAccountViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-05-30.
//

import UIKit
import WebKit

//Timeline
class MyAccountViewController: UIViewController, WKNavigationDelegate {
    
    var delegate: RevealViewController?
    
    fileprivate var config : SwiftLoader.Config = SwiftLoader.Config()

    fileprivate var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        loadingWebView()
        
        //     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SSGTVBottomBarHidden"), object: nil, userInfo: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(signOut), name: NSNotification.Name(rawValue: "SIGNOUT"), object: nil)
    }
    
    @objc func signOut() {
        
        let alert = UIAlertController(title:"Are you sure logout?",message: "",preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "Cancle", style: .default, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: {
            action in
            
            UserDefaults.standard.removeObject(forKey: "token")
//            self.navigationController?.popToRootViewController(animated: false)
//            self.view.removeFromSuperview()
//            self.navigationController?.viewControllers.removeAll()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "REMOVEVIEW"), object: nil, userInfo: nil)
            
//            let rootVC = self.storyboard?.instantiateViewController(withIdentifier: "LVC") as! LoginViewController
//            self.present(rootVC, animated: false)
            
        })
        alert.addAction(cancle)
        //확인 버튼 경고창에 추가하기
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)

    }
    
    func setUpUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.2274509804, blue: 0.2392156863, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        //self.navigationController?.hideHairline()

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"),
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(moveSide)
        )
        
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        //Custom Backbutton
//        let backButtonImage = UIImage(named: "NavBack icon")
//        navigationController?.navigationBar.backIndicatorImage = backButtonImage
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)

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
    
    func loadingWebView() {
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        
        let url = URL(string: API.ACCOUNT_TIMELINE + API.TOKEN)
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
        
        config.size = 30
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.black
        config.spinnerLineWidth = 2.0
        config.foregroundAlpha = 0.3
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        //webView.addSubview(<#T##view: UIView##UIView#>)
        //spinnerView.beginRefreshing()

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SwiftLoader.hide()

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
