//
//  MedalFlowLayout.swift
//  DJCollectionViewTest
//
//  Created by linxian on 16/9/1.
//  Copyright © 2016年 DogeJinx. All rights reserved.
//

import UIKit

class MedalFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Value
    var delegate: UICollectionViewDelegateFlowLayout?
    var cellCount: Int?
    var colArr: [CGFloat]?
    var attributeDict: [String: NSIndexPath]?
    
    
    // MARK: - Func
    override func prepareLayout() {
        super.prepareLayout()
        
        colArr = []
        attributeDict = [:]
        delegate = self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout
        
        cellCount = self.collectionView?.numberOfItemsInSection(0)
        
        if cellCount == 0 {
            return
        }
        let top: CGFloat = 0
        for _ in 0..<Column {
            colArr?.append(top)
        }
        
        for index in 0..<cellCount! {
            layoutItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0))
        }
        
    }
    
    
    func layoutItemAtIndexPath(indexPath: NSIndexPath) {
        
        let edgeInsets = self.delegate?.collectionView!(self.collectionView!, layout: self, insetForSectionAtIndex: indexPath.row)
        let itemSize = self.delegate?.collectionView!(self.collectionView!, layout: self, sizeForItemAtIndexPath: indexPath)
        var col: Int = 0
        var shortHeight: CGFloat = colArr![col]
        
        for (index, value) in colArr!.enumerate() {
            let height: CGFloat = value
            if height < shortHeight {
                shortHeight = height
                col = index
            }
        }
        let top = colArr![col]
        
        
        let frame = CGRectMake(edgeInsets!.left + CGFloat(col) * (edgeInsets!.left + itemSize!.width), top + edgeInsets!.top, itemSize!.width, itemSize!.height)
        
        colArr![col] = top + (edgeInsets?.top)! + (itemSize?.height)!
        
        let key = NSStringFromCGRect(frame)
        
        attributeDict![key] = indexPath
    }
    
    
    func indexPathsOfItem(rect: CGRect) -> [NSIndexPath] {
        
        var array: [NSIndexPath] = []
        
        for rectStr in attributeDict!.keys {
            let cellRect = CGRectFromString(rectStr)
            if CGRectIntersectsRect(cellRect, rect) {
                if let indexPath = attributeDict![rectStr] {
                    array.append(indexPath)
                }
            }
        }
        
        return array
    }
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var muArr: [UICollectionViewLayoutAttributes] = []
        let indexPaths: [NSIndexPath] = indexPathsOfItem(rect)
        
        for indexPath in indexPaths {
            if let attribute = layoutAttributesForItemAtIndexPath(indexPath) {
                muArr.append(attribute)
            }
        }
        
        return muArr
    }
    
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        for rectStr in attributeDict!.keys {
            if attributeDict![rectStr] == indexPath {
                attributes.frame = CGRectFromString(rectStr)
            }
        }
        
        return attributes
    }
    
    
    override func collectionViewContentSize() -> CGSize {
        var size = self.collectionView?.frame.size
        var maxHeight = colArr![0]
        
        for value in colArr! {
            let colHeight = value
            if colHeight > maxHeight {
                maxHeight = colHeight
            }
        }
        size?.height = maxHeight
        return size!
    }
    
}










