//
//  DJWebViewController.swift
//  DJGithub-Study
//
//  Created by linxian on 16/8/2.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit

class DJWebViewController: UIViewController {

    var webView: UIWebView!
    var urlStr: String?

    
    required init(frame: CGRect, name: String, url: String) {
        
        self.urlStr = url
        super.init(nibName: "UIViewController", bundle: nil)
        self.view.frame = frame
        self.title = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        
        if let urlStr = urlStr {
            let url = NSURL(string: urlStr)
            if let url = url {
                webView.loadRequest(NSURLRequest(URL: url))
            }
        }
    }
}


extension DJWebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("DidStartLoad.\(urlStr)")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
}