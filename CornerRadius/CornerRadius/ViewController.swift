//
//  ViewController.swift
//  CornerRadius
//
//  Created by 张星宇 on 16/2/27.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let table = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        view.addSubview(table)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "tableviewcell"
        table.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: identifier)
        let cell = table.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? CustomTableViewCell

        cell?.selectionStyle = .None
        cell?.setupContent(imgName: "photo")
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
}

