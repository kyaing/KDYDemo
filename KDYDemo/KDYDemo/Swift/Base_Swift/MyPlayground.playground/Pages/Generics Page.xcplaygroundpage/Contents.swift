//: [Previous](@previous)

import Foundation

/**
泛型是Swift强大的特性之一，可以编写自定义的需求及任意灵活可重用的函数和类型，
它可以让你避免重复的代码，用一种清晰和抽象的方式来表达代码的意图。
*/

var str = "Hello, Generics"

func swapTwoInts(inout a: Int, inout _ b: Int) {
    let tmp = a
    a = b
    b = tmp
}

//使用泛型函数，其中T表示占位类型名，它表示的是类型参数名
func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let tmp = a
    a = b
    b = tmp
}

//定义泛型的栈
struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

//指定尖括号中的数据类型为初始化一个栈
var stackOfString = Stack<String>()
stackOfString.push("ab")
stackOfString.push("dbb")
stackOfString.push("fda")

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}


//: [Next](@next)
