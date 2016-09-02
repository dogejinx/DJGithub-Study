//
//  MedalViewController.swift
//  DJCollectionViewTest
//
//  Created by linxian on 16/8/30.
//  Copyright © 2016年 DogeJinx. All rights reserved.
//

import UIKit

let Column:Int = 3
let Cell_Space: CGFloat = 8.0
let Cell_W: CGFloat = (UIScreen.mainScreen().bounds.width - CGFloat(Column + 1) * Cell_Space) / CGFloat(Column)
let Cell_H: CGFloat = Cell_W * 1.8

class MedalViewController: UIViewController {

    // MARK: - Value
    @IBOutlet var collectionView: UICollectionView!
    
    
    // MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "瀑布流"
        
        setupCollectionView()
    }

    func setupCollectionView() {
        
        collectionView.registerNib(UINib.init(nibName: "MedalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MedalCollectionViewCell")
        collectionView.registerClass(MedalHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MedalHeaderCollectionReusableView")
        collectionView.registerClass(MedalFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "MedalFooterCollectionReusableView")
        
//        let layout = MedalFlowLayout()
//        collectionView.collectionViewLayout = layout
    }

}


// MARK: - Delegate
extension MedalViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print("No.\(indexPath.row)")
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
    }
    
}


// MARK: - DataSource
extension MedalViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 30
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MedalCollectionViewCell", forIndexPath: indexPath) as! MedalCollectionViewCell
        
        cell.textLabel.text = "No.\(indexPath.row)"
        
        if indexPath.row % 2 == 0 {
            cell.bgView.backgroundColor = UIColor.lightGrayColor()
        }
        else {
            cell.bgView.backgroundColor = UIColor.grayColor()
        }
        
        return cell
        
    }
    
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//        if kind == UICollectionElementKindSectionHeader {
//            
//            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "MedalHeaderCollectionReusableView", forIndexPath: indexPath) as! MedalHeaderCollectionReusableView
//            header.backgroundColor = UIColor.redColor()
//            
//            return header
//            
//        }
//        else if kind == UICollectionElementKindSectionFooter {
//            
//            let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "MedalFooterCollectionReusableView", forIndexPath: indexPath) as! MedalFooterCollectionReusableView
//            footer.backgroundColor = UIColor.whiteColor()
//            
//            return footer
//            
//        }
//        else {
//            
//            return UICollectionReusableView()
//            
//        }
//        
//    }
    

}


// MARK: - Layout
extension MedalViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var a = drand48()
        if a < 0.3 {
            a = 0.3
        }
        
        return CGSizeMake(Cell_W, Cell_H * CGFloat(a + 0.2))
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(Cell_Space, Cell_Space, Cell_Space, Cell_Space)
        
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        
//        return Cell_Space
//        
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        
//        return Cell_Space
//        
//    }
    
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        
//        return CGSizeMake(Cell_W * 3, Cell_Space)
//        
//    }
//    
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        
//        return CGSizeMake(Cell_W * 3, Cell_Space)
//        
//    }
    
    
    
}

