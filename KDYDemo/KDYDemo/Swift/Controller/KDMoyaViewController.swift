//
//  KDMoyaViewController.swift
//  KDYDemo
//
//  Created by mac on 16/9/5.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import RxSwift

struct BoxofficeModel: Mapable {
    let rid: String?
    let name: String?
    let wk: String?
    let wboxoffice: String?
    let tboxoffice: String?
    
    init?(jsonData: JSON) {
        self.rid        = jsonData["rid"].string
        self.name       = jsonData["name"].string
        self.wk         = jsonData["wk"].string
        self.wboxoffice = jsonData["wboxoffice"].string
        self.tboxoffice = jsonData["tboxoffice"].string
    }
}

/// Moya + RxSwift + SwiftyJSON
class KDMoyaViewController: UIViewController {

    let disposeBag = DisposeBag()
    var boxModelArray = [BoxofficeModel]()
    
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
        
        myTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        //// 1 用MoyaProvider来请求
        //apiProvider.request(ApiService.GetRank(area: "CN")) { result in
        //    switch result {
        //    case let .Success(response):
        //        do {
        //            let json: Dictionary? = try response.mapJSON() as? Dictionary<String, AnyObject>
        //            if let json = json {
        //                print(json["result"] as! Array<AnyObject>)
        //                if let res: Array<AnyObject> = json["result"] as? Array<AnyObject> {
        //                    print("res = \(res)")
        //                }
        //            }
        //            
        //        } catch {
        //            
        //        }
        //        
        //    case let .Failure(error):
        //        print(error)
        //    }
        //}
 
        // 2 用RxMoyaProvider来请求
        rxApiProvider.request(ApiService.GetRank(area: "CN"))
            .mapResponseToArray(BoxofficeModel)
            .subscribe(
                onNext: { items in
                    // 接收数据，并刷新界面
                    self.boxModelArray = items
                    self.myTableView.reloadData()
                },
                onError: { error in
                    print(error)
                }
            )
            .addDisposableTo(disposeBag)
    }
}

extension KDMoyaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.boxModelArray.count > 0 ? self.boxModelArray.count : 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        if let name = boxModelArray[indexPath.row].name,
            let tboxoffice = boxModelArray[indexPath.row].tboxoffice {
            
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = "\(tboxoffice) 万元"
        }
        
        return cell
    }
}


