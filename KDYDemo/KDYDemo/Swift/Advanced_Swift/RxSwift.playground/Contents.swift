//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var str = "RxSwift"

// Observable<Element>：是观察者模式中被观察的对象，相当于一个事件序列
// ObservableType & Obser

public func example(description: String, action: () -> ()) {
    print("\n--- \(description) example ---")
    action()
}

public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

func writeSequenceToConsole<O: ObservableType>(name: String, sequence: O) {
    sequence
        .subscribe { e in
            print("Subscription: \(name), event: \(e)")
    }
}

/**
 *  1 基本语法
 */

//@ empty
//一个空的序列，它只发送 .Completed消息
example("empty") {
    let emptySequence: Observable<Int> = Observable<Int>.empty()
    
    let subscription = emptySequence
        .subscribe { event in
            print(event)
        }
}

//@ never
//没有任何元素、也不会发送任何事件的空序列
example("never") {
    let neverSequence: Observable<String> = Observable.never()
    let subscription = neverSequence
        .subscribe { _ in
            print("This block is never called.")
    }
}

//@ just 
//只包含一个元素的序列，它会先发送 .Next(value) ，然后发送 .Completed
example("just") {
    let singleElementSequence = Observable.just(32)
    
    singleElementSequence
        .subscribe { event in
            print(event)
        }
}

//@ of 
//把一系列元素转换成事件序列
example("sequenceOf") {
    let sequenceOfElements = Observable.of(0, 1, 2, 3)
    
    sequenceOfElements
        .subscribe { event in
            print(event)
        }
}

//@ from
//通过 asObservable() 方法把 Swift 中的序列 (SequenceType) 转换成事件序列
example("from") {
    //    let sequenceFromArray = [1, 2, 3, 4, 5].asObservable()
    //    
    //    sequenceFromArray
    //        .subscribe { event in
    //            print(event)
    //        }
}

//@ create
//可以通过闭包创建序列，通过 .on(e: Event) 添加事件
example("create") {
    let myJust = { (singleElement: Int) -> Observable<Int> in
        return Observable.create { observer in
            observer.on(.Next(singleElement))
            observer.on(.Completed)
            return NopDisposable.instance
        }
    }
    
    let subscription = myJust(5)
        .subscribe { event in
            print(event)
        }
}

//@ failWith
//创建一个没有元素的序列，只会发送失败 (.Error) 事件
example("failWith") {
    //    let error = NSError(domain: "Test", code: -1, userInfo: nil)
    //    let erroredSequence: Observable<Int> = Observable.failWith(error)
    //    let subscription = erroredSequence
    //        .subscribe { event in
    //            print(event)
    //    }
}

/**
 *  2 Subjects
 *  - 它既是订阅者又是订阅源，这意味着它既可以订阅其他 Observable 对象，同时又可以对它的订阅者们发送事件
 */

//@ PublishSubject
//发送订阅者从订阅之后的事件序列
example("PublishSubject") {
    let subject = PublishSubject<String>()
    
    writeSequenceToConsole("1", sequence: subject)
    subject.on(.Next("a"))
    subject.on(.Next("b"))
    
    writeSequenceToConsole("2", sequence: subject)
    subject.on(.Next("c"))
    subject.on(.Next("d"))
}

//@ ReplaySubject
//在新的订阅对象订阅的时候会补发所有已经发送过的数据队列， bufferSize 是缓冲区的大小，决定了补发队列的最大值。如果 bufferSize 是1，那么新的订阅者出现的时候就会补发上一个事件，如果是2，则补两个
example("ReplaySubject") {
    let subject = ReplaySubject<String>.create(bufferSize: 1)
    
    writeSequenceToConsole("1", sequence: subject)
    subject.on(.Next("a"))
    subject.on(.Next("b"))
    
    writeSequenceToConsole("2", sequence: subject)
    subject.on(.Next("c"))
    subject.on(.Next("d"))
}

//BehaviorSubject
//在新的订阅对象订阅的时候会发送最近发送的事件，如果没有则发送一个默认值
example("BehaviorSubject") {
    let subject = BehaviorSubject(value: "z")
    
    writeSequenceToConsole("1", sequence: subject)
    subject.on(.Next("a"))
    subject.on(.Next("b"))
    
    writeSequenceToConsole("2", sequence: subject)
    subject.on(.Next("c"))
    subject.on(.Completed)
}

/**
 *  3 Transform
 *  - 可以对序列做一些转换，类似于 Swift 中 CollectionType 的各种转换
 */

//@ map
//对每个元素都用函数做一次转换，挨个映射一遍
example("map") { 
    let originalSequence = Observable.of(1, 2, 3)
    
    originalSequence
        .map { $0 * 2 }
        .subscribe { print($0) }
}

//@ flatMap
//map 在做转换的时候很容易出现『升维』的情况，即：转变之后，从一个序列变成了一个序列的序列。在 Swift 中，我们可以用 flatMap 过滤掉 map 之后的 nil 结果。在 Rx 中， flatMap 可以把一个序列转换成一组序列，然后再把这一组序列『拍扁』成一个序列。
example("flatMap") {
    let sequenceInt = Observable.of(1, 2)
    let sequenceString = Observable.of("A", "B", "C")
    
    sequenceInt
        .flatMap { int in
            sequenceString
        }
        .subscribe { print($0) }
}

