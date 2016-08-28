//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Extensions"

/**
 *  扩展，就是为一个已有的类、结构体、枚举类型甚至协议类型添加新功能。它和OC中的分类类似，区别在于它没名字。
 *  扩展可以：
    - 添加计算型实例属性和计算型类型属性
    - 定义实例方法和类型方法
    - 提供新的构造器
    - 定义下标
    - 定义和使用新的嵌套类型
    - 使一个已有类型符合某个协议
 */

/**
 *  1 扩展语法
 *  extension SomeType {
        //为 SomeType 添加的新功能写到这里
    }
 */

//可以通过扩展一个已有类型，使其采纳一个或多个协议
//extension SomeType: SomeProtocol, AnotherProtocol {
//    // 协议实现写到这里
//}

/**
 *  2 计算型属性
 *  - 扩展可以为已有类型添加计算型实例属性和计算型类型属性。
 *  - 扩展可以添加新的计算型属性，但不可以添加存储型属性，也不可以为已有属性添加属性观察器。
 */
extension Double {
    var km: Double { return self * 1_000.0 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

/**
 *  3 构造器
 *  - 扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器，
 *    指定构造器或析构器必须总是原始的类实现来提供。
 *  - 如果使用扩展提供一个新的构造器，依旧要确保构造过程能够上实例完全初始化。
 */

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/**
 *  4 方法
 *  - 扩展可以为已有类型添加新的实例方法和类型方法。
 *  - 扩展添加的实例方法也可以修改该实例本身。
 */
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

5.repetitions {
    print("Hello!")
}

//可变实例方法
//结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()

/**
 *  5 下标
 */
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

74456789[0]
74456789[1]
74456789[3]
74456789[9]

/**
 *  6 嵌套类型
 */
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

/**
 *  7 “错误”的使用Swift的Extension
 *    ( http://www.jianshu.com/p/0fc56838b33b )
 *  - 作者大量使用Extension主要是为了提高代码的可读性！
 */

//@ 私有的辅助函数

//@ 分组 (用一个Extension存放ViewController或AppDelegate中所有初始化UI的函数)

//@ 遵守协议 (将用来实现某个协议的方法放到一个Extension中)

//@ 模型(Model)








