//
//  FirstViewController.swift
//  GraphicsPerformance-Starter
//
//  Created by 张星宇 on 16/1/21.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let table = UITableView(frame: CGRect(x: 0, y:0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 49))
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
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "tableviewcell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomTableCell
        if cell == nil {
            cell = CustomTableCell(style: .default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
        }
        cell?.setupContent(imgName: String(imgArray[indexPath.row]), text: "This is a label")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

