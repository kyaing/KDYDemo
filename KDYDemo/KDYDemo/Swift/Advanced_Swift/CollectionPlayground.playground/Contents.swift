//: Playground - noun: a place where people can play

import UIKit

var str = "集合"

/**
 *  1 数组与可变性
 */

var fibs = [0, 1, 3, 2, 6, 5]

fibs.count
fibs.isEmpty
fibs.append(7)
fibs.appendContentsOf([13, 20])
print("fibs:", fibs)

//数组中的值从来不会共享
var x = [1, 3, 5]
var y = x
y.append(7)

let a = NSMutableArray(array: [1, 2, 3])
//不想让b能被改变，把a给复制一份，(copy-on-write)
let b: NSArray = a.copy() as! NSArray

a.insertObject(4, atIndex: 3)
print(b)

/**
 *  2 数组变换
 *  - 高阶函数：map, filter，reduce
 */

var squared: [Int] = []
for fib in fibs {
    squared.append(fib * fib)
}
print(squared)

//@ map
//使用map方法，将一个变换函数应用到数组的每个元素上
squared = fibs.map() { $0 * $0 }
print("map:", squared)

extension Array {
    func map<U>(transform: Element->U) -> [U] {
        var result: [U] = []
        result.reserveCapacity(self.count)
        
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

//@ filter
//对于闭包，代码越短，它的可读性越强
squared.filter { $0 % 2 == 0 }
print("filter:", squared)

extension Array {
    func filter(includeElement: Element->Bool) -> [Element] {
        var result: [Element] = []
        for item in self where includeElement(item) {
            result.append(item)
        }
        return result
     }
}

//@ reduce
//map和filter都是通过一个已存在的数组，生成一个新的经过修改的数组
var total = 0
for num in fibs {
    total = total + num
}
print("total: \(total)")

fibs.reduce(0) { total, num in total + num }
print("reduce:", fibs)

//extension Array {
//    func reduce<U>(var initial: U, combine: (U, Element) -> U) -> U {
//        for item in self {
//            initial = combine(initial, item)
//        }
//        
//        return initial
//    }
//}

//@ flatMap
func extractLinks(markdownFile: String) -> [NSURL] {
    return []
}

let suits = ["", "", "", ""]
let ranks = ["J", "Q", "K", "A"]

let allCombinations = suits.flatMap { suit in
    ranks.map { rank in
        (suit, rank)
    }
}

/**
 *  3 字典与集合
 */

protocol Setting {
    func settingsView() -> UIView
}

//let defaultSettings: [String: Setting] = [
//    "Airplance": "ff",
//    "Name": "My iPhone"
//]

/**
 *  4 集合协议
 *  - CollectionType, SequenceType, GeneratorType
 */

//@ 生成器(Generators)
//生成器只能单向访问，并只能遍历一次；因此它没有值语义，所以把它实现成一个类
protocol GeneratorType {
    associatedtype Element
    mutating func next() -> Element?
}

class ConstantGenerator: GeneratorType {
    typealias Element = Int
    func next() -> Element? {
        return 0
    }
}

var generator = ConstantGenerator()
while let x = generator.next() {
    
}

//@ 序列(Sequences)
protocol SequenceType {
    associatedtype Generator: GeneratorType
    func generator() -> Generator
}

/**
 *  5 集合
 */


/**
 *  6 下标
 */











