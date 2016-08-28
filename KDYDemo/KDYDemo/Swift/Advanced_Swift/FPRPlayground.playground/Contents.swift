//: Playground - noun: a place where people can play

import UIKit

var str = "FPR 之 Swift式循环"

/**
 *  1 Generators
 *  - 它的存在就是进行特殊的数组遍历的，一般遍历都是从头到尾进行的。
 *  - 它的好处就是可以把一个很抽象的遍历模式使用Generators的方式剥离出来；
 *  - 它的缺点就是在循环过程中为每个元素提供的服务是一次性的。
 */

protocol GeneratorType {
    associatedtype Element
    func next() -> Element?
}

/// 实现个倒序索引的generator
class CountdownGenerator: GeneratorType {
    typealias Element = Int
    var element: Element
    
    init<T>(array: [T]) {
        self.element = array.count - 1
    }
    
    func next() -> Element? {
        return self.element < 0 ? nil : element--
    }
}

//Tests
let xs = ["A", "B", "C"]
let generator = CountdownGenerator(array: xs)
while let i = generator.next() {
    print("Element \(i) of the array is \(xs[i])")
}

/**
 *  2 Sequences
 *  - 一个类如果实现了SequenceType协议，那么它就可以使用for-in来循环了。
 *  - 还可以让自已的类也支持SequenceType协议，同样来达到可以for-in的目的。
 */

protocol SequenceType {
    associatedtype Generator: GeneratorType
    func generate() -> Generator
}

struct ReverseSequence<T>: SequenceType {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    
    typealias Generator = CountdownGenerator
    func generate() -> Generator {
        return CountdownGenerator(array: array)
    }
}

//Test
let xss = ["A", "B", "C"]
let reverseSequence = ReverseSequence(array: xss)
let reverseGenerator = reverseSequence.generate()

while let i = reverseGenerator.next() {
    print("Index \(i) is \(xs[i])")
}


/**
 *  3 CollectionType
 */



