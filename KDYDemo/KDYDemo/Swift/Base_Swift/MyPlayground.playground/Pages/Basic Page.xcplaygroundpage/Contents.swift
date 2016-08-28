//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let redColor = UIColor.orangeColor()
let str = "Hello World!!!"
let tuple = (100, "Hello", 200.0)

let rect = CGRectMake(0, 0, 500, 200)
let point = CGPointMake(100, 300)
let size = CGSizeMake(100, 300)

let image = UIImage(named: "doge")
let url = NSURL(string: "http://www.baidu.com")

let attr = NSAttributedString(string: "This is a Attributedstring", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.redColor()])

let view = UIView(frame: CGRect(x: 20, y: 30, width: 100, height: 50))
view.backgroundColor = UIColor.redColor()

for i in 1...100 {
    let f = Float(i)
    sin(f) * f
}

print("1234567")
NSLog("%@", view)

var a = 5
var b = a
print("a = \(a), b = \(b)")
print(unsafeAddressOf(a))
print(unsafeAddressOf(b))

let message = "Hello Swift!"
let names = [String]()
var deviceModels = [String]()

for _ in 0..<3 {
    print("Hello Swift Three times")
}



/**
 *  闭包
 */
//1.闭包表达式
//{ (parametes) -> returnType in
//    statements
//}

var nameString = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

// (s1: String, s2: String) -> Bool
//var reversed = names.sort() { (s1: String, s2: String) -> Bool
//    in return s1 > s2
//}

//根据上下文抢断类型
//var reversed = names.sort() { s1, s2 in return s1 > s2 }

//单表达式闭包隐式返回
//var reversed = names.sort() { s1, s2 in s1 > s2 }

//参数名称缩写，Swift为内联闭包提供了参数名缩写功能
var reversed = names.sort() { $0 > $1 }

//2.尾随闭包
//若想将一个很长的闭包表达式作为最后一个参数传递给函数，用可以用尾随闭包

//如果函数只需要闭包一个参数，在使用尾随闭包时，可以把()去掉
reversed = names.sort { $0 > $1 }

//3.捕获值
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementor
}

//4.非逃逸闭包
func someFounctionWithNoesClosure(@noescape closure: () -> Void) {
    closure()
}

//使闭包逃逸出函数的方法，可以将它保存在一个函数外部定义的变量中
var complectionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(complectionHandler: () -> Void) {
    complectionHandlers.append(complectionHandler)
}

//func doSomting(@noescape some:() -> Void) {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(2 * NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
//        some()
//    }
//}

//5.自动闭包
print(nameString.count)
//customer的类型不是String, 而是() -> String, 一个没有参数且返回会值为String的
let customer = { nameString.removeAtIndex(0) }
print(nameString.count)

print("Now serving \(customer())!")
print(nameString.count)

//try?
struct TodoList {
    
}

struct TodoListParser {
    enum Error: ErrorType {
        case InvalidJSON
    }
    
    func parse(fromData data: NSData) throws -> TodoList {
        guard let _ = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject] else {
            throw Error.InvalidJSON
        }
        
        return TodoList()
    }
}

/**
 * 错误处理；
 * Swift刚刚出现时并不支持异常处理，然而OC也没有真正地支持异常处理。
 */
//do {
//    
//} catch {
//    
//}

/**
 * Guard语句，它最直接的作用就是排除错误的条件
 */
if (true) {
    //true branch
} else {
    //false branch
}

guard (1 < 3) else {
    //false branch
}
//ture branch

/**
 *  Defer{}语句，它可以与Guard语句一起用
 */
let tmpMemory = malloc(5)
defer {
    free(tmpMemory)
}

/// <训练Swift的编程思想>
class ListItem {
    var icon: UIImage?
    var title: String = ""
    var url: NSURL!
    
    /**
     * 1.从OC直译成Swift，low的地方：
     *  到处使用隐式解析可选类型(value!)；强制转型(value as! String)；强制使用try(try!)
     */
    static func listItemsFromJSONData(jsonData: NSData?) -> NSArray {
        let jsonItems: NSArray = try! NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments) as! NSArray
        let items: NSMutableArray = NSMutableArray()
    
        for itemDesc in jsonItems {
            let item: ListItem = ListItem()
            item.icon = UIImage(named: itemDesc["icon"] as! String)
            item.title = itemDesc["title"] as! String
            item.url = NSURL(string: itemDesc["url"] as! String)!
            
            items.addObject(item)
        }
        
