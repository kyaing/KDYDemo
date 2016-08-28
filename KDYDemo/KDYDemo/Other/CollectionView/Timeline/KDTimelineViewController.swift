//
//  KDTimelineViewController.swift
//  KDYDemo
//
//  Created by zhongye on 16/2/16.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：创建Timeline

import UIKit

/**
 *  一般的Timeline用UITableView就能解决，它们拥有共同的一些特点：元素的种类相同，位置相对固定，
 *  实现时在固定位置插入窄矩形视图当作线条，当节点的圆形可以用图片或代码画出来，基本也就用不上布局。
 *  当一般情况下UITableView不满足条件了，那也只能用UICollectionView布局来做了。
 */

private let reuseIdentifier = "Cell"

class KDTimelineViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var itemCountInSection: [Int] = [2, 5, 4]
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Timeline"
        self.view.backgroundColor = .whiteColor()
    }
    
    //MARK: - UICollectionViewDataSource
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return itemCountInSection.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCountInSection[section]
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        if let imageView = cell.viewWithTag(10) as? UIImageView{
            let Number1 = Int(arc4random_uniform(UInt32(2)))
            let Number2 = Int(arc4random_uniform(UInt32(10)))
            let imageName = "\(Number1)\(Number2).png"
            imageView.image = UIImage(named: imageName)
        }
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var supplementaryView: UICollectionReusableView
        
        if kind == UICollectionElementKindSectionHeader {
            supplementaryView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
            
            if let textLabel = supplementaryView.viewWithTag(10) as? UILabel{
                switch indexPath.section{
                case 0:
                    textLabel.text = "Novermber 2015"
                case 1:
                    textLabel.text = "October 2015"
                case 2:
                    textLabel.text = "September 2015"
                case 3:
                    textLabel.text = "August 2015"
                default:
                    textLabel.text = "Early 2015"
                }
            }
        } else {
            supplementaryView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
        }
        
        return supplementaryView
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == itemCountInSection.count - 1 {
            return CGSize(width: 50, height: 2)
        } else {
            return CGSizeZero
        }
    }
}

