//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, Class and Struct"

/**
 *  1 类和结构体对比
 */

/** 
 相同点：
    定义属性用于存储值；
    定义方法用于提供功能；
    定义附属脚本用于访问值；
    定义构造器用于生成初始化值；
    通过扩展以增加默认实现的功能；
    实现协议以提供某种标准功能；
 
 类的不同点：
    继承允许一个类继承另一个类的特征；
    类型转换允许在运行时检查和解释一个类实例的类型；
    析构器允许一个类实例释放任何其所被分配的资源；
    引用计数允许对一个类的多次引用；
 */

//定义语法
class SomeClass {
    //...
}

struct SomeStructure {
    //...
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode  = VideoMode()

//Swift允许直接设置结构体属性的子属性
someVideoMode.resolution.width = 1280

//成员逐一构造器
let vga = Resolution(width: 640, height: 480)

/**
 *  2 结构体和枚举是值类型
 *  - 值类型被赋予给一个变量、常量或被传递给一个函数的时候，其值会被拷贝。
 *  - Swift中的所有基本类型都是值类型，底层都是以结构体的形式所实现。
 */

/**
 *  3 类是引用类型
 *  - 引用的是已存在的实例本身而不是其拷贝。
 */

//恒等运算符
//(=== 和 !== ) 表示两个类类型(class type)的常量或者变量引用同一个类实例。

/**
 *  4 类和结构体的选择
 *  - 当考虑一个工程项目的数据结构和功能的时候，就要决定每个数据结构是类还是结构体。
 */

/**
 考虑使用结构体：
    该数据结构的主要目的是用来封装少量相关简单数据值。
    有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
    该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
    该数据结构不需要去继承另一个既有类型的属性或者行为。
*/

struct TestStruct {
    var with = 0
    
    enum myEnum {
        case North, West
    }
    
    class myClass {
        var Height = 100
    }
}

let hd = TestStruct()
let bd = hd


/**
 *  5 字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
 */

