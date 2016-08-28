//: Playground - noun: a place where people can play

import UIKit

var str = "函数式思想"

/**
 *  函数在Swift中是一等值(first-class-values)，
 *  也就是函数既可以作为参数被传递互其它函数中，也可以作为其它函数的返回值！
 *  - 函数式编程的核心理念：就是函数是值，它和结构体、整型或布尔型没有什么区别。
 */

//@ 案例：Battleship
typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func inRange(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
}

typealias Region = Position -> Bool

//@ 类型驱动开发















