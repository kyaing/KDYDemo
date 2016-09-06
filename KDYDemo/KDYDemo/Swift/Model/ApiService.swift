//
//  ApiService.swift
//  KDYDemo
//
//  Created by kaideyi on 16/9/5.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Moya
import SwiftyJSON

// MARK: - Targets

// 先定义枚举类型的Api管理类
public enum ApiService {
    case GetRank(area: String?)
}

// 创建Provider，并发起请求
let apiProvider   = MoyaProvider<ApiService>()
let rxApiProvider = RxMoyaProvider<ApiService>()

// 满足 TargetType协议
extension ApiService: TargetType {
    public var baseURL: NSURL { return NSURL(string: "http://v.juhe.cn")! }
    
    public var path: String {
        switch self {
        case .GetRank(_):
            return "/boxoffice/rank"
        }
    }
    
    public var method: Moya.Method { return .GET }
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case .GetRank(let area):
        return [
            "area": nil == area ? "" : area!,
            // 接口详情地址: https://www.juhe.cn/docs/api/id/44
            "key": "c4356125b8472bd265a0691789d114b3"
            ]
        }
    }

    // 用于测试数据
    public var sampleData: NSData {
        return "".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

