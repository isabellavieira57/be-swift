//
//  WebDocumentationViewController.swift
//  be-swift
//
//  Created by Mariana Meireles on 25/10/17.
//  Copyright © 2017 Isabella Vieira. All rights reserved.
//

import UIKit
import WebKit

class WebDocumentationViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(WebDocumentationViewController.backButton(sender:)))
        
    }
    
    @objc func backButton(sender: UIButton) {
        if(webView.canGoBack){
            webView.goBack()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

