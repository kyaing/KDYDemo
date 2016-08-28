//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Closures"

/**
 *  闭包是自包含的函数代码块，可以在代码中被传递和使用，
 *  它和Objective-C中的block很相似，闭包可以捕获和存储其所在上下文中任意常量和变量的引用。
 *  闭包采取如下三种形式：
 *  - 全局函数是一个有名字但不会捕获任何值的闭包。
 *  - 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包。
 *  - 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文变量或常量值的匿名闭包。
 */

/**
 *  1 闭包表达式
 *  { (parameters) -> returnType in
 *      statements
 *  }
 */
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

var reversed = names.sort(backwards)

//backwards(_:_:)函数对应的闭包表达式版本的代码
reversed = names.sort({ (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//函数体部分比较短，可以改写成一行
reversed = names.sort({ (s1: String, s2: String) -> Bool in return s1 > s2 })

//根据上下文推断类型
reversed = names.sort({ s1, s2 in return s1 > s2 })

//单表达式闭包隐式返回
reversed = names.sort({ s1, s2 in s1 > s2 })

//参数名称缩写
reversed = names.sort({ $0 > $1 })

/**
 *  2 尾随闭包
 *  - 将一个很长的闭包表达式作为最后一个参数传递给函数，用来增强可读性。
 *  - 它是一个书写在函数括号后的闭包表达式。
 */
func someFunctionClosure(closure: () -> Void) {
    //...
}

someFunctionClosure({
    //闭包主体
})

//尾随闭包
someFunctionClosure() {
    //闭包主体
}

//改写sort()
reversed = names.sort() { $0 > $1 }

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    
    return output
}

/**
 *  3 值捕获
 */
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

/**
 *  4 闭包是引用类型
 */

/**
 *  5 非逃逸闭包
 *  - 当一个闭包作为参数传到一个函数中，但是这个闭包会在函数返回之后才会执行，称此闭包从函数中逃逸。
 *  - 参数名前标注 noescape，表明这个闭包不允许逃逸。
 */
func someFunctionNocapeColosure(@noescape closure:() -> Void) {
    closure()
}

//使闭包能逃逸的一个方法是：将闭包保存到函数的外部变量中
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
    completionHandlers.append(completionHandler)
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionNocapeColosure { x = 200 }
    }
}


