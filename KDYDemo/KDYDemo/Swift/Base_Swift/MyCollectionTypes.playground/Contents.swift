//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, CollectionType"

/**
 *  Array、Set和Dictionary三种集合类型
 *  - Array是有序数据的集
 *  - Set是无序无重复数据的集
 *  - Nictionary无序的键值对的集
 */

/**
 *  1 Array
 */
var someArray = Array<Int>()

//上面数组的简化写法
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) item.")

someInts.append(3)
someInts = []

//带有默认值的数组
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
var otherDoubles = [Double](count: 3, repeatedValue: 2.5)
var sixDoubles = threeDoubles + otherDoubles

//用字面量构造数组
var shopingList: [String] = ["Eggs", "Milk"]

if shopingList.isEmpty {
    print("List is empty.")
} else {
    print("List is not empty.")
}

shopingList.append("Flour")
var firstItem = shopingList[0]

shopingList.insert("Maple", atIndex: 0)

let maple = shopingList.removeFirst()

//数组遍历
for item in shopingList {
    print("\(item)")
}

//enumerate()方法来进行数组遍历，返回的是个元组
for (index, value) in shopingList.enumerate() {
    print("Item \(String(index + 1)): \(value)")
}

/**
 *  2 Set
 *  - 用来存储同类型且没有顺序的值，当集合元素顺序不重要时或确保每个元素只出现一次
 */
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")

letters.insert("A")
letters = []

var favoriteGeners: Set<String> = ["Rock", "Classical", "Hip hop"]

//Set中的方法与Array方法差不多

for genre in favoriteGeners.sort() {
    print("\(genre)")
}

//集合操作
let oddDigits: Set = [1, 3, 5, 7, 9]
let eventDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(eventDigits).sort()
oddDigits.intersect(eventDigits).sort()

/**
 *  3 Dictionary
 */
var namesOfInt = [Int: String]()
namesOfInt[16] = "sixteen"
namesOfInt = [:]

var airports: [String: String] = ["YYZ": "Toronto", "UUB": "Dublin"]

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}

airports["LHR"] = "London"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

if let removedValue = airports.removeValueForKey("DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

//字典遍历
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

