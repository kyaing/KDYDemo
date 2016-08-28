//
//  UIImage+Extension.swift
//  KDYDemo
//
//  Created by kaideyi on 16/1/14.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Foundation

extension UIImage {
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        drawAtPoint(CGPointZero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return decompressedImage
    }
}

