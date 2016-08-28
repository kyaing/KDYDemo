//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *  15 typealias 和泛型接口
 */

typealias Location = CGPoint
typealias Distance = Double

func distanceBetweenPoint(location: Location,
                          toLocation: Location) -> Distance {
    let dx = Double(toLocation.x - location.x)
    let dy = Double(toLocation.y - location.y)
    return sqrt(dx * dx + dy * dy)
}

let origin: Location = Location(x: 0, y: 0)
let point: Location = Location(x: 1, y: 1)

let distance: Distance = distanceBetweenPoint(origin, toLocation: point)
print(distance)

//对泛型使用typealias
class Person<T> {}
//typealias WorkId = Person   //error!

//一旦泛型类型确定后，才能typealias
typealias WorkId = String
typealias Worker = Person<WorkId>


/**
 *  16 可变参数函数
 *  - 在声明参数时在类型后面加上...即可
 */
func sum(input: Int...) -> Int {
    return input.reduce(0, combine: +)
}
print(sum(1, 2, 3))

extension NSString {
    //convenience init(format: NSString, _ args: CVarArgType...)
}

/**
 *  17 初始化方法顺序
 *  - Swift的初始化方法需要保证类型的所有属性都被初始化
 */
class Cat {
    var name: String
    init() {
        name = "小花"
    }
}

class Tiger: Cat {
    let power: Int
    override init() {
        //保证当前子类实例的成员初始化完成后才能调用父类的初始化方法
        power = 10
        
        super.init()
        name = "大花"
    }
}

/**
 *  18 Designated, Convenience和Required
 */
class ClassA {
    let numA: Int
    init(num: Int) {  //Swift的init只可能被调用一次
        numA = num
    }
    
    //convenience初始化方法，只作为补充和提供使用上的方便
    convenience init(bigNum: Bool) {
        self.init(num: bigNum ? 1000 : 1)
    }
}

class ClassB: ClassA {
    let numB: Int
    override init(num: Int) {
        numB = num + 1
        super.init(num: num)
    }
}

/**
 *  19 初始化返回 nil
 */

/**
 *  20 protocol组合
 *  - Any: protocol <>
 */

protocol A {
    func bar() -> Int
}

protocol B {
    func bar() -> String
}

/**
 *  21 static 和 class
 */

/**
 *  22 多类型和容器
 */
let numbers = [1,2,3,4,5]  //numbers类型是[Int]
let strings = ["hello", "world"]   //strings的类型是[string]

let mixed: [Any] = [1, "two", 3]
let objectArray = [1, "two", 3]

let any = mixed[0]  //Any
let nsObject = objectArray[0]  //NSObject

//使用enum可以带有值的特点(值绑定)，将类型信息封装到特定的enum中
enum IntOrString {
    case IntValue(Int)
    case StrinValue(String)
}

let mixedArray = [IntOrString.IntValue(1),
                  IntOrString.StrinValue("two"),
                  IntOrString.IntValue(3)]

//for value in mixedArray {
//    switch value {
//    case let .IntValue(i):
//        print(i * 2)
//        
//    }
//}

/**
 *  23 default参数
 *  - Swift默认限制更少，并没有所谓的“默认参数之后不能再出现无默认值的参数”这样的规则
 */

func sayHello1(str1: String = "Hello", str2: String, str3: String) {
    print(str1 + str2 + str3)
}

func sayHello2(str1: String, str2: String, str3: String = "World") {
    print(str1 + str2 + str3)
}

sayHello1(str2: "", str3: " World")
sayHello2("Hello ", str2: "")


/**
 *  24 正则表达式
 */
struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern,
                                        options: .CaseInsensitive)
    }
    
    func match(input: String) -> Bool {
        let matches = regex.matchesInString(input,
                                            options: [],
                                            range: NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
}

let userPattern = "/^[a-z0-9_-]{3, 16}$/"
let matcher: RegexHelper
do {
    matcher = try RegexHelper(userPattern)
}

let maybeUserName = "kaideyi_3fda3###$"
if matcher.match(maybeUserName) {
    print("Ok")
} else {
    print("Error")
}

/**
 *  25 模式匹配
 *  - 使用操作符 ~= 来表示模式匹配
 *  - Swift中可以用强大的switch，来进行模式匹配
 */

//@ 判断等于类型的判断
// func ~=<T : Equatable>(a: T, b: T) -> Bool
let password = "akfuv(3"
switch password {
    case "akfuv(3": print("Success")
    default: print("Error")
}

//@ 对Optional的判断
// func ~=<T>(lhs: _OptionalNilComparisonType, rhs: T?) -> Bool
let num: Int? = nil
switch num {
    case nil: print("空值")
    default: print("num = \(num)")
}

//@ 对范围的判断
// func ~=<I : IntervalType>(pattern: I, value: I.Bound) -> Bool
let x = 0.5
switch x {
    case -1.0...1.0: print("区间内")
    default: print("区间外")
}

//@ 自定义模式匹配
/**
    func greaterThan<T: Comparable>(a: T, _ b: T) -> Bool {
        return b > a
    }

    func lessThan<T: Comparable>(a: T, _ b: T) -> Bool {
        return b < a
    }

    prefix operator ~> {}
    prefix operator ~< {}

    prefix func ~> <T: Comparable>(a: T, b: T) -> Bool {
        return greaterThan(a, b)
    }

    prefix func ~< <T: Comparable>(a: T, b: T) -> Bool {
        return lessThan(a, b)
    }

    switch x {
    case ~>0: print("positive")
    case ~<0: print("negative")
    case 0: print("zero")
    default: fatalError("Should be unreachable")
    }
*/


/**
 *  26 ... 和 ..<
 *  - 用来表示一个范围，闭区间，和开区间
 */
for i in 0..<3 {
    print("i = \(i)")
}

let test = "helLo"
let interval = "a"..."z"
for c in test.characters {
    if !interval.contains(String(c)) {
        print("\(c) 不是小写字母 ")
    }
}


/**
 *  27 AnyClass，元类型和.self
 *  - Any, AnyObject, AnyClass
 */

typealias AnyClass = AnyObject.Type

//@ 元类型
class A1 {
    
}

let typeA: A1.Type = A1.self


/**
 *  28 接口和类方法中的Self
 */



/**
 *  29 动态类型和多方法
 */



/**
 *  30 属性观察
 *  - 利用属性观察可以在当前类型内监视对于属性的设定，并作出响应。willSet, didSet
 */
class MyClass {
    var date: NSDate {
        willSet {
            let d = date
            print("日期从 \(d) 设定到 \(newValue)")
        }
        
        didSet {
            print("已经从日期从 \(oldValue) 设定到 \(date)")
        }
    }
    
    init() {
        date = NSDate()
    }
}

let foo = MyClass()
foo.date = foo.date.dateByAddingTimeInterval(10086)

class A2 {
    
}

let b = A2()
print("32345")







