//
//  ViewController.swift
//  DJGithub-Study
//
//  Created by linxian on 16/7/27.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit

let kCellIdentifier = "UITableViewCell"

class ViewController: UITableViewController {
    
    var demoTitleList: [String] = ["LTMorphingLabel", "DJTitleNavigationBarDemo", "DJTitleNavigationBarDemoPro"]
    var demoViewControllerList: [String] = ["LTMorphingLabelDemoViewController", "DJTitleNavigationBarViewController", "DJTitleNavigationBarProViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DJGithub Study"
        self.navigationController?.navigationBarHidden = false
        self.tableView.reloadData()
    }
}

extension ViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            
            let vc = LTMorphingLabelDemoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }
        else if indexPath.row == 1 {
            
            let vc = DJTitleNavigationBarViewController()
            vc.webPageList = [WebPage(title: "2016.01", url: "https://www.bilibili.com"), WebPage(title: "2016.02", url: "https://www.zhihu.com"), WebPage(title: "2016.03", url: "https://www.weibo.com")]
            
            self.navigationController?.pushViewController(vc, animated: true)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }
        else {
            
            let vc = DJTitleNavigationBarProViewController()
//            vc.webPageList = [WebPage(title: "2016.01", url: "https://www.bilibili.com"), WebPage(title: "2016.02", url: "https://www.zhihu.com"), WebPage(title: "2016.03", url: "http://www.dogejinx.com")]
            
            self.navigationController?.pushViewController(vc, animated: true)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }
        
    }
}

extension ViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return demoTitleList.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: kCellIdentifier)
        }
        cell!.textLabel!.text = demoTitleList[indexPath.row]
        return cell!
        
    }
}
