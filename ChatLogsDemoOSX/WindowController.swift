//
//  WindowController.swift
//  ChatLogsDemo
//
//  Created by Josh Chung on 8/18/14.
//  Copyright (c) 2014 Josh Chung. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var tableView: NSTableView!
    var messages: [Message] = []
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        for i in 0...10 {
            messages.append(createRandomMessage())
        }
        
        tableView.registerNib(NSNib(nibNamed: "SentMessageCell", bundle: nil), forIdentifier: "SentMessageCell")
        tableView.registerNib(NSNib(nibNamed: "ReceivedMessageCell", bundle: nil), forIdentifier: "ReceivedMessageCell")
        
        tableView.reloadData()
    }

    func numberOfRowsInTableView(tableView: NSTableView!) -> Int {
        return messages.count
    }

    func tableView(tableView: NSTableView!, heightOfRow row: Int) -> CGFloat {
        let message = messages[row]
        let rect = tableView.rectOfColumn(0)
        return OSXMessageCell.height(message: message, constraintSize: NSMakeSize(rect.width, CGFloat.max)) + 20
    }
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView! {
        let message = messages[row]
        
        if message.type == MessageType.SentMessage {
            let cell = tableView.makeViewWithIdentifier("SentMessageCell", owner: nil) as OSXMessageCell
            cell.message = message
            return cell
        } else {
            let cell = tableView.makeViewWithIdentifier("ReceivedMessageCell", owner: nil) as OSXMessageCell
            cell.message = message
            return cell
        }
    }
    
    func tableViewColumnDidResize(notification: NSNotification!) {
        let rowRange = NSMakeRange(0, tableView.numberOfRows)
        NSAnimationContext.beginGrouping()
        NSAnimationContext.currentContext().duration = 0
        tableView.noteHeightOfRowsWithIndexesChanged(NSIndexSet(indexesInRange: rowRange))
        NSAnimationContext.endGrouping()
    }
}