//@ scan
//有点像 reduce ，它会把每次的运算结果累积起来，作为下一次运算的输入值
example("scan") {
    let sequenceToSum = Observable.of(0, 1, 2, 3, 4, 5)
    
    sequenceToSum
        .scan(0) { acum, elem in
            acum + elem
        }
        .subscribe { print($0) }
}

//@ reduce
example("reduce") {
    let sequenceToSum = Observable.of(0, 1, 2, 3, 4, 5)
    
    sequenceToSum
        .reduce(0) { acum, elem in
            acum + elem
        }
        .subscribe { print($0) }
}

/**
 *  4 Filtering
 *  - 对序列进行过滤
 */

//@ filter
//过滤符合要求的元素
example("filter") { 
    let sequenceToFilter = Observable.of(0, 1, 2, 3, 4, 5)
    
    sequenceToFilter
        .filter { $0 % 2 == 0 }
        .subscribe { print($0) }
}

//@ distinctUntilChanged
//废弃掉相邻间重复的事件
example("distinctUntilChanged") {
    let subscription = Observable.of(1, 2, 2, 3, 1, 1, 4)
        .distinctUntilChanged()
        .subscribe { print($0) }
}

//@ take
//只获取序列中的前 n 个事件，在满足数量之后会自动 .Completed
example("take") { 
    let subscription = Observable.of(1, 2, 3, 4, 5, 6)
        .take(3)
        .subscribe { print($0) }
}

/**
 *  5 Combining
 *  - 这部分是关于序列的运算，可以将多个序列源进行组合拼装成一个新的事件序列
 */

//@ startWith
//会在队列开始之前插入一个事件元素
example("startWith") { 
    let subscription = Observable.of(4, 5, 6)
        .startWith(3)
        .subscribe { print($0) }
}

//@ combineLatest
//两条事件队列，需要同时监听，那么每当有新的事件发生的时候，combineLatest 会将每个队列的最新的一个元素进行合并
example("combineLatest") {
    let stringOb1 = PublishSubject<String>()
    let intOb2 = PublishSubject<Int>()
    
    Observable.combineLatest(stringOb1, intOb2) {
        "\($0) \($1)" }
        .subscribe { print($0) }
    
    stringOb1.on(.Next("A"))
    stringOb1.on(.Next("B"))
    intOb2.on(.Next(1))
    intOb2.on(.Next(2))
}

//@ zip
//就是合并两条队列用的，不过它会等到两个队列的元素一一对应地凑齐了之后再合并
example("zip") {
    let stringOb1 = PublishSubject<String>()
    let intOb2 = PublishSubject<Int>()
    
    Observable.zip(stringOb1, intOb2) {
        "\($0) \($1)" }
        .subscribe { print($0) }
    
    stringOb1.on(.Next("A"))
    stringOb1.on(.Next("B"))
    intOb2.on(.Next(1))
    intOb2.on(.Next(2))
}

//@ merge
//把两个队列按照顺序组合在一起
example("merge") {
    let subject1 = PublishSubject<Int>()
    let subject2 = PublishSubject<Int>()
    
    Observable.of(subject1, subject2)
        .merge()
        .subscribeNext { int in
            print(int)
        }
    
    subject1.on(.Next(1))
    subject1.on(.Next(2))
    subject2.on(.Next(3))
    subject1.on(.Next(4))
    subject2.on(.Next(5))
}

//@ switch
//当你的事件序列是一个事件序列的序列 (Observable<Observable<T>>) 的时候，可以使用 switch 将序列的序列平铺成一维，并且在出现新的序列的时候，自动切换到最新的那个序列上

/**
 *  6 Error Handling
 */

//@ catchError
//捕获异常事件，并且在后面无缝接上另一段事件序列，丝毫没有异常的痕迹
example("catchError") {
    let sequenceThatFails = PublishSubject<Int>()
    let recoverySequence = Observable.of(100, 200)
    
    sequenceThatFails
        .catchError { error in
            return recoverySequence
        }
        .subscribe { print($0) }
    
    sequenceThatFails.on(.Next(1))
    sequenceThatFails.on(.Next(2))
    sequenceThatFails.on(.Error(NSError(domain: "Test", code: 0, userInfo: nil)))
}

//@ retry
//在出现异常的时候会再去从头订阅事件序列，妄图通过『从头再来』解决异常

/**
 *  7 Utility
 */

//@ subscribe
//@ subscribeNext
//@ subscribeCompleted
//@ subscribeError

//@ doOn
//可以监听事件，并且在事件发生之前调用
example("doOn") {
    let sequenceOfInts = PublishSubject<Int>()
    
    sequenceOfInts
        .doOn {
            print("Intercepted event \($0)")
        }
        .subscribe { print($0) }
    
    sequenceOfInts.on(.Next(1))
    sequenceOfInts.on(.Completed)
}


