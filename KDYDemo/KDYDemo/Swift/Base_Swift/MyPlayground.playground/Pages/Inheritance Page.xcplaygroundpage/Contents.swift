//: [Previous](@previous)

import Foundation

var str = "Hello, Inheritance"

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        //什么也不做-因为车辆不一定会有噪音
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

class Bicyle: Vehicle {
    var hasBasket = false
}

let bicyle = Bicyle()
bicyle.hasBasket = true

class Tandem: Bicyle {
    var currentNumberOfPassengers = 0
    
    //重写方法
    override func makeNoise() {
        print("Not make nosise")
    }
}

class Car: Vehicle {
    var gear = 1
    //重写属性
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25
car.gear = 3
print("Car: \(car.description)")

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatiCar = AutomaticCar()
automatiCar.currentSpeed = 35
print("AutomaticCar: \(automatiCar.description)")

//: [Next](@next)
