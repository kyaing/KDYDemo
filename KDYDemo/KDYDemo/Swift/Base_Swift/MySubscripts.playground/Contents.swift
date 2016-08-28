//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Subscripts"

/**
 *  1 下标语法
 *  - 下标可以定义在类、结构体和枚举中，是访问集合、列表和序列元素的快捷方式。
 *  - 下标语法类似于实例方法和计算型语法的混合。
 */

//subscript(index: Int) -> Int {
//    get {
//        return 0
//    }
//    
//    set(newValue) {
//        
//    }
//}

//subscript(index: Int) -> Int {
//    return 0
//}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)


/**
 *  2 下标用法
 */
var numberOfLges = ["spider": 8, "ant": 6, "cat": 4]
numberOfLges["bird"] = 2


/**
 *  3 下标选项
 */
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}


