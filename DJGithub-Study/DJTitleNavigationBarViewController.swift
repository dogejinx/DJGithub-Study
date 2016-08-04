//
//  DJTitleNavigationBarViewController.swift
//  DJGithub-Study
//
//  Created by linxian on 16/8/1.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit

let titleH: CGFloat = 36
let titleW: CGFloat = 100
let navBarH: CGFloat = 64
let maxTitleScale: CGFloat = 1.3
let kDJScreenW = UIScreen.mainScreen().bounds.width
let kDJScreenH = UIScreen.mainScreen().bounds.height
let kDJSpace = (kDJScreenW - titleW) / 2.0

class DJTitleNavigationBarViewController: UIViewController {

    // MARK: Value
    var titleScrollView: UIScrollView?
    var contentScrollView: UIScrollView?
    var selectedTitleButton: UIButton?
    var titleButtonList: [UIButton] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTitleScrollView()
        self.setupContentScrollView()
        self.addChildViewController()
        self.setupTitle()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.contentScrollView?.contentSize = CGSizeMake(CGFloat(self.childViewControllers.count) * kDJScreenW, 0)
        self.contentScrollView?.pagingEnabled = true
        self.contentScrollView?.showsHorizontalScrollIndicator = false
        self.contentScrollView?.delegate = self
        
    }
    
    func setupTitleScrollView() {
        
        let y = self.navigationController != nil ? navBarH : 0
        let rect = CGRectMake(0, y, kDJScreenW, titleH)
        
        titleScrollView = UIScrollView(frame: rect)
        titleScrollView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(titleScrollView!)
        
    }

    func setupContentScrollView() {
        
        let y = CGRectGetMaxY((titleScrollView?.frame)!)
        let rect = CGRectMake(0, y, kDJScreenW, kDJScreenH - navBarH)
        
        contentScrollView = UIScrollView(frame: rect)
        contentScrollView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(contentScrollView!)
        
    }
    
    func addChildViewController() {
        
        let newRect = CGRectMake(0, navBarH + titleH, kDJScreenW, kDJScreenH - (navBarH + titleH))

        let vc  = DJWebViewController(frame: newRect, name: "2016.01", url: "https://www.baidu.com", backgroundColor: UIColor.redColor())
        self.addChildViewController(vc)
        
        let vc1 = DJWebViewController(frame: newRect, name: "2016.02", url: "https://www.zhihu.com", backgroundColor: UIColor.orangeColor())
        self.addChildViewController(vc1)
        
        let vc2 = DJWebViewController(frame: newRect, name: "2016.03", url: "https://www.bilibili.com", backgroundColor: UIColor.yellowColor())
        self.addChildViewController(vc2)
        
        let vc3 = DJWebViewController(frame: newRect, name: "2016.04", url: "https://music.163.com", backgroundColor: UIColor.greenColor())
        self.addChildViewController(vc3)
        
        let vc4 = DJWebViewController(frame: newRect, name: "2016.05", url: "https://www.weibo.com", backgroundColor: UIColor.lightGrayColor())
        self.addChildViewController(vc4)
        
    }
    
    func setupTitle() {
        
        let count = self.childViewControllers.count
        var x: CGFloat = 0
        let w: CGFloat = titleW
        let h = titleH
        var button: UIButton?
        for (i, vc) in self.childViewControllers.enumerate() {
            x = CGFloat(i) * w + kDJSpace
            let rect = CGRectMake(x, 0, w, h)
            let btn = DJTitleButton(frame: rect)
            if i == 0 {
                btn.lineType = 0
            }
            else {
                btn.lineType = 2
            }
            btn.tag = i
            btn.setTitle(vc.title, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(15)
            btn.backgroundColor = UIColor.whiteColor()
            btn.addTarget(self, action: #selector(DJTitleNavigationBarViewController.click(_:)), forControlEvents: .TouchDown)
            
            self.titleButtonList.append(btn)
            self.titleScrollView?.addSubview(btn)
            
            if i == count - 1 {
                button = btn
            }
            
        }
        titleScrollView?.contentSize = CGSizeMake(CGFloat(count) * w + 2 * kDJSpace, 0)
        titleScrollView?.showsHorizontalScrollIndicator = false
        self.click(button!)
    }
    
    func click(btn: UIButton) {
        
        self.selectedTitleBtn(btn)
        
        let i = btn.tag
        let x = CGFloat(i) * kDJScreenW
        
        self.setUpOneChildViewController(i)
        self.contentScrollView?.contentOffset = CGPointMake(x, 0)
        
    }
    
    func selectedTitleBtn(btn: UIButton) {
        
        selectedTitleButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        selectedTitleButton?.transform = CGAffineTransformIdentity
        
        btn.setTitleColor(UIColor(red: 89/255.0, green: 83/255.0, blue: 193/255.0, alpha: 1), forState: .Normal)
//        btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale)
        
        selectedTitleButton = btn
        self.setupTitleCenter(btn)
        
    }
    
    func setUpOneChildViewController(i: Int) {
        
        let x = CGFloat(i) * kDJScreenW
        let vc = self.childViewControllers[i]
        
        if vc.view.superview != nil {
            return
        }
        
        vc.view.frame = CGRectMake(x, 0, kDJScreenW, kDJScreenH - self.contentScrollView!.frame.origin.y)
        
        self.contentScrollView?.addSubview(vc.view)
        
    }
    
    func setupTitleCenter(btn: UIButton) {
        
        var offset: CGFloat = btn.center.x - kDJScreenW * 0.5
        if offset < 0 {
            offset = 0
        }
        let maxOffset = (self.titleScrollView?.contentSize.width)! - kDJScreenW
        if offset > maxOffset {
            offset = maxOffset
        }
        
        self.titleScrollView?.setContentOffset(CGPointMake(offset, 0), animated: true)
        
    }
}


extension DJTitleNavigationBarViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let i: Int = Int((self.contentScrollView?.contentOffset.x)! / kDJScreenW)
        self.selectedTitleBtn(self.titleButtonList[i])
        self.setUpOneChildViewController(i)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        let leftIndex = Int(offsetX / kDJScreenW)
        let rightIndex = Int(leftIndex + 1)
        
        let leftButton = self.titleButtonList[leftIndex]
        var rightButton: UIButton?
        if rightIndex < self.titleButtonList.count {
            rightButton = self.titleButtonList[rightIndex]
        }
        
        let scaleR = offsetX / kDJScreenW - CGFloat(leftIndex)
        
        let scaleL = 1 - scaleR
        
        
//        let transScale = maxTitleScale - 1
//        leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1)
//        rightButton?.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1)
        print("\(leftIndex):\(scaleL), \(rightIndex):\(scaleR)")
        let rightColor = UIColor(red: 89/255.0 * scaleR, green: 83/255.0 * scaleR, blue: 193/255.0 * scaleR, alpha: 1)
        let leftColor = UIColor(red: 89/255.0 * scaleL, green:83/255.0 * scaleL, blue:193/255.0 * scaleL, alpha: 1)
        leftButton.setTitleColor(leftColor, forState: .Normal)
        rightButton?.setTitleColor(rightColor, forState: .Normal)
        
    }
    
    
}