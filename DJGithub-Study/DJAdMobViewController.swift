//
//  DJAdMobViewController.swift
//  DJGithub-Study
//
//  Created by linxian on 16/8/8.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class DJAdMobViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())
        
    }

    
}
