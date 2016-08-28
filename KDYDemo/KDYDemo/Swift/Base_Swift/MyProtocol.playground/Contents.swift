//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Protocol"

/**
 *  协议定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。
 *  类、结构体或枚举都可以采纳协议，并为协议定义的这些要求提供具体实现。
 *  某个类型能够满足某个协议的要求，就可以说该类型“符合”这个协议。
 */

/**
 *  1 属性要求
 *  - 协议不指定属性是存储型属性还是计算型属性，只指定属性的名称和类型，同时总是用var来声明。
 */
protocol VarProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    
    static var someTypePropery: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")

/**
 *  2 方法要求
 *  - 协议可以要求采纳协议的类型实现某些指定的实例方法或类方法。像普通方法定义一样，但不要大括号和方法体。
 */
protocol SomeProtocol {
    static func someTypeMethod()
}

protocol AnotherProtocol {
    
}

protocol RandomNumberGenerator {
    func random() -> Double
}

/**
 *  3 Mutaing方法要求
 *  - 实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字；
 *    对于结构体和枚举，则必须写 mutating 关键字。
 */
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

protocol Vehicle {
    var numberOfWheels: Int { get }
    var color: UIColor { get set }
    
    mutating func changeColor()
}

struct MyCar: Vehicle {
    let numberOfWheels = 4
    var color = UIColor.redColor()
    
    mutating func changeColor() {
        color = UIColor.greenColor()
    }
}

/**
 *  4 构造器要求
 *  - 协议可以要求采纳协议的类型实现指定的构造器
 */
protocol SomeProtocol2 {
    init(someParam: Int)
}

class SomeClass: SomeProtocol2 {
    /**
     当类要采纳此协议时，要为构造器加上required，
     为了确保所有它的子类也都要提供此构造器的实现，从而了能符合协议
     */
    required init(someParam: Int) {
        print("init")
    }
}

//final修饰在class、func、var前面，表示不许进行继承或重写操作
final class SomeClass2: SomeProtocol2 {
    init(someParam: Int) {
        print("init")
    }
}

protocol SomeProtocol3 {
    init()
}

class SomeSuperClass {
    init() {}
}

class SomeSubClass: SomeSuperClass, SomeProtocol3 {
    //采纳协议，加上required修饰；继承父类，加上override
    required override init() {
        
    }
}

/**
 *  5 协议作为类型
 *  协议本身没有实现任何功能，但是它可以被当做一个成熟的类型来使用。
 *  协议的使用场景：
 *  - 作为函数、方法或构造器中的参数类型或返回值类型；
 *  - 作为常量、变量或属性的类型；
 *  - 作为数组、字典或其它容器中的元素类型。
 */

struct Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator)  {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//协议作为函数参数
//下面让函数不仅支持类，还支持结构体
protocol Named {
    var name: String { get set }
}

class People: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Pet: Named {
    var name: String
}

//这里就声明一个泛型函数，使用类型遵循协议Named
func changeName<T: Named>(inout named: T, toName newNamed: String) {
    named.name = newNamed
}

var nick = People(name: "nick")
changeName(&nick, toName: "NICK")
print(nick.name)

var maru = Pet(name: "Maru")
changeName(&maru, toName: "Haru")
print(maru.name)

/**
 *  6 委托(代理)模式
 *  - 委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。
 */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: class {
    func gameDidStart(game: DiceGame)
    func gameDidEnd(game: DiceGame)
}

/**
 *  7 通过扩展添加协议一致性
 *  - 通过扩展令已有类型采纳并符合协议时，该类型的所有实例也会随之获得协议中定义的各项功能。
 */
protocol TextRepresendtable {
    var textualDescription: String { get }
}

//通过扩展采纳并符合协议
extension Dice: TextRepresendtable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

/**
 *  8 通过扩展采纳协议
 *  - 即使满足了协议的所有要求，类型也不会自动采纳协议，必须显式地采纳协议
 */

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresendtable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresendtable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

/**
 *  9 协议类型的集合
 *  - 协议类型可以在数组或字典这种集合中使用。
 */

let things: [TextRepresendtable] = []
for thing in things {
    print(thing.textualDescription)
}

/**
 *  10 协议的继承
 *  - 协议能够继承一个或多个其它协议，可以在继承的协议的基础上增加新的要求。
 */

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    //协议的定义部分
}

protocol PrettyTextRepresentable: TextRepresendtable {
    var prettyTextDescription: String { get }
}

/**
 *  11 类类型专属协议
 *  - 可以在协议的继承列表中，添加class关键字限制协议只能被类类型采纳，而结构体和枚举不能采纳该协议。
 *    并且class关键字必须第一个出现在协议的继承列表中，在其它协议之前。
 *  - 当协议定义的要求需要采纳协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。
 */

protocol SomeClassOnlyProtocol: class, InheritingProtocol {
    //类类型专属协议的定义部分
}

class SomeMyClass: SomeClassOnlyProtocol {
    static func someTypeMethod() {}
}

/**
 *  12 协议合成
 *  - 需要同时采纳多个协议时，可以将多个协议采用 protocol<SomeProtocol, AnotherProtocol>
 */

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct PersonTwo: Named, Aged {
    var name: String
    var age: Int
}

//Named和Aged两个协议合成一个协议，作为函数形参
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name), you're \(celebrator.age)")
}

let birthdayPerson = PersonTwo(name: "David", age: 21)
wishHappyBirthday(birthdayPerson)

/**
 *  13 检查协议一致性
 *  - 可以使用is和as操作符来检查协议的一致性，即是否符合某协议，并且可以转换到指定的协议类型。
 *  
    is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
    as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
    as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
 */
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("No area")
    }
}

/**
 *  14 可选的协议要求
 *  - 协议可以定义可选要求，采纳协议的类型可以选择是否实现这些要求，用optional来标记。
 *    可选的协议要求只能用在标记 @objc特性的协议中。
 */
@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

/**
 *  15 协议扩展
 *  协议可以通过扩展来为采纳协议的类型提供属性、方法及下标的实现；
 *  通过这种方式，可以基于协议本身来实现这些功能，而不用在每个采纳协议的类型中都重复同样的操作。
 */
protocol P {
    func a()
}

//这里的扩展协议实现了P协议中并没有定义的接口
extension P {
    func a() {
        print("default implementation of A")
    }
    
    func b() {
        print("default implementation of B")
    }
}

struct S: P {
    func a() {
        print("specialized implementation of A")
    }
    
    func b() {
        print("sepcialized implementation of B")
    }
}

let p: P = S()
p.a()
p.b()

//提供默认实现
//可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。
extension PrettyTextRepresentable {
    var prettyTextDescription: String {
        return textualDescription
    }
}

//为协议扩展添加限制条件
extension CollectionType where Generator.Element: TextRepresendtable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joinWithSeparator(", ") + "]"
    }
}

/*************************************/

//在实际的开发过程中，以下的方式有些笨重
class CommonViewController {
    func someMethod() {}
}

class MyViewController: UIViewController {
    var commonVC = CommonViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        commonVC.someMethod()
    }
}

class MyTableViewController: UITableViewController {
    var commonVC = CommonViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        commonVC.someMethod()
    }
}

class MyCollectionViewController: UICollectionViewController {
    var commonVC = CommonViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        commonVC.someMethod()
    }
}

//改用协议的方式来修改以上的继承关系
protocol CommonController {
    func someMethod()
}

extension CommonController {
    func someMethod() {
        print("someMethod")
    }
}

class MyViewController2: CommonController {
    
}

class MyTableViewController2: CommonController {
    
}

//...
//以上的做法就完全就可以增加代码结构性！


