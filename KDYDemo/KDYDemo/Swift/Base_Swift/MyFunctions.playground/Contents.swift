//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Functions"

/**
 *  函数用来完成特定的独立的代码块
 */

/**
 *  1 函数的定义和调用
 */
func sayHello(personName: String) -> String {
    return "Hello, " + personName + "!"
}

print(sayHello("Anna"))

/**
 *  2 函数参数和返回值
 */

//无参函数
func sayHelloWorld() -> String {
    return "Hello World!"
}
print(sayHelloWorld())

//多个参数函数
func sayHello(personName: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return sayHelloWorld()
    } else {
        return sayHello(personName)
    }
}

//无返回函数
func sayGoodbye(personName: String) {
    print("Goodbye, \(personName)!")
}
sayGoodbye("Dave")

//多重返回值函数
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    
    return (currentMin, currentMax)
}

/**
 *  3 函数参数名称
 *  - 函数参数都有：一个外部参数名；一个局部参数名。
 *  - 外部参数名用于在函数调用时标注传递给函数的参数；局部参数在函数的实现内部使用。
 *  - 一般情况下，第一个参数省略其外部参数名，第二个以及其随后的参数使用局部参数名作为外部参数名。
 */

//指定外部参数名
func someFunction(externalParameterName localParameterName: Int) {
    
}

//若提供了外部参数名，则在函数被调用时，必须使用外部参数名
func sayHello(to person: String, and anotherPerson: String) -> String {
    return "Hello \(person) and \(anotherPerson)"
}
print(sayHello(to: "Bill", and: "Ted"))

//忽略外部参数名
func someFunction(firstmerName: Int, _ secondParameterName: Int) {
    
}
someFunction(1, 2)

//默认参数值
func someFunction(parameWithDefault: Int = 12) {
    
}
someFunction(6)
someFunction()

//可变参数，一个函数最多只能有一个可变参数
func arithmeticMean(number:  Double...) {
    
}

//输入输出参数
//(函数参数默认是常量，这样在函数体内更改参数值会导致编译错误)
//定义输入输出参数时，要在参数前加inout关键字
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temp = a
    a = b
    b = temp
}

/**
 *  4 函数类型
 *  - 每个函数都有特定的函数类型，它由函数的参数类型和返回类型组成
 */

func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}

//这两个函数的类型是：(Int, Int) -> Int
addTwoInts(1, 3)
multiplyTwoInts(2, 3)

//使用函数类型
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")

//函数类型作为参数类型
func printMathResult(mathFuntion: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFuntion(a, b))")
}
printMathResult(addTwoInts, 3, 5)

//函数类型作为返回类型
func stepForward(input: Int) -> Int {
    return input + 1
}

func stepBackward(input: Int) -> Int {
    return input - 1
}

//这里(Int) -> Int就是作为返回类型的
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepForward : stepForward
}

/**
 *  5 嵌套函数
 */
func chooseStepFunction2(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepForward : stepForward
}




