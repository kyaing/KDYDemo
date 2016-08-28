//: Playground - noun: a place where people can play

import UIKit

var str = "高阶函数"

/**
 *  接受其它函数作为函数的函数有时被称为高阶函数。
 */

//@ 泛型介绍
func incrementArray(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x + 1)
    }
    return result
}

func doubleArray(xs: [Int]) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x * 2)
    }
    return result
}

//将上面的代码进行抽象，追加一个新参数来接受一个函数
func computeIntArray(xs: [Int], transform: Int -> Int) -> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func doubleArray2(xs: [Int]) -> [Int] {
    return computeIntArray(xs, transform: { (x) -> Int in
        x * 2
    })
}

//将computeIntArray抽象为更为泛型的做法，“类型签名”
func genericComputeArray<T>(xs: [Int], transform: Int -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    
    return result
}

//可以继续将上面的代码抽象化，将数组也给抽象化
func map<Element, T>(xs: [Element], transform: Element -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    
    return result
}

//@ Filter
extension Array {
    //只是为了练习，一般没有必要重写map，filter，reduce这些方法
    func filter(includeElement: Element -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        
        return result
    }
}

let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]
func getSwiftFile(files: [String]) -> [String] {
    return files.filter { file in file.hasSuffix(".swift") }
}

//@ Reduce
func sum(xs: [Int]) -> Int {
    var result: Int = 0
    for x in xs {
        result += x
    }
    
    return result
}

sum([1,2,3,4])  //10

func concatenate(xs: [String]) -> String {
    var result: String = ""
    for x in xs {
        result += x
    }
    
    return result
}

extension Array {
    //reduce需要一个T类型的初始值，以及一个用于更新for循环中变量值的函数combine: (T, Element) -> T
    func reduce<T>(initial: T, combine: (T, Element) -> T) -> T {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        
        return result
    }
}

func sumUsingReduce(xs: [Int]) -> Int {
   return xs.reduce(0) { result, x in result + x }
}

//@ 实际运用（map、filter、reduce）
struct City {
    let name: String
    let population: Int
}

extension City {
    func cityByScalingPopulation() -> City {
        return City(name: name, population: population * 1000)
    }
}

let paris = City(name: "Paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)
let cities = [paris, madrid, amsterdam, berlin]

cities.filter { $0.population > 1000 }
    .map { $0.cityByScalingPopulation() }
    .reduce("City: Population") { result, c in
        return result + "\n" + "\(c.name): \(c.population)"
    }

//@ 泛型和Any类型
/**
 * 它们最大的区别是：泛型可以用于定义灵活的函数，类型检查仍然由编译器负责；
 * 而Any类型则避开Swift的类型系统，所以要避免使用。
 */

//使用泛型
func noOp<T>(x: T) -> T {
    return x
}

//使用Any
func noOpAny(x: Any) -> Any {
    return x
}


