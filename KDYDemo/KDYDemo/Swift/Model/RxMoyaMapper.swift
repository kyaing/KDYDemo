//
//  RxMoyaMapper.swift
//  KDYDemo
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON

enum ORMError: ErrorType {
    case ORMNoRepresentor
    case ORMNotSuccessfulHTTP
    case ORMNoData
    case ORMCouldNotMakeObjectError
    case ORMBizError(resultCode: String?, resultMsg: String?)
}

enum BizStatus: String {
    case BizSuccess = "200"
    case BizError
}

public protocol Mapable {
    init?(jsonData: JSON)
}

// json 返回的表示状态字段
let RESULT_CODE = "resultcode"
let RESULT_MSG  = "reason"
let RESULT_DATA = "result"

// 扩展 Observable，用以映射 Moya的response数据
extension Observable {
    private func resultFromJSON<T: Mapable>(jsonData: JSON, classType: T.Type) -> T? {
        return T(jsonData: jsonData)
    }
    
    // 将数据映射为普通的对象
    func mapResponseToObject<T: Mapable>(type: T.Type) -> Observable<T?> {
        return map { representor in
            // get Moya.Response
            guard let response = representor as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            
            // http 状态检验
            guard ((200...209) ~= response.statusCode) else {
                throw ORMError.ORMNotSuccessfulHTTP
            }
            
            let json = JSON.init(data: response.data)
            
            if let code = json[RESULT_CODE].string {
                if code == BizStatus.BizSuccess.rawValue {
                    return self.resultFromJSON(json[RESULT_DATA], classType: type)
                } else {
                    throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].string,
                        resultMsg: json[RESULT_MSG].string)
                }
            } else {
                throw ORMError.ORMCouldNotMakeObjectError
            }
        }
    }
    
    // 将数据映射为数组
    func mapResponseToArray<T: Mapable>(type: T.Type) -> Observable<[T]> {
        return map { response in
            // get Moya.Response
            guard let response = response as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            
            // http 状态检验
            guard ((200...209) ~= response.statusCode) else {
                throw ORMError.ORMNotSuccessfulHTTP
            }
            
            let json = JSON.init(data: response.data)
            
            if let code = json[RESULT_CODE].string {
                if code == BizStatus.BizSuccess.rawValue {
                    var objects = [T]()
                    let objectsArray = json[RESULT_DATA].array
                    
                    if let array = objectsArray {
                        for object in array {
                            if let obj = self.resultFromJSON(object, classType: type) {
                                objects.append(obj)
                            }
                        }
                        return objects
                        
                    } else {
                        throw ORMError.ORMNoData
                    }
                } else {
                    throw ORMError.ORMBizError(resultCode: json[RESULT_CODE].string,
                        resultMsg: json[RESULT_MSG].string)
                }
            } else {
                throw ORMError.ORMCouldNotMakeObjectError
            }
        }
    }
}



