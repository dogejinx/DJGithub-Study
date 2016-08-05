//
//  DJTitleButton.swift
//  DJGithub-Study
//
//  Created by linxian on 16/8/3.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit

enum DJLineType {
    
    case Left
    case Right
    case Both
    case None
}

class DJTitleButton: UIButton {

    var lineType: DJLineType
    
    override init(frame: CGRect) {
        lineType = .None
        super.init(frame: frame)
    }
    
    init(frame: CGRect, lineType: DJLineType) {
        self.lineType = lineType
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1).CGColor)
        
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, 1.0)
        
        if self.lineType == .Left {
            
            CGContextMoveToPoint(context, 100.0 - 16.0, 18.0) //start at this point
            
            CGContextAddLineToPoint(context, 100.0, 18.0) //draw to this point
            
        }
        else if self.lineType == .Right {
            
            CGContextMoveToPoint(context, 0.0, 18.0) //start at this point
            
            CGContextAddLineToPoint(context, 16.0, 18.0) //draw to this point
            
        }
        else if self.lineType == .Both {
            
            CGContextMoveToPoint(context, 0.0, 18.0) //start at this point
            
            CGContextAddLineToPoint(context, 16.0, 18.0) //draw to this point
            
            CGContextMoveToPoint(context, 100.0 - 16.0, 18.0) //start at this point
            
            CGContextAddLineToPoint(context, 100.0, 18.0) //draw to this point
            
        }
        
        // and now draw the Path!
        CGContextStrokePath(context)
        
    }
 

}
