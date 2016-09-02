//
//  MedalCollectionViewCell.swift
//  DJCollectionViewTest
//
//  Created by linxian on 16/9/1.
//  Copyright © 2016年 DogeJinx. All rights reserved.
//

import UIKit

class MedalCollectionViewCell: UICollectionViewCell {

    @IBOutlet var textLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        
    }

}
