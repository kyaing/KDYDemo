//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, ARC"

/**
 *  Swift使用ARC机制来跟踪和管理应用程序的内存。
 *  引用计数仅应用于类的实例，结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。
 */

/**
 *  1 自动引用计数的工作机制
 *  - 无论将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。
 *    之所以被称为强引用，是因为它会将实例牢牢地保持信，只要强引用还在，实例是不允许补销毁的。
 */

/**
 *  2 自动引用计数实践
 */

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being init.")
    }
    
    deinit {
        print("\(name) is being deinit.")
    }
}

//这些变量被定义为可选类型，所以它们的值会被自动初始化为nil
var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
//当你清楚地表明不再使用Person实例时，最后一个强引用被断开时，ARC会断开它
reference3 = nil


/**
 *  3 类实例之间的循环强引用
 *  - 当我们写了一个类实例的强引用永远不能变成0时，若两个类实例互相持有对方的强引用，循环强引用。
 *  - 可以通过定义类之间的关系为弱引用或无主引用，来代替强引用，从而解决循环强引用的问题。
 */
class PersonTwo {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: PersonTwo?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: PersonTwo?
var unit4A: Apartment?

john = PersonTwo(name: "John Two")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

//循环强引用会一直阻止Person和Apartment类实例的销毁
john = nil
unit4A = nil

/**
 *  4 解决实例之间的循环强引用
 *  - Swift提供了两种方法来解决：弱引用和无主引用
 */

//弱引用
//弱引用不会对其引用的实例保持强引用，因而不会阻止ARC销毁被引用的实例。
//弱引用必须被声明为变量，表明其值能在运行时被修改。

//无主引用
//和弱引用不同的是，无主引用是永远有值的，它总是被定义为非可选类型。
//在声明属性或变量时，加unowned表示就是无主引用。
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) { self.name = name }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var david: Customer?
david = Customer(name: "David")
david!.card = CreditCard(number: 1234_5678_9088_2322, customer: david!)

david = nil

/**
 *  5 闭包引起的循环强引用
 *  - 当在一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例时。
 *  - Swift提供了一个方法来解决，称为“闭包捕获列表”
 */

/**
 *  6 解决闭包引起的循环强引用
 */
//lazy var someClosure: Void -> String {
//    [unowned self, weak delegate = self.delegate]
//}




