//
//  DJSpaceView.swift
//  DJGithub-Study
//
//  Created by linxian on 16/8/9.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit

class DJSpaceView: UIView {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1).CGColor)
        
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, 1.0)
        
        
        CGContextMoveToPoint(context, 16.0, 18.0) //start at this point
        
        CGContextAddLineToPoint(context, rect.width, 18.0) //draw to this point
        
        // and now draw the Path!
        CGContextStrokePath(context)
        
    }

}
