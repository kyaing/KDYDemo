//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Enum"

/**
 *  Swift中的枚举类型是一种类型，它采用了许多只被Class所支持的特性。
 */

/**
 *  1 枚举语法
 */
enum SomeEnumeration {
    
}

enum CompassPoint {
    case North
    case South
    case East
    case West
}

/**
 *  2 使用switch语句匹配枚举值
 */
var direction = CompassPoint.East
direction = .West
switch direction {
    case .North:
        print("")
    case .South:
        print("")
    case .East:
        print("")
    case .West:
        print("")
}

/**
 *  3 关联值
 */
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

/**
 *  4 原始值
 */

//ASCIIControlCharacter的原始值为Character
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
}

/**
 *  5 递归枚举
 */
enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}









