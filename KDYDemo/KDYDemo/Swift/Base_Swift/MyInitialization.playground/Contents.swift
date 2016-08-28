//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Initialization"

/**
 *  构造过程是使用类、结构体或枚举类型的实例之前的准备过程，
 *  Swift的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化。
 */

/**
 *  1 存储属性的初始赋值
 *  - 类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。
 */

//构造器
//init() {
//    
//}

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()

//默认属性值
//可以在构造器中为存储型属性设置初始值，也可以在属性声明时为其设置默认值

//构造参数
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)

//结构体的逐一成员构造器
//逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

/**
 *  2 自定义构造过程
 */

//参数的内部名称和外部名称
//如果不通过外部参数名传值，是没法调用这个构造器的
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//不带外部名的构造器参数

//可选属性类型
//可选类型的属性自动初始化为nil，表示这个属性有意在初始化时设置为空
class SurveyQuestion {
    var text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

//构造过程中常量属性的修改
//只要在构造过程结束时它是一个确定的值，一旦常量属性被赋值，它将永远不可被更改。
//对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改

/**
 *  3 默认构造器
 *  - 如果结构体或类的所有属性都有默认值，同时没有自定义的构造器时，Swift会提供个默认的构造器
 */
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var shopItem = ShoppingListItem()

/**
 *  4 值类型的构造器代理
 *  类的构造器代理规则：
 *  - 指定构造器必须调用其直接父类的的指定构造器。
 *  - 便利构造器必须调用同一类中定义的其它构造器。
 *  - 便利构造器必须最终导致一个指定构造器被调用。
 */

//类的继承和构造过程
//类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
//Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。

//指定构造器和便利构造器
//指定构造器（designated initializers）是类中最主要的构造器；每一个类都必须拥有至少一个指定构造器。
//便利构造器（convenience initializers）是类中比较次要的、辅助型的构造器。

//两段式构造过程

//构造器的继承和重写
//跟OC的子类不同，Swift中的子类默认情况下不会继承父类的构造器。
//自动获得的默认构造器总会是类中的指定构造器
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

//构造器的自动继承

//以上知识点的实践
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

/**
 *  5 可失败构造器
 *  - 如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器
 */
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

//带原始值的枚举类型的可失败构造器
enum TemperatureUnit: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

class Document {
    var name: String?
    init() {}
    
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

/**
 *  6 必要构造器
 *  - 在类的构造器前添加required修饰符，表明所有该类的子类都必须实现该构造器
 */
class SomeClass {
    required init() {
        
    }
}

class SomeSubclass: SomeClass {
    required init() {
        
    }
}

/**
 *  7 通过闭包或函数设置属性的默认值
 *  - 若使用闭包来初始化属性，要记住在闭包执行时，实例的其它部分还没有初始化。意味着闭包里不能访问其它属性。
 */

//class SomeClass {
//    let someProperty: SomeType = {
//        // 在这个闭包中给 someProperty 创建一个默认值
//        // someValue 必须和 SomeType 类型相同
//        return someValue
//    }()
//}



/**
 *  1 析构过程原理
 *  - 析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。
 *  - 每个类最多只能有一个析构器，而且析构器不带有任何参数。
 */

//deinit {
//
//}

/**
 *  2 析构器实践
 */

