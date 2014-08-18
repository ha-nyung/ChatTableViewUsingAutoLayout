//
//  MessageCell.swift
//  ChatLogsDemo
//
//  Created by Josh Chung on 8/15/14.
//  Copyright (c) 2014 Josh Chung. All rights reserved.
//

var _dateFormatter: NSDateFormatter?

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    class var dateFormatter: NSDateFormatter {
        if _dateFormatter == nil {
            _dateFormatter = NSDateFormatter()
            _dateFormatter?.dateStyle = NSDateFormatterStyle.NoStyle
            _dateFormatter?.timeStyle = NSDateFormatterStyle.MediumStyle
        }
        return _dateFormatter!
    }
    
    var message: Message? {
        didSet {
            if nameLabel != nil {
                nameLabel.text = message?.senderName
            }
            if profileImageView != nil {
                profileImageView.image = UIImage(named: "face")
            }
            messageLabel.text = message?.message
            updatedAtLabel.text = MessageCell.dateFormatter.stringFromDate(message?.updatedAt)
        }
    }
    
    class func reuseIdentifier(type: MessageType) -> String {
        switch type {
        case .SentMessage:
            return "SentMessageCell"
        case .ReceivedMessage:
            return "ReceivedMessageCell"
        }
    }
    
    class func height(#message: Message, constraintSize: CGSize) -> CGFloat {
        let dateString: NSString = NSString(string: dateFormatter.stringFromDate(message.updatedAt))
        let dateSize = dateString.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(10)])
        var messageWidthConstraint = constraintSize.width - dateSize.width - 14 - 8 - 5 - 10
        if message.type == MessageType.ReceivedMessage {
            messageWidthConstraint -= 8 + 44 + 8;
        }
        
        let contentSize = NSString(string: message.message).boundingRectWithSize(CGSizeMake(messageWidthConstraint, CGFloat.max),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12)],
            context: nil)
        return max(contentSize.height, 20) + (message.type == .SentMessage ? 20 : 38)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageLabel.preferredMaxLayoutWidth = bounds.width - updatedAtLabel.frame.width - 42
        if message?.type == MessageType.ReceivedMessage {
            messageLabel.preferredMaxLayoutWidth -= 60
        }
    }
}
