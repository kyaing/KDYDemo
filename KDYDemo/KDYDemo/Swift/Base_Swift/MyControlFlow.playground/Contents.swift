//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, ControlFlow"

/**
 *  Swift为我们提供了多种流程控制语句；
 *  while/for循环；选择不同分支的if/guard/switch；控制iy
 */

/**
 *  1 for-in
 */

//其中...表示闭区间操作符
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

//使用下划线(_)替代变量名来忽略对值的访问
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

/**
 *  2 while
 */
while 1 < 3 {
    
}

repeat {
    
} while 3 > 2


/**
 *  3 if / switch
 */

/**
 *  4 控制转移语句
 */

//continue：终止本次循环迭代，重新开始下次循环迭代

//break：立即结束整个控制流的执行

//fallthrough：像C语言风格一样的贯穿特性

/**
 *  5 检测API可用性
 */
if #available(iOS 8, OSX 10.10, *) {
    
} else {
    
}


