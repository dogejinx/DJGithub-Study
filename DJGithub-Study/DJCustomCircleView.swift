//
//  DJCustomCircleView.swift
//  DJGithub-Study
//
//  Created by linxian on 16/9/12.
//  Copyright © 2016年 XianLin. All rights reserved.
//

import UIKit

class DJCustomCircleView: UIView {

    
    var shapeLayer:CAShapeLayer!
    
    //圆形layer
    
    var layer1:CAShapeLayer!
    
    //色卡1
    
    var colors1:[CGColor] = [UIColor.init(red:81/255.0, green:81/255.0, blue:191/255.0, alpha:1).CGColor, UIColor.init(red:201.0/255.0, green:90.0/255.0, blue:110.0/255.0, alpha:1).CGColor]
    
    
    var strokeEndFloat: CGFloat = 0 {
    
        didSet{
        
            layer1.strokeEnd = strokeEndFloat
        
        }
    
    }
    
    override func awakeFromNib() {
    
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 0.5
        
        setUI()
    
    }
    
    func setUI() {
    
        shapeLayer = CAShapeLayer()
    
        shapeLayer.frame = self.bounds
    
        self.layer.addSublayer(shapeLayer)
        
        //创建梯形layer
        
        let leftLayer = CAGradientLayer()
        
        leftLayer.frame = CGRectMake(0, 0, self.bounds.width, self.bounds.height)
        
        leftLayer.colors = colors1
        
        leftLayer.startPoint = CGPointMake(0, 1)
        
        leftLayer.endPoint = CGPointMake(1, 0)
        
        shapeLayer.addSublayer(leftLayer)
        
        
        //创建一个圆形layer
        
        layer1 = CAShapeLayer()
        
        layer1.frame = self.bounds
        
        layer1.path = UIBezierPath(arcCenter:CGPointMake(self.bounds.width/2.0, self.bounds.height/2.0), radius:self.bounds.width/2.0 - 5, startAngle:CGFloat(0), endAngle:CGFloat(2*M_PI), clockwise:true).CGPath
        
        layer1.lineWidth = 5
        
        layer1.lineCap = kCALineCapRound
        
        layer1.lineJoin = kCALineJoinRound
        
        layer1.strokeColor = UIColor.blackColor().CGColor
        
        layer1.fillColor = UIColor.clearColor().CGColor
        
        //根据laery1的layer形状在shaperLayer中截取出来一个layer
        
        shapeLayer.mask = layer1
    
    }
    
    
}
