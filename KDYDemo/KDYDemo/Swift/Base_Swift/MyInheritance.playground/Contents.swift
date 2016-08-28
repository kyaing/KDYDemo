//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Inheritance"

/**
 *  1 定义一个基类
 *  - 一个类可以继承另一个类的方法、属性和其它特性。
 */

class Vehicle {
    //currentSpeed为存储属性，被推断为Double
    var currentSpeed = 0.0
    var description: String {
        return "traveing at \(currentSpeed) mails per hour"
    }
    
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")


/**
 *  2 子类生成
 */
//class SomeSuperClass {
//    
//}
//
//class SomeClass: SomeSuperClass {
//    
//}

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
bicycle.makeNoise()

/**
 *  3 重写
 *  - 重写就是，子类可以为继承来的实例方法、类方法、实例属性或下标提供定制的实现。
 */

//重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("choo choo")
    }
}
let train = Train()
train.makeNoise()

//重写属性
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

//重写属性观察器
//不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

/**
 *  4 防止重写
 *  - 可以通过把方法、属性和下标标记为final来防止它们被重写。
 *  - 可以在class前加final来将整个类标记为final，这样的类就不可以被继承的。
 */



