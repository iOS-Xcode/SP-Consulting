//
//  WebViewController.swift
//  SP Consulting
//
//  Created by Seokhyun Kim on 2022-07-23.
//

import Foundation
import UIKit
import WebKit

class WebViewController : UIViewController, WKNavigationDelegate {
    
    fileprivate var config : SwiftLoader.Config = SwiftLoader.Config()

    fileprivate var webView: WKWebView!

    var url : String? = nil

    
    override func viewDidLoad() {
        let url = URL(string: url! + API.TOKEN)
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
        
        config.size = 30
        config.backgroundColor = UIColor.clear
        config.spinnerColor = UIColor.black
        config.spinnerLineWidth = 2.0
        config.foregroundAlpha = 0.3

    }
    
    override func viewWillAppear(_ animated: Bool) {
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
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
}

