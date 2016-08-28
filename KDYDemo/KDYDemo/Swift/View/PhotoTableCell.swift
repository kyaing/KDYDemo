//
//  PhotoTableCell.swift
//  KDYDemo
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit

class PhotoTableCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.contentMode = .ScaleAspectFit
    }
}

