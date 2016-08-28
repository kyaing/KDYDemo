//
//  KDPinterestViewController.swift
//  KDYDemo
//
//  Created by zhongye on 16/1/14.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//
//  描述：Pinterest

import UIKit

class KDPinterestViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    var photos = Photo.allPhotos()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Pinterest"
        
        if let patternImage = UIImage(named: "Pattern") {
            self.view.backgroundColor = UIColor(patternImage: patternImage)
        }
        
        collectionView = UICollectionView.init(frame: CGRectMake(0, 0, self.view.width, self.view.height), collectionViewLayout: UICollectionViewLayout.init())
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(UINib.init(nibName: NSStringFromClass(UICollectionViewCell), bundle: nil), forCellWithReuseIdentifier: "PinterestCell")
        self.view.addSubview(collectionView)
    }
    
    //MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PinterestCell", forIndexPath: indexPath) as! PinterestViewCell
        cell.backgroundColor = UIColor.redColor()

        return cell
    }
}

