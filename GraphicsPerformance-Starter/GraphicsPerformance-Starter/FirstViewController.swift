//
//  FirstViewController.swift
//  GraphicsPerformance-Starter
//
//  Created by 张星宇 on 16/1/21.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let table = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 49))
    let imgArray = Array(1...10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        view.addSubview(table)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "tableviewcell"
        var cell = table.dequeueReusableCellWithIdentifier(identifier) as? CustomTableCell
        if cell == nil {
            cell = CustomTableCell(style: .Default, reuseIdentifier: identifier)
            cell?.selectionStyle = .None
        }
        cell?.setupContent(String(imgArray[indexPath.row]), text: "This is a label")
        if indexPath.row == 1 {
//            let tiffPath = NSBundle.mainBundle().pathForResource("example", ofType: "jp2")
//            cell?.imgView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://images.bestswifter.com/UIKitPerformance/example.jp2")!)!)
//            Alamofire.request(.GET, "http://read.pudn.com/downloads151/sourcecode/graph/658130/JPEG/Codes/sw/out__.jpg")
//                .responseImage { response in
//                    debugPrint(response)
//                    
//                    print(response.request)
//                    print(response.response)
//                    debugPrint(response.result)
//                    
//                    if let image = response.result.value {
//                        cell?.imgView.image = image
//                    }
//            }
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

