//
//  AppDelegate.swift
//  ChatLogsDemoOSX
//
//  Created by Josh Chung on 8/17/14.
//  Copyright (c) 2014 Josh Chung. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var windowController: WindowController?
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        windowController = WindowController(windowNibName: "Main")
        windowController?.showWindow(self)
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

