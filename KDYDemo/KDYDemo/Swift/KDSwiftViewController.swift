//
//  KDSwiftViewController.swift
//  KDYDemo
//
//  Created by kaideyi on 16/1/3.
//  Copyright © 2016年 kaideyi.com. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher
import RxSwift

// MARK: - PhotoInfo
class PhotoInfo {
    let id: Int
    let url: String
    
    init(_ id: Int, _ url: String) {
        self.id = id
        self.url = url
    }
}

// MARK: - KDSwiftViewController
class KDSwiftViewController: UIViewController {
    var photosArray: NSMutableArray = []
    
    //lazy属性加载
    lazy var photoTableView: UITableView  = {
        let tableView = UITableView()
        return tableView
    }()
    
    let rect = CGRect.zero
    let size = CGSize.zero
    let point = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Swift_PhotoDemo"
        self.view.backgroundColor = UIColor.whiteColor()
        
        photoTableView.delegate = self
        photoTableView.dataSource = self
        view.addSubview(photoTableView)
        
        photoTableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        //Alamofire请求
        learnAlamofire()
    }
    
    func learnAlamofire() {
        //1 向500px的api发出一个Get请求
        //加上consumer_key
        let requestURL = "https://api.500px.com/v1/photos"
        let params = [
            "consumer_key": "2VYcllvuY5RVbKpCLTuPeDbv0ZWZtjyk3aOWjWPg"
        ]
        
        Alamofire.request(.GET, requestURL, parameters: params, encoding: .URL, headers: nil)
        .responseJSON() {
            response in
            guard let jsonString = response.result.value else { return }
            
            //2 再取出JSON中的 photos对象
            guard let photoJsons = jsonString.valueForKey("photos") as? [NSDictionary] else { return }

            photoJsons.forEach {
                guard let nsfw = $0["nsfw"] as? Bool,
                    let id = $0["id"] as? Int,
                    let url = $0["image_url"] as? String
                    where nsfw == false else { return }
                
                self.photosArray.addObject(PhotoInfo(id, url))
                
                self.photoTableView.reloadData()
            }
            
            //3 或者再利用SwityJSON来解析，
            let json = JSON(jsonString)
            print("json = \(json)")
        
            let imgUrl = json["photos"][0]["image_url"].stringValue
            let id = json["photos"][0]["id"].intValue
            print("id = \(id), imgUrl = \(imgUrl)")
            
            print("jsonDic = \(json.dictionaryValue)")
            if let dic = json.dictionaryObject {
                print("dicNum = \(dic.count)")
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension KDSwiftViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count > 0 ? photosArray.count : 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = NSBundle.mainBundle().loadNibNamed("PhotoTableCell", owner: self, options: nil).last
                    as? PhotoTableCell
        if cell == nil {
            cell = tableView.dequeueReusableCellWithIdentifier(String(PhotoTableCell), forIndexPath: indexPath) as? PhotoTableCell
        }
        
        let photo = photosArray[indexPath.row] as! PhotoInfo
        cell?.imageView?.kf_setImageWithURL(NSURL.init(string: photo.url)!)
        
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension KDSwiftViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}

