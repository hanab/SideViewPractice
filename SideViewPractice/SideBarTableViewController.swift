//
//  SideBarTableViewController.swift
//  SideViewPractice
//
//  Created by Hana  Demas on 20/08/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import UIKit

protocol SideBarTableViewDelegate {
    func SidebarControllerDidSelsectRowAtIndex(indexPath:NSIndexPath)
}

class SideBarTableViewController: UITableViewController {
    
    //MARK: Properties
    var delegate:SideBarTableViewDelegate?
    var tableData:Array<String> = []
    
    //MARK: Viewcontroller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkTextColor()
            let selectedView:UIView = UIView(frame:CGRect(x: 0, y: 0, width: cell!.frame.width, height: cell!.frame.height))
            selectedView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        }
        cell!.textLabel?.text = tableData[indexPath.row]
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.SidebarControllerDidSelsectRowAtIndex(indexPath)
    }
}
