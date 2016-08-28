//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, TypeCasting"

/**
 *  类型转换，可以判断实例的类型，也可以将实例看做是其父类或子类的实例。
 */

/**
 *  1 定义一个类层次作为例子
 */
class MediaItem {
    var name: String
    init(name: String) { self.name = name }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

/**
 *  2 检查类型
 *  - 类型检查操作符(is)来检查一个实例是否属于特定子类型。
 */
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

/**
 *  3 向下转型
 *  - 向下转型：as? 或 as!
 */

/**
 *  4 Any和AnyObject的类型转换
 *  - Any可以表示任何类型，包括函数类型；AnyObject可以表示任何类类型的实例。
 */



