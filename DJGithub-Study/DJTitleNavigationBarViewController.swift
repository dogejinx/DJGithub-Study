//
//  DJTitleNavigationBarViewController.swift
//  DJGithub-Study
//
//  Created by linxian on 16/8/1.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit

struct WebPage {
    
    var pageTitle: String?
    var urlStr: String?
    
    init(title: String, url: String) {
        self.pageTitle = title
        self.urlStr = url
    }
    
}

class DJTitleNavigationBarViewController: UIViewController {

    // MARK: - Value
    var titleScrollView: UIScrollView?
    var contentScrollView: UIScrollView?
    var selectedTitleButton: UIButton?
    var titleButtonList: [UIButton] = []
    var webPageList: [WebPage] = []
    
    var titleH: CGFloat = 36.0
    var titleW: CGFloat = 100.0
    let navBarH: CGFloat = 64
    let kDJScreenW = UIScreen.mainScreen().bounds.width
    let kDJScreenH = UIScreen.mainScreen().bounds.height
    var kDJSpace: CGFloat {
        get {
            return (kDJScreenW - titleW) / 2.0
        }
    }
    var defaultTitleColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
    var selectTitleColor = UIColor(red: 89/255.0, green: 83/255.0, blue: 193/255.0, alpha: 1)
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        initUI()
    }
    
    
    // MARK: - Method
    func initUI() {
        
        if webPageList.count == 0 {
            return
        }
        
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
        titleScrollView?.tag = 1
        titleScrollView?.delegate = self
        titleScrollView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(titleScrollView!)
        
    }

    func setupContentScrollView() {
        
        let y = CGRectGetMaxY((titleScrollView?.frame)!)
        let rect = CGRectMake(0, y, kDJScreenW, kDJScreenH - y)
        
        contentScrollView = UIScrollView(frame: rect)
        contentScrollView?.tag = 2
        contentScrollView?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(contentScrollView!)
        
    }
    
    func addChildViewController() {
        
        for item in webPageList {
            let vc  = DJWebViewController(name: item.pageTitle!, url: item.urlStr!)
            self.addChildViewController(vc)
        }
        
    }
    
    func setupTitle() {
        
        let count = self.childViewControllers.count
        var x: CGFloat = 0
        let w: CGFloat = titleW
        let h = titleH
        
        let lineView = DJSpaceView(frame: CGRectMake(0, 0, kDJSpace, h))
        lineView.backgroundColor = UIColor.whiteColor()
        self.titleScrollView?.addSubview(lineView)
        
        var button: UIButton?
        for (i, vc) in self.childViewControllers.enumerate() {
            x = CGFloat(i) * w + kDJSpace
            let rect = CGRectMake(x, 0, w, h)
            let btn = DJTitleButton(frame: rect)
            if i == 0 && count != 1 {
                btn.lineType = .Left
            }
            else if i == count - 1 && count != 1 {
                btn.lineType = .Right
            }
            else if i > 0 && i < count - 1 {
                btn.lineType = .Both
            }
            
            btn.tag = i
            btn.setTitle(vc.title, forState: .Normal)
            btn.setTitleColor(defaultTitleColor, forState: .Normal)
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
        
        selectedTitleButton?.setTitleColor(defaultTitleColor, forState: .Normal)
        
        btn.setTitleColor(selectTitleColor, forState: .Normal)
        
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
    
    func gradientRGBColor(firstColor: UIColor, secondColor: UIColor, scale: CGFloat) -> UIColor {
        
        let leftComponents = CGColorGetComponents(firstColor.CGColor)
        let rightComponents = CGColorGetComponents(secondColor.CGColor)
        
        let l_R = leftComponents[0]
        let l_G = leftComponents[1]
        let l_B = leftComponents[2]
        
        let r_R = rightComponents[0]
        let r_G = rightComponents[1]
        let r_B = rightComponents[2]
        
        let final_R = (l_R - r_R) * scale + r_R
        let final_G = (l_G - r_G) * scale + r_G
        let final_B = (l_B - r_B) * scale + r_B
        
        return UIColor(red: final_R, green: final_G, blue: final_B, alpha: 1)
    }
    
    
}


// MARK: -
extension DJTitleNavigationBarViewController: UIScrollViewDelegate {
    
    // MARK: - Delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView.tag == 2 {
            
            let i: Int = Int((self.contentScrollView?.contentOffset.x)! / kDJScreenW)
            self.selectedTitleBtn(self.titleButtonList[i])
            self.setUpOneChildViewController(i)
            
        }
        
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.tag == 2 {
            
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
            
            let fColor = selectTitleColor
            let sColor = defaultTitleColor
            
            let rightColor = gradientRGBColor(fColor, secondColor: sColor, scale: scaleR)
            let leftColor = gradientRGBColor(fColor, secondColor: sColor, scale: scaleL)
            
            leftButton.setTitleColor(leftColor, forState: .Normal)
            rightButton?.setTitleColor(rightColor, forState: .Normal)
        
        }
        
        
    }
    
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView.tag == 1 {
            
            print("titleScrollView.DidEndDecelerating")
            let x = scrollView.contentOffset.x + kDJScreenW/2.0
            
            if x < kDJSpace {
                
                click(titleButtonList[0])
                targetContentOffset.memory.x = 0
                targetContentOffset.memory.y = 0
            }
            else if x > kDJSpace + CGFloat(titleButtonList.count) * titleW {
                
                click(titleButtonList[titleButtonList.count-1])
                targetContentOffset.memory.x = scrollView.contentSize.width - kDJScreenW
                targetContentOffset.memory.y = 0
            }
            else {
                
                let delta = ceil((x - kDJSpace) / titleW)
                click(titleButtonList[Int(delta-1)])
                targetContentOffset.memory.x = (delta-1) * titleW
                targetContentOffset.memory.y = 0
            }
        }
    }
    
    
}