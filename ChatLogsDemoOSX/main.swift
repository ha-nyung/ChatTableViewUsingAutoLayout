//
//  main.swift
//  ChatLogsDemoOSX
//
//  Created by Josh Chung on 8/17/14.
//  Copyright (c) 2014 Josh Chung. All rights reserved.
//

import Cocoa

//NSApplicationMain(C_ARGC, C_ARGV)

let app = NSApplication.sharedApplication()
let appDelegate = AppDelegate()
app.delegate = appDelegate
app.run()