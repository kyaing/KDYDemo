//: Playground - noun: a place where people can play

import UIKit

var str = "可选值"

/**
 *  1 案例研究：字典
 */

//[String: Int]
let cities = ["Paris": 2241, "Madrid": 3165, "Amsterdam": 827]

//无法保证取的键值总返回一个Int值，所以用可选值来表达这种失败的可能性
let madridPopulation: Int? = cities["Madrid"]

if madridPopulation != nil {
    print("The population of Madrid is \(madridPopulation! * 1000)")
} else {
    print("Unknown city: Madrid")
}

//可以用可能值绑定，来避免写!后缀
if let madridPopulation = cities["Madrid"] {
    print("The population of Madrid is \(madridPopulation * 1000)")
} else {
    print("Unknown city: Madrid")
}

/**
 *  2 玩转可选值
 */
struct Order {
    let orderNumber: Int
    let person: Person?
}

struct Person {
    let name: String
    let address: Address?
}

struct Address {
    let streetName: String
    let city: String
    let state: String?
}

//可选值链
/**
    //if let
    if let myState = order.person?.address?.state {
        print("This order will be shipped to \(myState)")
    } else {
        print("Unknown person, address, or state.")
    }
 */

//分支上的可选值
switch madridPopulation {
case 0?: print("Nobody in Madrid")
case (1..<1000)?: print("Less than a million in Madrid")
case .Some(let x): print("\(x) people in Madrid")
case .None: print("We don't know about Madrid")
}

//gurad：当某条件不满足时，就尽早退出当前作用域
func populationDescriptionForCity(city: String) -> String? {
    guard let population = cities[city] else { return nil }
    
    return "The population of Madrid is \(population * 1000)"
}
populationDescriptionForCity("Madrid")

func addOptinals(optionalX: Int?, optionalY: Int?) -> Int? {
    guard let x = optionalX, y = optionalY else { return nil }
    return x + y
}

//[String: String]
let capitals = [
    "France": "Paris",
    "Spain": "Madrid",
    "The Netherlands": "Amsterdam",
    "Belgium": "Brussels"
    ]

func populationOfCapital(country: String) -> Int? {
    guard let capital = capitals[country], population = cities[capital] else { return nil }
    return population * 1000
}

//@ 为什么使用可选值？
/**
 *  Swift的类型系统相当严格，一旦有可选类型，就必须要处理是nil的问题，
 *  选择显式的可选类型更符合 Swift 增强静态安全的特性。强大的类型系统能在代码执行前捕获到错误，
 *  而且显式可选类型有助于避免由缺失值导致的意外崩溃。
 */


