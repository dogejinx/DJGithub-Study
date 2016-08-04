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

    init() {
        super.init(nibName:nil, bundle:nil)
    }
    
    init(name: String, url: String) {
        
        self.urlStr = url
        super.init(nibName: nil, bundle: nil)
        self.title = name
        
    }
    
    init(name: String, url: String, backgroundColor: UIColor) {
        
        self.urlStr = url
        super.init(nibName: nil, bundle: nil)
        self.title = name
        self.view.backgroundColor = backgroundColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView = UIWebView(frame: self.view.bounds)
        webView.delegate = self
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
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("DidFinishLoad.\(urlStr)")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
}