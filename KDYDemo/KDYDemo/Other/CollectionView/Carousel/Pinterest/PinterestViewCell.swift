//
//  PinterestViewCell.swift
//  KDYDemo
//
//  Created by kaideyi on 16/1/14.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

class PinterestViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var photo : Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                label.text = photo.caption
            }
        }
    }
}

