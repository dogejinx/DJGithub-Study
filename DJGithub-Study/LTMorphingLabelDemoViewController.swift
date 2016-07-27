//
//  LTMorphingLabelDemoViewController.swift
//  DJGithub-Study
//
//  Created by linxian on 16/7/27.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit
import LTMorphingLabel
class LTMorphingLabelDemoViewController: UIViewController {
    
    var morphingLabel: LTMorphingLabel!
    var idx = 0
    let textArray: [String] = ["START", "2STARS", "AIR2", "TITLE", "BILIBILI.KINGPOWER"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton()
        addLabel()
        
    }
    
    func addButton() {
        
        let button = UIButton(type: .Custom)
        let button_Width = UIScreen.mainScreen().bounds.width
        button.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 44, button_Width, 44)
        
        button.setTitle("Change Text", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor.lightGrayColor()
        button.addTarget(self, action: #selector(LTMorphingLabelDemoViewController.nextText), forControlEvents: .TouchUpInside)
        
        view.addSubview(button)
        
    }
    
    func addLabel() {
        
        let label = LTMorphingLabel()
        morphingLabel = label
        label.frame = CGRectMake(0, 0, 100, 40)
        label.center = CGPointMake(UIScreen.mainScreen().bounds.width/2, 200)
        
        label.text = "START"
        label.font = UIFont.systemFontOfSize(20)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.layer.borderColor = UIColor.blackColor().CGColor
        label.layer.borderWidth = 1.0
        
        view.addSubview(label)
        
    }
    
    func randomText() {
        
        let index = randomInRange(0..<5)
        morphingLabel.text = textArray[index]
        
    }
    
    func nextText() {
        
        idx = (idx+1)%5
        morphingLabel.text = textArray[idx]
        
    }
    
    func randomInRange(range: Range<Int>) -> Int {
        
        let count = UInt32(range.endIndex - range.startIndex)
        return Int(arc4random_uniform(count)) + range.startIndex
        
    }
    
}
