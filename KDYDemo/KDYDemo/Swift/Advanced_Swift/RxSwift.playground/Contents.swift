//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var str = "RxSwift"

// Observable<Element>：是观察者模式中被观察的对象，相当于一个事件序列

public func example(description: String, action: () -> ()) {
    print("\n--- \(description) example ---")
    action
}

public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

/**
 *  1 基本语法
 */

//@ empty：
//一个空的序列，它只发送 .Completed消息
example("empty") {
    let emptySequence: Observable<Int> = Observable<Int>.empty()
    
    let subscription = emptySequence
        .subscribe { event in
            print(event)
        }
}

//@ never