        return items
    }
    
    /**
     * 2.第一次改写上面代码：
     *  使用可选绑定(if let x = optional{}); 用as?替换掉as!方式；也可以用try?替换try!
     */
    static func listItemsFromJSONData2(jsonData: NSData?) -> NSArray {
        if let nouNilJsonData = jsonData {
            if let jsonItems: NSArray = (try? NSJSONSerialization.JSONObjectWithData(nouNilJsonData, options: [])) as? NSArray {
                let items: NSMutableArray = NSMutableArray()
                for itemDesc in jsonItems {
                    let item: ListItem = ListItem()
                    if let icon = itemDesc["icon"] as? String {
                        item.icon = UIImage(named: icon)
                    }
                    
                    if let title = itemDesc["title"] as? String {
                        item.title = title
                    }
                    
                    if let urlString = itemDesc["url"] as? String {
                        if let url = NSURL(string: urlString) {
                            item.url = url
                        }
                    }
                    items.addObject(item)
                }
                
                return items.copy() as! NSArray
            }
        }
        
        return []
    }
    
    /**
     * 3.再次改写上面代码：
     *  将多个if let 语句合并为一个(if let x = opt1, y = opt2)；使用guard语句；修改返回类型
     */
    static func listItemsFromJSONData3(jsonData: NSData?) -> [ListItem] {
        //使用guard语句，大大简化了判断语句，它只专注于检查输入是否有效
        guard let nonNilJsonData = jsonData,
            let json = try? NSJSONSerialization.JSONObjectWithData(nonNilJsonData, options: []),
            let jsonItems = json as? Array<NSDictionary>
            else {
                return []
        }
        
        var items = [ListItem]()
        for itemDesc in jsonItems  {
            let item = ListItem()
            if let icon = itemDesc["icon"] as? String {
                item.icon = UIImage(named: icon)
            }
            
            if let title = itemDesc["title"] as? String {
                item.title = title
            }
            
            if let urlString = itemDesc["url"] as? String, let url = NSURL(string: urlString) {
                item.url = url
            }
            
            items.append(item)
        }
        return items
    }
    
    /**
     * 4.继续精简上面的代码：
     *  即是使用更多的Swifter开发的模式和讲法，这样让代码看起来更棒并且简洁。
     */
    static func listItemsFromJSONData4(jsonData: NSData?) -> [ListItem] {
        //使用guard语句，大大简化了判断语句，它只专注于检查输入是否有效
        guard let nonNilJsonData = jsonData,
            let json = try? NSJSONSerialization.JSONObjectWithData(nonNilJsonData, options: []),
            let jsonItems = json as? Array<NSDictionary>
            else {
                return []
        }
        
        //使用了Array中的map()方法：[X]->[Y]；来代替for-in循环
        /**
         * 方法：map( transform: T -> U ) -> Array<U>
         *   或：map( transform: T -> U ) -> Optional<U>
         * 它的意思就是用一个给定的transform: T -> U，将一个元素类型是T的数组转换成一个元素类型是U的数组；对于Array<T>调用map()就会返回一个Array<U>
         */
        return jsonItems.map { (itemDesc: NSDictionary) -> ListItem in
            let item = ListItem()
            if let icon = itemDesc["icon"] as? String {
                item.icon = UIImage(named: icon)
            }
            
            if let title = itemDesc["title"] as? String {
                item.title = title
            }
            
            if let urlString = itemDesc["url"] as? String, let url = NSURL(string: urlString) {
                item.url = url
            }
            
            return item
        }
        
        //使用了Array中的faltMap()方法：[X]->[Y]?
        /**
         * 方法：flatmap( transform: T -> Array<U> ) -> Array<U>
         *   或：flatMap( transform: T -> Optional<U> ) -> Optional<U>
         */
        return jsonItems.flatMap({ (itemDesc: NSDictionary) -> ListItem? in
            guard let title = itemDesc["title"] as? String,
                let urlString = itemDesc["url"] as? String,
                let url = NSURL(string: urlString)
                else {
                    return nil
            }
            
            let item = ListItem()
            if let icon = itemDesc["icon"] as? String {
                item.icon = UIImage(named: icon)
            }
            
            item.title = title
            item.url = url
            
            return item
        })
    }
}

///类ListItem，修改后的最终版本
struct ListItemFinal {
    var icon: UIImage?
    var title: String
    var url: NSURL
    
    static func listItemsFromJSONData(jsonData: NSData?) -> [ListItemFinal] {
        guard let nonNilJsonData = jsonData,
            let json = try? NSJSONSerialization.JSONObjectWithData(nonNilJsonData, options: []),
            let jsonItems = json as? Array<NSDictionary>
            else {
                return []
        }
        
        return jsonItems.flatMap { (itemDesc: NSDictionary) -> ListItemFinal? in
            guard let title = itemDesc["title"] as? String,
                let urlString = itemDesc["url"] as? String,
                let url = NSURL(string: urlString)
                else {
                    return nil
            }
            
            let iconName = itemDesc["icon"] as? String
            //let icon = UIImage(named: iconName ?? "")
            let icon = iconName.flatMap { UIImage(named: $0) }
            
            return ListItemFinal(icon: icon, title: title, url: url)
        }
    }
}

