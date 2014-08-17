//
//  TableViewController.swift
//  ChatLogsDemo
//
//  Created by Josh Chung on 8/15/14.
//  Copyright (c) 2014 Josh Chung. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...100 {
            messages.append(createRandomMessage())
        }
        
        tableView.registerNib(UINib(nibName: "SentMessageCell", bundle: nil), forCellReuseIdentifier: "SentMessageCell")
        tableView.registerNib(UINib(nibName: "ReceivedMessageCell", bundle: nil), forCellReuseIdentifier: "ReceivedMessageCell")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let constraintSize = tableView.bounds.size
        return MessageCell.height(message: messages[indexPath.row], constraintSize: constraintSize)
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let message = messages[indexPath.row]
        var cell: MessageCell
        
        switch message.type {
        case .SentMessage:
            cell = tableView.dequeueReusableCellWithIdentifier("SentMessageCell") as MessageCell
        case .ReceivedMessage:
            cell = tableView.dequeueReusableCellWithIdentifier("ReceivedMessageCell") as MessageCell
        }
        
        cell.message = message
        
        return cell
    }
}
