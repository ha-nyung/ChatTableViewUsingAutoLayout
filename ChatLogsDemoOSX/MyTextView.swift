//
//  MyTextView.swift
//  ChatLogsDemo
//
//  Created by Josh Chung on 8/18/14.
//  Copyright (c) 2014 Josh Chung. All rights reserved.
//

import Cocoa

class MyTextView: NSTextView {
    var preferredMaxLayoutWidth: CGFloat? {
        didSet {
            if preferredMaxLayoutWidth != oldValue {
                self.invalidateIntrinsicContentSize()
            }
        }
    }
    
    override var intrinsicContentSize: NSSize {
        if let maxWidth = preferredMaxLayoutWidth {
            return MyTextView.contentSize(attributedString(), constraintSize: NSMakeSize(maxWidth, CGFloat.max))
        } else {
            return NSMakeSize(NSViewNoInstrinsicMetric, NSViewNoInstrinsicMetric)
        }
    }
    
    class func contentSize(text: NSAttributedString, constraintSize: NSSize) -> NSSize {
        let textStorage = NSTextStorage(attributedString: text)
        let textContainer = NSTextContainer(containerSize: constraintSize)
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        layoutManager.glyphRangeForTextContainer(textContainer)
        let contentSize = layoutManager.usedRectForTextContainer(textContainer).size
        return NSMakeSize(ceil(contentSize.width), ceil(contentSize.height))
    }
}
