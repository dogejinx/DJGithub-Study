//
//  DJTitleButton.swift
//  DJGithub-Study
//
//  Created by linxian on 16/8/3.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit

class DJTitleButton: UIButton {

    var lineType: Int
    
    override init(frame: CGRect) {
        lineType = 1
        super.init(frame: frame)
    }
    
    init(frame: CGRect, lineType: Int) {
        self.lineType = lineType
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, 2.0)
        
        if self.lineType == 0 {
            
            CGContextMoveToPoint(context, 0.0, 18.0) //start at this point
            
            CGContextAddLineToPoint(context, 20.0, 18.0) //draw to this point
            
        }
        else if self.lineType == 2 {
            
            CGContextMoveToPoint(context, 80.0, 18.0) //start at this point
            
            CGContextAddLineToPoint(context, 100.0, 18.0) //draw to this point
            
        }
        else {
            
            CGContextMoveToPoint(context, 0.0, 18.0) //start at this point
            
            CGContextAddLineToPoint(context, 20.0, 18.0) //draw to this point
            
            CGContextMoveToPoint(context, 80.0, 18.0) //start at this point
            
            CGContextAddLineToPoint(context, 100.0, 18.0) //draw to this point
            
        }
        
        // and now draw the Path!
        CGContextStrokePath(context)
        
    }
 

}
