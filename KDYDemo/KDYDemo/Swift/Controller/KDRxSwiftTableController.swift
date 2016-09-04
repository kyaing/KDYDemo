//
//  KDRxSwiftTableController.swift
//  KDYDemo
//
//  Created by kaideyi on 16/9/4.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

/// RxSwift实现一个UITableView
class KDRxSwiftTableController: UIViewController {

    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
        return tableView
    }()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, UserModel>>()
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(myTableView)
        
        myTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        //配置Cell
        dataSource.configureCell = {
            _, tableView, indexPath, user in
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            cell.textLabel?.text = user.screenName
            cell.selectionStyle = .None
            
            return cell
        }
        
        //绑定数据
        viewModel.getUsers()
            .bindTo(myTableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
    }
}

