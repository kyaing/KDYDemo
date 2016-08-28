//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Properties"

/**
 *  1 存储属性
 *  - 存储属性就是存储在特定类和结构体实例里的一个常量或变量。
 *  - 存储属性可以是变量存储属性，也可以是常量存储属性。
 */

struct FixedLengthRange {
    var firstValue: Int = 5
    let length: Int
}

//@ 常量结构体的存储属性
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//这里由于值类型的实例被声明为常量，它的所有属性也就成为了常量
//rangeOfFourItems.firstValue = 3

//@ 延迟存储属性
//通过lazy来标示一个延迟属性，同时延迟属性必须要声明为变量；当它首次被访问的时候才计算
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

struct Image {
    lazy var metadata: [String] = {
        // 加载图片和解析 metadata，相当占内存
        // ...
        return []
    }()
}

/**
 *  2 计算属性
 *  - 类、结构体和枚举都可以定义计算属性，必须要用var来定义。
 *  - 计算属性不直接存储值，而是提供一个getter和一个可选的setter。
 */

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
        
        //便捷setter声明
        //set() {
        //   origin.x = newCenter.x - (size.width / 2)
        //   origin.y = newCenter.y - (size.height / 2)
        //}
    }
}

//只读计算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

/**
 *  3 属性观察器
 *  - 属性观察器监控和响应属性值的变化，每次属性被设置新值都会调用属性观察器。
 *  - 可以为除了延时属性之外的其它存储属性，添加属性观察器。
 *  - willSet：在新的值被设置之前调用，willSet会被新的属性值作为常量参数传入。
 *  - didSet：在新的值被设置之后立即调用，didSet会被旧的属性值作为参数传入。
 */

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200

/**
 *  4 全局变量和局部变量
 *  - 计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。
 *  - 全局常量或变量都是延迟计算的，局部范围的常量或变量从不延时计算。
 */


/**
 *  5 类型属性
 *  - 使用static定义类型属性
 */
class SomeClass {
    static var storedTypeProperty = "Some Value."
    static var computedTypeProperty: Int {
        return 27
    }
}
print(SomeClass.computedTypeProperty)


