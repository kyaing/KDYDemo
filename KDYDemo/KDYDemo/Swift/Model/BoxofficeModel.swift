//
//  BoxofficeModel.swift
//  KDYDemo
//
//  Created by kaideyi on 16/9/6.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import SwiftyJSON

struct BoxofficeModel: Mapable {
    let rid: String?
    let name: String?
    let wk: String?
    let wboxoffice: String?
    let tboxoffice: String?
    
    init?(jsonData: JSON) {
        self.rid        = jsonData["rid"].string
        self.name       = jsonData["name"].string
        self.wk         = jsonData["wk"].string
        self.wboxoffice = jsonData["wboxoffice"].string
        self.tboxoffice = jsonData["tboxoffice"].string
    }
}

