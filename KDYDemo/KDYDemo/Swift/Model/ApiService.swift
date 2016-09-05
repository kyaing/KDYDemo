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
let apiProvider = RxMoyaProvider<ApiService>()

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
            // 这里是我的测试 key，理论上是免费的，如果失效，请自行申请替换
            // 接口详情地址: https://www.juhe.cn/docs/api/id/44
            "key": "e8ec41002b1441dc9126d7bbf259b747"
            ]
        }
    }

    // 用于测试数据
    public var sampleData: NSData {
        return "".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

