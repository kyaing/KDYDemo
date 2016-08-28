//: Playground - noun: a place where people can play

import UIKit

var str = "函数"

/**
 *  1 函数的便捷性
 */

//@ 柯里化函数
//函数的柯里化通常被用于创建一组函数，并作为参数传入到更高阶的函数中

func isMultipleOf(num n: Int, i: Int) -> Bool {
    return i % n == 0
}

isMultipleOf(num: 3, i: 6)  //true, 6是3的整数倍
isMultipleOf(num: 2, i: 3)  //false, 3不是2的整数倍

let num = 1...10
let event = num.filter { isMultipleOf(num: 2, i: $0) }
print(event)

//利用柯里化函数改写，返回的函数类型是
func isMultipleOf(num n: Int) -> (Int -> Bool) {
    return { i in
        i % n == 0
    }
}

//@ 排序问题
let first = "firstName", last = "lastName"
let people = [
    [first: "Jo",     last: "Smith"],
    [first: "Joe",    last: "Smith"],
    [first: "Joe",    last: "Smyth"],
    [first: "Joanne", last: "Smith"],
    [first: "Robert", last: "Jones"],
]

let sortArray = people.sort { $0[last] < $1[last] }
print(sortArray)

/**
 *  2 函数作为代理
 */

/**
 *  3 inout和变异方法
 */

//@ inout 
//inout 是按值传递，然后再写回原变量，而不是按引用传递
func inc(inout i: Int) {
    i += 1
}

var x = 0
inc(&x)
print(x)

//@ 闭包
//除了inout方式，闭包也可以在函数内部改变变量值
func inc() -> () -> Int {
    var i = 0
    return { i++ }
}

let f = inc()
print(f())  //0
print(f())  //1

//用闭包来验证inout是值传递的
func inc2(inout i: Int) -> () -> Int {
    return { ++i }
}

var x2 = 0
let f2 = inc2(&x2)
print(f2())
print(x2)


/**
 *  4 计算属性和下标脚本
 */

struct File {
    private var cacheSize: Int?
    
    lazy var size: Int? = {
        var size: Int? = 0
        return size
    }()
    
    mutating func computeSize() -> Int {
        guard cacheSize == nil else { return cacheSize! }
        
        let size = 0
        //可能会有复杂的计算处理
        cacheSize = size
        return size
    }
}

//@ 重载下标脚本
let fibs = [1,2,3,4,5]
let firstNum = fibs[0]  //下标脚本的参数是Int类型

let nums = fibs[1..<3]  //下标脚本的参数是Range<Int>类型
print(nums)

//@ 下标脚本进阶
extension Dictionary {
    subscript(key: Key, or or: Value) -> Value {
        get {
            return self[key] ?? or  //使用空合运算符，如果self[key]为nil则返回or
        }
        
        set {
            self[key] = newValue
        }
    }
}

extension SequenceType where Generator.Element: Hashable {
    //统计数组中所有元素出现的频率，统计结果用字典表示，键就是元素，值是元素出现的次数
    func frequencies() -> [Generator.Element: Int] {
        var result: [Generator.Element: Int] = [:]
        for x in self {
            result[x, or: 0]++
        }
        
        return result
    }
}

var array = [100,200,100,300,200,200]
print(array.frequencies())

/**
 *  5 自动闭包和内存
 */

//@ @autoclosure关键字
var events = [1,2,3]
if !events.isEmpty && events[0] < 10 {
    events[0] = 4
}
print(events)













