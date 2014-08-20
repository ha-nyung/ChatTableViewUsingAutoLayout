//
//  OSXMessageCell.swift
//  ChatLogsDemo
//
//  Created by Josh Chung on 8/18/14.
//  Copyright (c) 2014 Josh Chung. All rights reserved.
//

import Cocoa

var _dateFormatter: NSDateFormatter?

class OSXMessageCell: NSTableCellView {

    @IBOutlet weak var profileImageView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var bubbleImageView: NSImageView!
    @IBOutlet weak var updatedAtLabel: NSTextField!
    
    var messageTextView: MyTextView?
    var messageTextViewHorizontalConstraints: [AnyObject] = []
    var message: Message? {
        didSet {
            if nameLabel != nil {
                nameLabel.stringValue = message?.senderName
            }
            if profileImageView != nil {
                profileImageView.image = NSImage(named: "face")
            }
            messageTextView?.string = message?.message
            updatedAtLabel.stringValue = OSXMessageCell.dateFormatter.stringFromDate(message!.updatedAt)
            
            self.needsUpdateConstraints = true
        }
    }
    
    class var dateFormatter: NSDateFormatter {
        if _dateFormatter == nil {
            _dateFormatter = NSDateFormatter()
            _dateFormatter?.dateStyle = NSDateFormatterStyle.NoStyle
            _dateFormatter?.timeStyle = NSDateFormatterStyle.MediumStyle
        }
        return _dateFormatter!
    }
    
    override func awakeFromNib() {
        messageTextView = MyTextView()
        if let textView = messageTextView {
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.verticallyResizable = false
            textView.horizontallyResizable = false
            textView.editable = false
            textView.backgroundColor = nil
            textView.font = NSFont.systemFontOfSize(12)
            self.addSubview(textView)
            
            self.addConstraint(NSLayoutConstraint(item: textView, attribute: .Top, relatedBy: .Equal, toItem: bubbleImageView, attribute: .Top, multiplier: 1, constant: 5))
            self.addConstraint(NSLayoutConstraint(item: textView, attribute: .Bottom, relatedBy: .Equal, toItem: bubbleImageView, attribute: .Bottom, multiplier: 1, constant: -5))
        }
    }
    
    override func updateConstraints() {
        if let textView = messageTextView {
            self.removeConstraints(messageTextViewHorizontalConstraints)
            messageTextViewHorizontalConstraints.removeAll(keepCapacity: true)
            
            if message?.type == MessageType.SentMessage {
                messageTextViewHorizontalConstraints.append(NSLayoutConstraint(item: textView, attribute: .Leading, relatedBy: .Equal, toItem: bubbleImageView, attribute: .Leading, multiplier: 1, constant: 8))
                messageTextViewHorizontalConstraints.append(NSLayoutConstraint(item: textView, attribute: .Trailing, relatedBy: .Equal, toItem: bubbleImageView, attribute: .Trailing, multiplier: 1, constant: -14))
            } else {
                messageTextViewHorizontalConstraints.append(NSLayoutConstraint(item: textView, attribute: .Leading, relatedBy: .Equal, toItem: bubbleImageView, attribute: .Leading, multiplier: 1, constant: 14))
                messageTextViewHorizontalConstraints.append(NSLayoutConstraint(item: textView, attribute: .Trailing, relatedBy: .Equal, toItem: bubbleImageView, attribute: .Trailing, multiplier: 1, constant: -8))
            }
            
            self.addConstraints(messageTextViewHorizontalConstraints)
        }
        
        super.updateConstraints()
    }
    
    override func layout() {
        super.layout()
        
        var maxWidth = bounds.width - updatedAtLabel.frame.width - 37
        if message?.type == MessageType.ReceivedMessage {
            maxWidth -= 60
        }
        messageTextView?.preferredMaxLayoutWidth = maxWidth
    }
    
    class func height(#message: Message, constraintSize: NSSize) -> CGFloat {
        let dateString: NSString = NSString(string: dateFormatter.stringFromDate(message.updatedAt))
        let dateSize = dateString.sizeWithAttributes([NSFontAttributeName: NSFont.systemFontOfSize(10)])
        var messageWidthConstraint = constraintSize.width - dateSize.width - 14 - 8 - 5 - 10
        if message.type == MessageType.ReceivedMessage {
            messageWidthConstraint -= 8 + 44 + 8;
        }
        
        var attributedString = NSAttributedString(string: message.message, attributes: [NSForegroundColorAttributeName: NSFont.systemFontOfSize(11)])
        let contentSize = MyTextView.contentSize(attributedString, constraintSize: NSMakeSize(messageWidthConstraint, CGFloat.max))
        return max(contentSize.height, 20) + (message.type == .SentMessage ? 20 : 38)
    }
}
