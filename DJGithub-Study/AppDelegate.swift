//
//  AppDelegate.swift
//  DJGithub-Study
//
//  Created by linxian on 16/7/27.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewController: UINavigationController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setupAdMob()
        
        let root = ViewController()
        let nav = DJExampleNavController(navigationBarClass: DJExampleNavBar.self, toolbarClass: UIToolbar.self)
        if nav.respondsToSelector(Selector("setAutomaticallyAdjustsScrollViewInsets:")) {
            nav.automaticallyAdjustsScrollViewInsets = false
        }
        nav.pushViewController(root, animated: false)
        
        self.rootViewController = nav
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = self.rootViewController
        self.window?.backgroundColor = UIColor.grayColor()
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: AdMob
    func setupAdMob() {
        
        FIRApp.configure()
        
        GADMobileAds.configureWithApplicationID("ca-app-pub-3940256099942544~1458002511")
        
    }
    
}


class DJExampleNavBar: UINavigationBar {
    
    var previousSize: CGSize? = CGSizeZero
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        var aSize = size
        aSize = super.sizeThatFits(aSize)
        if UIApplication.sharedApplication().statusBarHidden {
            aSize.height = 64
        }
        return aSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !CGSizeEqualToSize(self.bounds.size, previousSize!) {
            previousSize = self.bounds.size
            self.layer.removeAllAnimations()
            self.layer.sublayers?.forEach({ sublayers in
                sublayers.removeAllAnimations()
            })
        }
        
    }
    
    
}

class DJExampleNavController: UINavigationController {
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .Portrait
    }
    
    
}

