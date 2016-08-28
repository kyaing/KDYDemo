//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Generics"

/**
 *  1 泛型函数
 *  - 这里用占位类型名来代替实际类型名(如Int, String, Double等)
 */
func swapTwoValue<T>(inout a: T, inout _ b: T)  {
    let temp = a
    a = b
    b = temp
}

var someInt = 3
var anotherInt = 107
swapTwoValue(&someInt, &anotherInt)
print("\(someInt), \(anotherInt)")

/**
 *  2 类型参数
 */

//命名类型参数
//大多情况下，类型参数是具有一个描述性的名字，还要始终用驼峰命名法。

//泛型类型
//除了泛型函数，Swift允许自定义泛型类型，这些自定义的类、结构体和枚举可以适用任何类型
struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfString = Stack<String>()
stackOfString.push("uno")
stackOfString.push("dos")
stackOfString.push("tres")
let fromTheTop = stackOfString.pop()


/**
 *  3 扩展一个泛型类型
 */
extension Stack {
    //直接用Stack中的类型参数名表示计算属性topItem的可选类型
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfString.topItem {
    print("The top item is \(topItem).")
}

/**
 *  4 类型约束
 */
class SomeClass {
    
}

protocol SomeProtocol {
    
}

//可以在一个类型参数名后放置一个类名或协议名，来定义类型约束
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    
}

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    
    return nil
}

let doubleIndex = findIndex([3.14, 0.1, 23.55], 0.1)
print("index = \(doubleIndex)")

/**
 *  5 关联类型
 *  - 关联类型为协议中的某个类型提供了一个占位名，代表的实际类型在协议被采纳时才会被指定
 */
protocol Container {
    //协议Container就定义了一个关联类型ItemType
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack:  Container {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    //Container协议的实现部分
    typealias ItemType = Int
    mutating func append(item: ItemType) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

extension Array: Container {}

/**
 *  6 Where子句
 */

func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    //检查两个容器含有相同数量的元素
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    //检查每一对元素是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    //所有元素都匹配，返回true
    return true
}

/**
 *  7 自定义的泛型 
 *  - http://www.jianshu.com/p/8071e8922814
 */

extension Array {
    //@ 自定义Map方法
    func myMap<BeforeType, AfterType>(transform: (BeforeType) -> (AfterType)) -> [AfterType] {
        var output: [AfterType] = []
        for item in self {
            let transform = transform(item as! BeforeType)
            output.append(transform)
        }
        
        return output
    }
}

let fruits = ["apple", "banana", "orange"]
//将字符串转换成字符串长度(用系统的map和自定义的myMap)
//print(fruits.map() { $0.characters.count })

func fruit(fruit: String) -> Int? {
    let length = fruit.characters.count
    guard length > 0 else { return nil }
    
    return length
}

let counts = fruits.myMap(fruit)  //结果：[Optional(5), Optional(6), Optional(6)]
print("counts = \(counts)")

var numArray = [1, 3, 5, 7, 9]
//reduce有两个参数：第一个表示第一次合并前的初始值；第二个表示合并的规则
let sum = numArray.reduce(0, combine: { $0 + $1 })
print("sum = \(sum)")

extension Array {
    //@ 自定义reduce方法
    func myReduce<AfterType, BeforeType>(initial: AfterType,
                  combine: (AfterType, BeforeType) -> AfterType) -> AfterType {
        var seed = initial
        for item in self {
            seed = combine(seed, item as! BeforeType)
        }
        
        return seed
    }
}

let sum2 = numArray.myReduce(0, combine: { $0 + $1 })
print("sum2 = \(sum2)")


