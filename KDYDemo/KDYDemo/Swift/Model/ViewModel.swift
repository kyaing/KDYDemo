//
//  ViewModel.swift
//  KDYDemo
//
//  Created by kaideyi on 16/9/4.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import RxSwift
import RxDataSources

class ViewModel: NSObject {
    func getUsers() -> Observable<[SectionModel<String, UserModel>]> {
        return Observable
            .create{ observable -> Disposable in
                let users =
                    [UserModel(followersCount: 19_901_990, followingCount: 1990, screenName: "Marco Sun"),
                    UserModel(followersCount: 19_890_000, followingCount: 1989, screenName: "Taylor Swift"),
                    UserModel(followersCount: 250_000, followingCount: 25, screenName: "Rihanna"),
                    UserModel(followersCount: 13_000_000_000, followingCount: 13, screenName: "Jolin Tsai"),
                    UserModel(followersCount: 25_000_000, followingCount: 25, screenName: "Adele")]
                let section = [SectionModel(model: "", items: users)]
                
                observable.onNext(section)
                observable.onCompleted()
                
                return AnonymousDisposable{}
            }
    }
}

