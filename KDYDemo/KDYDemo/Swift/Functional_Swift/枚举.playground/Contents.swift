//: Playground - noun: a place where people can play

import UIKit

var str = "枚举"

/**
 *  1 关于枚举
 */

enum Encoding {
    case ASCII
    case NEXTSTEP
    case JapaneseEUC
    case UTF8
}

//和OC不同的是，枚举在Swift中是创建了新的类型，与整数或其它已经存在的类型没有任何关系
//let myEncoding = Encoding.ASCII + Encoding.UTF8  //error

extension Encoding {
    var nsStringEncoding: NSStringEncoding {
        switch self {
        case .ASCII:
            return NSASCIIStringEncoding
        case .NEXTSTEP:
            return NSNEXTSTEPStringEncoding
        case .JapaneseEUC:
            return NSJapaneseEUCStringEncoding
        case .UTF8:
            return NSUTF8StringEncoding
        }
    }
}


/**
 *  2 关联值
 */

enum LookupError: ErrorType {
    case CapitalNotFound
    case PopulationNotFound
}

//成员带有关联值
enum PopulationResult {
    case Sucess(Int)
    case Error(LookupError)
}

let exampleSucess: PopulationResult = .Sucess(1000)


/**
 *  3 添加泛型
 */
let capitals = [
    "France": "Paris",
    "Spain": "Madrid",
    "The Netherlands": "Amsterdam",
    "Belgium": "Brussels"
]

let mayors = [
    "Paris": "Hidalgo",
    "Madrid": "Carmena",
    "Amsterdam": "van der Laan",
    "Berlin": "Müller"
]

func mayorOfCapital(country: String) -> String? {
    return capitals[country].flatMap { mayors[$0] }  //还是不太明白flatMap
}

//用泛型的枚举，来反映Optional作为返回值失败的可能性
enum Result<T> {
    case Success(T)
    case Error(ErrorType)
}

//func populationOfCapital(country: String) -> Result<Int>  //函数返回一个Int，或LookupError
//func mayorOfCapital(country: String) -> Result<String>  //函数返回一个String, 或ErrorType 

/**
 *  4 Swift中的错误处理
 *  - Swift中内建的错误处理机制与上文的Result类型很相似。
 *  - 但是它们区别还是有两点：Swift强调你注明哪些代码可能抛出错误，必须要用try；
 *    另外内建机制的局限性在于，它必须要借助函数的返回类型来触发。
 */

/*
    func populationOfCapital(country: String) throws -> Int {
        guard let capital = capitals[country] else {
            throw LookupError.CapitalNotFound
        }
        
        guard let population = cities[capital] else {
            throw LookupError.PopulationNotFound
        }
        
        return population
    }

    //要调用一个throws标记的函数，要将调用代码嵌入一个do-catch中
    do {
        let population = try populationOfCapital("France")
        print("France's population is \(population)")
        
    } catch {
        print("Lookup error: \(error)")
    }
 */

/**
 *  5 再说可选值
 */

enum Optional<T> {
    case None
    case Some(T)
}

/**
 *  6 数据类型中的代数学
 */

enum Add<T, U> {
    case InLeft(T)
    case InRight(U)
}

enum Zero {}

/**
 *  7 为什么要用枚举？
 */


