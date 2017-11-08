//
//  WebDocumentationViewController.swift
//  be-swift
//
//  Created by Mariana Meireles on 25/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit
import WebKit

class WebDocumentationViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    var url: URL!
    
    override func loadView() {
        super.loadView()
        setupLabel()

        let webViewConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let request = URLRequest(url: url)
        webView.load(request)

        view.addSubview(webView)
    }
    
    func setupLabel() {
        let rectangle = CAShapeLayer()
        rectangle.path = UIBezierPath(rect: UIScreen.changeScale(vector: CGRect(x: 0, y: 0, width: 321, height: 64))).cgPath
        rectangle.fillColor = UIColor(red:0.31, green:0.49, blue:0.95, alpha:1.0).cgColor
        view.layer.addSublayer(rectangle)
        
        let dismissButton = UIButton(image: "exit", frame: CGRect(x: 0, y: 14, width: 50, height: 50), target: self)
        dismissButton.addTarget(target, action: #selector(WebDocumentationViewController.backButton(sender:)), for: UIControlEvents.touchUpInside)
        view.addSubview(dismissButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let widhtiPhoneSE: CGFloat = 320
        let heightiPhoneSE: CGFloat = 568
        let screenSize = UIScreen.main.bounds
        let xScale = screenSize.width/widhtiPhoneSE
        let yScale = screenSize.height/heightiPhoneSE

        webView.frame = CGRect(x: 0, y: 64*yScale, width: 320*xScale, height: 568*yScale)
    }
    
    @objc func backButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

