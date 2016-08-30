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

/**
 *  31 final
 *  - final可以用在class, func或者var前面进行修饰，表示不允许被继承或重写操作。
 *  - 这个下面所说的tips还是不太理解！
 */

//@ 权限控制

//@ 类或者方法的功能已经完备了

//@ 子类继承和修改是一件危险的事情

//@ 为了父类中某些代码一定会被执行
class Parent {
    final func method() {
        print("开始配置")
        
        methodImpl()
        
        print("结束配置")
    }
    
    func methodImpl() {
        fatalError("子类必须要实现这个方法")
    }
}

class Child: Parent {
    override func methodImpl() {
        
    }
}


/**
 *  32 lazy修饰符 和 lazy方法
 */
class ClassAA {
    lazy var str: String = {
        let str = "Hello"
        print("只在首次访问输出")
        return str
    }()
    
    init() {}
}


/**
 *  33 Reflection 和 Mirror
 */


/**
 *  34 隐式解包 Optional
 *  - 这里就要区分两个操作符的意思了：？和 ！
 *  - 相对于普通的Optional，Swift中还有一种特殊的Optional，在对它的成员或方法进行访问时，编译器会自动进行解包。
 *  - 声明变量的时候，可以在类型后加上(!)来告诉编译器我们需要一个可以隐式解包的Optional值。
 *  - 隐式解包不意味着"这个变量不会是nil, 你可以放心使用"
 */

var maybeObject: ClassAA! = ClassAA()


/**
 *  35 多重 Optional
 */

var str2: String? = "String"
var anotherStr2: String?? = str2   // Optional<Optional<String>>


/**
 *  36 Optional Map
 */

let arr = [1,2,3]
let doubled = arr.map { $0 * 2 }
print("doubled = \(doubled)")


/**
 *  37 Protocol Extension
 */

protocol MyProtocol {
    func method()
}

extension MyProtocol {
    func method() {
        print("Method Called!")
    }
}

struct MyStruct: MyProtocol {
    func method() {
        print("Struct method called!")
    }
}


/**
 *  38 where 和模式匹配
 *  - where在Swift中很强大，但容易被忽略，以下列出几个常用的场景。
 */

//@ 在switch中使用
let names = ["王小二","张三","李四","王二小"]

//使用for-in
for name in names {
    switch name {
    case let name where name.hasPrefix("王"):
        print("\(name)，姓王")
    default:
        print("你好，\(name)")
    }
}

//使用forEach
names.forEach {
    switch $0 {
    case let x where x.hasPrefix("王"):
        print("\(x)，姓王")
    default:
        print("你好，\(x)")
    }
}

//@ if let 或 for 使用 where
let scores: [Int?] = [48, 60, 88, 90, nil]
scores.forEach {
    if let score = $0 where score > 60 {
        print("及格了 - \(score)")
    } else {
        print(":(")
    }
}

for score in scores where score > 60 {
    print("及格了 - \(score)")
}

//@ 某些接口扩展的默认实现只在某些特定的条件下适用
extension SequenceType where Self.Generator.Element: Comparable {
    
}


/**
 *  39 indirect 和嵌套 enum
 *  - 涉及到数据结构的经典理论和模型(链表、树和图)，我们会用到嵌套类型。
 */


////////////////////////////////////////////////////////////////////////


/**
 *  40 Selector
 */

func callMe() {
    print("callMe")
}

func callMeWithParam(obj: AnyObject!) {
    print("callMeWithParam")
}

//let someMethod = Selector("callMe")
//let anotherMethod = Selector("callMeWithParam:")


/**
 *  41 实例方法的动态调用
 */

class MyClasss {
    func method(number: Int) -> Int {
        return number + 1
    }
}

//@ 基本的是通过类实例来调用类中的方法
let obj = MyClasss()
let result = obj.method(2)

//@ 动态调用，还得是实例方法
let f = MyClasss.method  //Swift中可以直接用 (Type.instanceMethod) 的语法来生成一个柯里化的方法
let object = MyClasss()
let res = f(object)(2)


/**
 *  42 单例
 */

class MyManager {
    private static let sharedInstance = MyManager()
    class var sharedManager: MyManager {
        return sharedInstance
    }
}







