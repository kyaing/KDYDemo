//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Methods"

/**
 *  结构体和枚举能够定义方法是Swift与OC的主要区别之一
 */

/**
 *  1 实例方法
 *  - 属于某个特定类、结构体或枚举类型实例的方法。
 */

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
counter.incrementBy(5)

//方法的局部参数名称和外部参数名称
class Counter2 {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}

let counter2 = Counter2()
counter2.incrementBy(2, numberOfTimes: 3)

//self属性
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}

/**
 *  2 类型方法
 *  - Swift可以为所有的类、结构体和枚举定义类型方法。
 */



