//: Playground - noun: a place where people can play

import UIKit
import SwiftyJSON
import Alamofire

var str = "SwityJSON的使用"

/**
 *  1 本地JSON测试
 */
/**
 [
    {
        "name": "hangge",
        "age": 100,
        "phones": [
            {
                "name": "公司",
                "number": "123456"
            },
            {
                "name": "家庭",
                "number": "001"
            }
        ]
    },
    {
        "name": "big boss",
        "age": 1,
        "phones": [
            {
                "name": "公司",
                "number": "111111"
            }
        ]
    }
 ]
 */

//创建Model
class Company: NSObject {
    var name: String = ""
    var age: Int = 0
    var phones: [Phone] = []
}

class Phone: NSObject {
    var name: String = ""
    var number: String = ""
}

let jsonStr = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123-4512-3232\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"

if let jsonData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding,
                                            allowLossyConversion: false) {
    //@ 使用NSJSONSerialization解析
    if let userArray = try? NSJSONSerialization.JSONObjectWithData(jsonData,
                                                                   options: .AllowFragments) as? [[String: AnyObject]],
        let phones = userArray?[0]["phones"] as? [[String: AnyObject]],
        let number = phones[0]["number"] as? String {
            //找到电话号码
            print("第一个联系人的第一个电话号码：", number)
        }
    
    //@ 使用SwityJSON解析；不用担心数组越界、不用判断节点、也不用拆包.
    let json = JSON(data: jsonData)
    if let number = json[30]["phones"][0]["number"].string {
        //找到电话号码
        print("第一个联系人的第一个电话号码：", number)
        
    } else {
        print("没有找到电话号码.")
    }
}

/**
 *  2 网络请求
 */
let url = NSURL(string: "http://www.weather.com.cn/adat/sk/101110101.html")

if let myUrl = url {
    let jsonData = NSData(contentsOfURL: myUrl)
    if let data = jsonData {
        let json = JSON(data: data)
        //let city = json["weatherinfo"]["city"]
        let temp = json["weatherinfo"]["temp"]
        
        let path = ["weatherinfo", "city"]
        let city = json["path"]
        
        print("城市：\(city)；温度：\(temp)\n")
    }
}

Alamofire.request(.GET, url!).validate().responseJSON { response in
//    switch response.result {
//    case .Success:
//        if let value = response.result.value {
//            let json = JSON(value)
//            let city = json["weatherinfo"]["city"]
//            let temp = json["weatherinfo"]["temp"]
//            print("城市：\(city)；温度：\(temp)\n")
//        }
//        
//    case .Failure(let error):
//        print(error)
//    }
    
    print("response = \(response)")
    if let value = response.result.value {
        let json = JSON(value)
        let city = json["weatherinfo"]["city"]
        let temp = json["weatherinfo"]["temp"]
        print("城市：\(city)；温度：\(temp)\n")
    }
}

/**
 *  3 获取值
 */

/**
  通过.number、.string、.bool、.int、.uInt、.float、.double、.array、.dictionary、
  int8、Uint8、int16、Uint16、int32、Uint32、int64、Uint64，等方法获取到的是可选择值，我们需要自行判断是否存在，
  同时不存在的话可以获取具体的错误信息。
 */
if let jsonData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding) {
    let json = JSON(data: jsonData)
    
    //@ 可选值获取
    //int 
    if let age = json[0]["age"].int {
        print("age = \(age)")
    } else {
        print("error = \(json[0]["age"])")
    }
    
    //String
    if let name = json[0]["name"].string {
        print(name)
    } else {
        //打印错误信息
        print(json[0]["name"])
    }
    
    //@ 不可选值获取
    //使用 xxxValue 这样的属性获取值，如果没获取到的话会返回一个默认值，也就不用再判断拆包了
    let age2: Int = json[0]["age"].intValue
    let name2: String = json[0]["age"].stringValue
    let list: Array<JSON> = json[0]["phones"].arrayValue
    let phone: Dictionary<String, JSON> = json[0]["phones"][0].dictionaryValue
    
    //@ 获取原始数据
    let jsonObject: AnyObject = json.object
    if let jsonObject: AnyObject = json.rawValue {
        
    }

    //JSON转化为striing字符串
    if let string = json.rawString() {
        print("String = \(string)")
    }
    
    //JSON转化为Dictionary字典([String: AnyObject]?)
    if let dic = json.dictionaryObject {
        print("dic = \(dic)")
    }
    
    //当json数据是字典类型时
    for (key, subJson): (String, JSON) in json[0] {
        print("遍历字典 -\(key)：\(subJson)")
    }
    
    //JSON转换为Array数组([AnyObject]?)
    if let array = json.arrayObject {
        print("array = \(array)")
    }
    
    //当json数据是数组类型时
    for (index, subJson): (String, JSON) in json {
        print("遍历数组 -\(index): \(subJson)")
    }
}

/**
 *  4 设置值
 */
if let jsonData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding) {
    var json = JSON(data: jsonData)
    
    json[0]["age"].int = 101
    json[0]["name"].string = "hangge.com"
    json[0]["phones"].arrayObject = [["name": "固话", "number": 110], ["name": "手机", "number": 120]]
    json[0]["phones"].dictionaryObject = ["name": "固话", "number": 110]
}