/**
 *  如何处理Swift中的异步错误
 */


/**
 *  (guard let) 或 (if let)多重拆包中让元素强制可空
 */
func someArray() -> [Int]? {
    return [1, 2, 3, 4, 5, 6]
}

//func exapmle() {
//    guard let array = someArray(),
//        numberThree = array[2] where numberThress === 3
//        else { return }
//    print(numberThree)
//}

//对上个方法修改
func example() {
    guard let array = someArray(),
        //可能值内部一个有一个.Some和.None的枚举
        numberThree = Optional.Some(array[2])
        where numberThree == 3
        else { return }
    print(numberThree)
}

/**
 *  模式匹配一：swift, enum, where
 */
enum Direction {
    case North, South, East, West
}

extension Direction: CustomStringConvertible {
    var description: String {
        switch self {
        case .North: return "Up"
        case .South: return "Down"
        case .East:  return "Right"
        case .West:  return "Left"
        }
    }
}

enum Media {
    case Book(title: String, author: String, year: Int)
    case Movie(title: String, director: String, year: Int)
    case WebSite(url: NSURL, title: String)
}

//语法：case MyEnum.EnumValue(let variable)：表示如果对应的值是MyEnum.EnumValue且附带一个关联值，就绑定变量variable到该关联值上。
extension Media {
    var mediaTitle: String {
        switch self {
        case .Book(title: let aTitle, author: _, year: _):
            return aTitle
        case .Movie(title: let aTitle, director: _, year: _):
            return aTitle
        case .WebSite(url: _, title: let aTitle):
            return aTitle
        }
    }
    
    //使用where语句
    var publishedAfter1930: Bool {
        switch self {
        case let .Book(_, _, year) where year > 1930: return true
        case let .Movie(_, _, year) where year > 1930: return true
        default: return false
        }
    }
}

let book = Media.Book(title: "20,000 leagues under the sea", author: "Jules Verne", year: 1870)
book.mediaTitle

/**
 *  模式匹配二：元组，range和类型
 */
let point2 = CGPointMake(7, 0)
//_表示通配符，以及用let表示对变量进行绑定
switch (point2.x, point2.y) {
case (0, 0): print("On the origin!")
case (0, _): print("x = 0: on Y")
case (_, 0): print("y = 0: on X")
case let (x, y) where x == y : print("On x = y")
default: print("Quite a random point.")
}

//使用Range<T>
let count = 7
switch count {
case Int.min..<0: print("Negative count")
case 0: print("Nothing")
case 1: print("One")
case 2..<5: print("A few")
case 5..<10: print("Somw")
default: print("Many")
}

//将模式匹配用到类型上
protocol Medium {
    var title: String { get }
}

struct MyBook: Medium {
    let title: String
    let author: String
    let year: Int
}

struct MyMovie: Medium {
    let title: String
    let director: String
    let year: Int
}

struct WebSite: Medium {
    let title: String
    let url: NSURL
}

let media: [Medium] = [
    MyBook(title: "20,000 leagues under the sea", author: "Jules Vernes", year: 1870),
    MyMovie(title: "20,000 leagues under the sea", director: "Richard Fleischer", year: 1955)
]

for medium in media {
    print(medium.title)
    
    switch medium {
    case let b as MyBook:
        print("Book published in \(b.year)")
    case let m as MyMovie:
        print("Movie release in \(m.year)")
    default:
        print("No year into for \(medium)")
    }
}

/**
 *  Map & FlatMap & Filter & Reduce
 */

//对Optionals进行Map；如果这个可选值有值，就拆包。
var value: Int? = 1
var result = value.map { String("result = \($0)") }
print(result)

let values = [1, 3, 5, 7, 9]
//var results = [Int]()
//for var value in values {
//    value *= 2
//    results.append(value)
//}
//
//print(results)

//对SequenceType进行Map；
let results = values.map() { $0 * 2 }

var values2 = [[1, 3, 5, 7], [9]]
let faltenResult = values2.flatMap { $0 }
print(faltenResult)

//Filter；判断原数组中的元素是否有符合条件
let filterResults = values.filter { $0 % 3 == 0 }
print(filterResults)

//Reduce
let initialResult = 0
var reduceResult = values.reduce(initialResult) { (temResult, element) -> Int in
    return temResult + element
}
print(reduceResult)


/* 
 * protocol extension
 */
protocol MyPortocol {
    func method() -> Bool
}

//protocol extension为protocol中定义的方法提供了一个默认的实现
extension MyPortocol {
    var text: String {
        return "text"
    }
    
    func method() -> Bool {
        print("Called Method")
        return true
    }
}

struct MyStruct: MyPortocol {
    
}

MyStruct().method()





